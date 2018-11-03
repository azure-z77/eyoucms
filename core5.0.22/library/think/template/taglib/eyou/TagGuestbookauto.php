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
 * 留言自动表单
 */
class TagGuestbookauto
{
    public $tid = '';
    public $inputstyle = '';
    public $btnstyle = '';
    
    //初始化
    protected function _initialize()
    {
        parent::_initialize();
        $this->tid = I("param.tid/s", ''); // 应用于栏目列表
        /*tid为目录名称的情况下*/
        $this->tid = $this->getTrueTypeid($this->tid);
        /*--end*/
    }

    /**
     * 获取留言表单
     * @author wengxianhu by 2018-4-20
     */
    public function getGuestbookauto($typeid = '', $require = '', $inputstyle = 'guest-input', $btnstyle = 'guest-btn')
    {
        $typeid = !empty($typeid) ? $typeid : $this->tid;

        if (empty($typeid)) {
            echo '标签guestbookauto报错：缺少属性 typeid 值。';
            return false;
        }

        $this->inputstyle = $inputstyle;
        $this->btnstyle = $btnstyle;

        $formstart = '<form method="POST" class="guest-form" id="guest-form" enctype="multipart/form-data" action="'.url('home/Guestbook/submit').'" onsubmit="return checkForm();">';
        $form_arr = $this->getAttrInput($typeid);

        $javascript_str = '';
        $require_arr = explode(',', $require);
        if (is_array($require_arr) && count($require_arr) > 0) {
            foreach ($form_arr as $key => $val) {
                $i = $key + 1;
                if (in_array($i, $require_arr)) {
                    $javascript_str .= <<<EOF
if(document.getElementById('attr_{$i}').value.length == 0)
{
    alert("{$val['attr_name']}不能为空！");
    $("#attr_{$i}").focus();
    return false;
}

EOF;
                }
            }
        }

        $hidden = '<input type="hidden" name="typeid" value="'.$typeid.'">';
        $formend = '<div class="div-guest-submit">'.$hidden.'<input type="submit" id="guest_submit" class="'.$this->btnstyle.'" value="提交"/></div></form>';
        $formend .= <<<EOF
<script type="text/javascript">
    function checkForm() {
        {$javascript_str}
        $('#guest-form').submit();
    }
</script>
EOF;

        $result = array(
            'formstart' => $formstart,
            'list'  => $form_arr,
            'formend' => $formend,
        );
        
        return $result;
    }

    /**
     * 动态获取留言栏目属性输入框 根据不同的数据返回不同的输入框类型
     * @param int $typeid 留言栏目id
     */
    public function getAttrInput($typeid)
    {
        header("Content-type: text/html; charset=utf-8");
        $attributeList = M('GuestbookAttribute')->where("typeid = $typeid")->order('sort_order asc')->select();
        $form_arr = array();
        $i = 1;
        foreach($attributeList as $key => $val)
        {
            $str = "";
            switch ($val['attr_input_type']) {
                case '0':
                    $str = "<input class='guest-input ".$this->inputstyle."' id='attr_".$i."' type='text' value='".$val['attr_values']."' name='attr_{$val['attr_id']}[]' placeholder='".$val['attr_name']."'/>";
                    break;
                
                case '1':
                    $str = "<select class='guest-select ".$this->inputstyle."' id='attr_".$i."' name='attr_{$val['attr_id']}[]'><option value=''>无</option>";
                    $tmp_option_val = explode(PHP_EOL, $val['attr_values']);
                    foreach($tmp_option_val as $k2=>$v2)
                    {
                        $str .= "<option value='{$v2}'>{$v2}</option>";
                    }
                    $str .= "</select>";
                    break;
                
                case '2':
                    $str = "<textarea class='guest-textarea ".$this->inputstyle."' id='attr_".$i."' cols='40' rows='3' name='attr_{$val['attr_id']}[]' placeholder='".$val['attr_name']."'>".$val['attr_values']."</textarea>";
                    break;
                
                default:
                    # code...
                    break;
            }

            $i++;

            $form_arr[$key] = array(
                'value' => $str,
                'attr_name' => $val['attr_name'],
            );
        }        
        return  $form_arr;
    }
}