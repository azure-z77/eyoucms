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

namespace think\template\taglib\eyou;

/**
 * 会员中心
 */
class TagUser extends Base
{
    /**
     * 会员ID
     */
    public $users_id = 0;

    //初始化
    protected function _initialize()
    {
        parent::_initialize();
        // 会员信息
        $this->users_id = session('users_id');
        $this->users_id = !empty($this->users_id) ? $this->users_id : 0;
    }

    /**
     * 会员中心
     * @author wengxianhu by 2018-4-20
     */
    public function getUser($type = 'default', $img = '', $currentstyle = '')
    {
        $result = false;

        if ($this->home_lang != $this->main_lang) {
            return false;
        }

        $web_users_switch = tpCache('web.web_users_switch');
        $users_open_register = getUsersConfigData('users.users_open_register');

        if ('open' == $type) {
            if (empty($web_users_switch) || 1 == $users_open_register) {
                return false;
            }
        }

        if (1 == intval($web_users_switch)) {
            if (empty($users_open_register)) {
                $url = '';
                switch ($type) {
                    case 'login':
                    case 'centre':
                    case 'reg':
                    case 'logout':
                        $url = url('user/Users/'.$type);
                        break;

                    default:
                        # code...
                        break;
                }

                $t = getTime();
                // A标签ID
                $result['id'] = "ey_{$type}_{$t}";
                // A标签里的文案ID
                $result['txtid'] = "ey_{$type}_txt_{$t}";
                // 文字文案
                // $result['txt'] = $txt;
                // IMG标签里的ID
                // $result['imgid'] = "ey_{$type}_img_{$t}";
                // 图片文案
                $result['img'] = $img;
                // 链接
                $result['url'] = $url;
                // 标签类型
                $result['type'] = $type;
                // 子目录
                $result['root_dir'] = $this->root_dir;
                // 图片样式类
                $result['currentstyle'] = $currentstyle;

                $result_json = json_encode($result);
                $version = getCmsVersion();

                $hidden = '';
                switch ($type) {
                    case 'login':
                    case 'reg':
                    case 'logout':
                        $hidden = <<<EOF
<script type="text/javascript" src="{$this->root_dir}/public/static/common/js/tag_user.js?v={$version}"></script>
<script type="text/javascript">
    var tag_user_result_json = {$result_json};
    tag_user(tag_user_result_json);
</script>
EOF;
                        break;
                }
                $result['hidden'] = $hidden;
            }
        }

        switch ($type) {
            case 'info':
                return $this->getUserInfo();
                break;
        }

        return $result;
    }

    /**
     * 获取用户信息
     */
    private function getUserInfo()
    {
        $users = M('users')->field('b.*, a.*')
            ->alias('a')
            ->join('__USERS_LEVEL__ b', 'a.level = b.level_id', 'LEFT')
            ->where([
                'a.users_id' => $this->users_id,
                'a.lang'     => $this->home_lang,  
            ])->find();

        return $users;
    }
}