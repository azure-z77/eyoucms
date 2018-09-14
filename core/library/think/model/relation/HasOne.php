<?php

namespace think\model\relation;

use think\db\Query;
use think\Loader;
use think\Model;

class HasOne extends OneToOne
{
    /**
     * 构造函数
     * @access public
     * @param Model  $parent     上级模型对象
     * @param string $model      模型名
     * @param string $foreignKey 关联外键
     * @param string $localKey   当前模型主键
     * @param string $joinType   JOIN类型
     */
    public function __construct(Model $parent, $model, $foreignKey, $localKey, $joinType = 'INNER')
    {
        $this->parent     = $parent;
        $this->model      = $model;
        $this->foreignKey = $foreignKey;
        $this->localKey   = $localKey;
        $this->joinType   = $joinType;
        $this->query      = (new $model)->db();
    }

    /**
     * 延迟获取关联数据
     * @param string   $subRelation 子关联名
     * @param \Closure $closure     闭包查询条件
     * @return array|false|\PDOStatement|string|Model
     */
    public function getRelation($subRelation = '', $closure = null)
    {
        // 执行关联定义方法
        $localKey = $this->localKey;
        if ($closure) {
            call_user_func_array($closure, [ & $this->query]);
        }
        // 判断关联类型执行查询
        $relationModel = $this->query->where($this->foreignKey, $this->parent->$localKey)->relation($subRelation)->find();

        if ($relationModel) {
            $relationModel->setParent(clone $this->parent);
        }

        return $relationModel;
    }

    /**
     * 根据关联条件查询当前模型
     * @access public
     * @return Query
     */
    public function has()
    {
        $table      = $this->query->getTable();
        $localKey   = $this->localKey;
        $foreignKey = $this->foreignKey;
        return $this->parent->db()->alias('a')
            ->whereExists(function ($query) use ($table, $localKey, $foreignKey) {
                $query->table([$table => 'b'])->field('b.' . $foreignKey)->whereExp('a.' . $localKey, '=b.' . $foreignKey);
            });
    }

    /**
     * 根据关联条件查询当前模型
     * @access public
     * @param mixed $where 查询条件（数组或者闭包）
     * @return Query
     */
    public function hasWhere($where = [])
    {
        $table    = $this->query->getTable();
        $model    = basename(str_replace('\\', '/', get_class($this->parent)));
        $relation = basename(str_replace('\\', '/', $this->model));

        if (is_array($where)) {
            foreach ($where as $key => $val) {
                if (false === strpos($key, '.')) {
                    $where[$relation . '.' . $key] = $val;
                    unset($where[$key]);
                }
            }
        }
        return $this->parent->db()->alias($model)
            ->field($model . '.*')
            ->join($table . ' ' . $relation, $model . '.' . $this->localKey . '=' . $relation . '.' . $this->foreignKey, $this->joinType)
            ->where($where);
    }

    /**
     * 预载入关联查询（数据集）
     * @access public
     * @param array    $resultSet   数据集
     * @param string   $relation    当前关联名
     * @param string   $subRelation 子关联名
     * @param \Closure $closure     闭包
     * @return void
     */
    protected function eagerlySet(&$resultSet, $relation, $subRelation, $closure)
    {
        $localKey   = $this->localKey;
        $foreignKey = $this->foreignKey;

        $range = [];
        foreach ($resultSet as $result) {
            // 获取关联外键列表
            if (isset($result->$localKey)) {
                $range[] = $result->$localKey;
            }
        }

        if (!empty($range)) {
            $data = $this->eagerlyWhere($this, [
                $foreignKey => [
                    'in',
                    $range,
                ],
            ], $foreignKey, $relation, $subRelation, $closure);
            // 关联属性名
            $attr = Loader::parseName($relation);
            // 关联数据封装
            foreach ($resultSet as $result) {
                // 关联模型
                if (!isset($data[$result->$localKey])) {
                    $relationModel = null;
                } else {
                    $relationModel = $data[$result->$localKey];
                    $relationModel->setParent(clone $result);
                    $relationModel->isUpdate(true);
                    if (!empty($this->bindAttr)) {
                        // 绑定关联属性
                        $this->bindAttr($relationModel, $result, $this->bindAttr);
                    }
                }
                // 设置关联属性
                $result->setRelation($attr, $relationModel);
            }
        }
    }

    /**
     * 预载入关联查询（数据）
     * @access public
     * @param Model    $result      数据对象
     * @param string   $relation    当前关联名
     * @param string   $subRelation 子关联名
     * @param \Closure $closure     闭包
     * @return void
     */
    protected function eagerlyOne(&$result, $relation, $subRelation, $closure)
    {
        $localKey   = $this->localKey;
        $foreignKey = $this->foreignKey;
        $data       = $this->eagerlyWhere($this, [$foreignKey => $result->$localKey], $foreignKey, $relation, $subRelation, $closure);

        // 关联模型
        if (!isset($data[$result->$localKey])) {
            $relationModel = null;
        } else {
            $relationModel = $data[$result->$localKey];
            $relationModel->setParent(clone $result);
            $relationModel->isUpdate(true);
            if (!empty($this->bindAttr)) {
                // 绑定关联属性
                $this->bindAttr($relationModel, $result, $this->bindAttr);
            }
        }

        $result->setRelation(Loader::parseName($relation), $relationModel);
    }

}
