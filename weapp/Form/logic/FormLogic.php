<?php
/**
 * 易优CMS
 * ============================================================================
 * 版权所有 2016-2028 海南赞赞网络科技有限公司，并保留所有权利。
 * 网站地址: http://www.eyoucms.com
 * ----------------------------------------------------------------------------
 * 如果商业用途务必到官方购买正版授权, 以免引起不必要的法律纠纷.
 * ============================================================================
 * Author: 小虎哥 <1105415366@qq.com>
 * Date: 2018-4-3
 */

namespace weapp\Form\logic;

use weapp\Form\model\FormModel;
use weapp\Form\model\FormAttrbute;
use app\admin\logic\FieldLogic;

use think\Validate;
use think\Db;
use think\Config;

/**
 * 业务逻辑
 */
load_trait('controller/Jump');
class FormLogic
{
	use \traits\controller\Jump;
	/**
	 * 自定义表单验证
	 * @var array
	 */
    protected $formRule = [
        'name|名称'  =>  'require|max:20',
        'tag|标识' =>  'require|max:20|unique:weapp_form'
    ];

    /**
     * 自定义表单字段验证
     * @var array
     */
    protected $attrbuteRule = [
        'form_tag|标识' =>  'require|max:20',
        'attr_name|名称' =>  'require|max:20',
        'attr_tag|标识' =>  'require|max:20|unique:weapp_form_attrbute,form_tag^attr_tag',
        'attr_type|类型' =>  'require'
    ];

    /**
     * 析构函数
     */
    function __construct() 
    {
        $this->model = new FormModel;
        $this->attrbute = new FormAttrbute;
        $this->fieldLogic = new FieldLogic;
    }
    /**
     * 添加自定义表单
     * @param  array $data 表单数据
     * @return bool
     */
	public function addForm($data)
	{
		//表单验证
		$validate = new Validate($this->formRule);
		if (!$validate->check($data)) {
			$this->error($validate->getError());
		}

		//创建表
		try{
			$prefix = Config::get('database.prefix');
			Db::execute("CREATE TABLE {$prefix}weapp_form_{$data['tag']}(id int primary key auto_increment)");
		} catch (\Exception $e) {
		    $this->error($e->getMessage());
		}

		//插入数据
		$res = $this->model->insert($data);
		return $res === false ? false : true;
	}

	public function deleteForm($id)
	{
		//验证标识
		if(!$form = $this->model->find($id)){
			$this->error('此表单不存在');
		}

		//删除表
		try{
			$prefix = Config::get('database.prefix');
			Db::execute("DROP TABLE {$prefix}weapp_form_{$form['tag']}");
		} catch (\Exception $e) {
		    $this->error($e->getMessage());
		}

		//删除数据
		$res = $form->delete();
		return $res === false ? false : true;
	}

    /**
     * 添加自定义表单字段
     * @param  array $data 表单数据
     * @return bool
     */
	public function addAttrbute($data)
	{
		//表单验证
		$validate = new Validate($this->attrbuteRule);
		if (!$validate->check($data)) {
			$this->error($validate->getError());
		}

		//生成字段sql
        $fieldinfos = $this->fieldLogic->GetFieldMake($data['attr_type'], $data['attr_tag'], $data['attr_value'], $data['attr_name']);

		//添加字段
		try{
			$prefix = Config::get('database.prefix');
			Db::execute("ALTER TABLE `{$prefix}weapp_form_{$data['form_tag']}` ADD {$fieldinfos['0']}");
		} catch (\Exception $e) {
		    $this->error($e->getMessage());
		}

		//插入数据
		$res = $this->attrbute->insert($data);
		return $res === false ? false : true;
	}

	public function deleteAttrbute($id)
	{
		$attrbute = $this->attrbute->find($id);

		//验证字段
		if(!$this->checkAttrbuteTag($attrbute)){
			$this->error('此字段不存在');
		}

		//删除表
		try{
			$prefix = Config::get('database.prefix');
			Db::execute("ALTER TABLE `{$prefix}weapp_form_{$attrbute['form_tag']}` DROP COLUMN {$attrbute['attr_tag']}");
		} catch (\Exception $e) {
		    $this->error($e->getMessage());
		}

		//删除数据
		$res = $attrbute->delete();
		return $res === false ? false : true;
	}



	/**
	 * 检测自定义表单字段标识
	 * @param  array $data 表单数据
	 * @return object
	 */
	public function checkAttrbuteTag($data)
	{
		$where = [
			'form_tag' => $data['form_tag'],
			'attr_tag' => $data['attr_tag'],
		];
		$res = $this->attrbute->where($where)->find();
		return $res;
	}

}
