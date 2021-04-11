<?php
/**
 * 易优CMS
 * ============================================================================
 * 版权所有 2016-2028 海南赞赞网络科技有限公司，并保留所有权利。
 * 网站地址: http://www.eyoucms.com
 * ----------------------------------------------------------------------------
 * 如果商业用途务必到官方购买正版授权, 以免引起不必要的法律纠纷.
 * ============================================================================
 * Author: 陈风任 <491085389@qq.com>
 * Date: 2019-7-30
 */

namespace app\home\logic;

use think\Model;
use think\Db;
use app\home\model\Ask;

/**
 * 逻辑定义
 * Class CatsLogic
 * @package plugins\Logic
 */
class AskLogic extends Model
{
    /**
     * 初始化操作
     */
    public function _initialize() {
        parent::_initialize();
    }

    // 查询条件处理
    public function GetAskWhere($param = array(), $parent_id = null)
    {
    	// 查询条件
        $where = [
        	// 0未解决，1已解决
            'a.status' 	  => ['IN',[0, 1]],
            // 问题是否审核，1是，0否
	    	'a.is_review' => 1,
	    	'a.is_del' => 0,
            'SearchName'  => null,
        ];

        // 创始人可以看到所有数据，包括未审核问题
        if (0 === $parent_id) unset($where['a.is_review']);

        // 查询指定栏目分类下的问题
        if (!empty($param['type_id'])) $where['a.type_id'] = $param['type_id'];

        // 不为空则表示查询--悬赏--待回答问题
        if (!empty($param['is_recom']) && 3 == intval($param['is_recom'])) $where['a.money']  = ['>',0];

        // 不为空则表示查询待回答问题
        if (!empty($param['is_recom']) && 2 == intval($param['is_recom'])) $where['a.replies']  = 0;

        // 推荐问题
        if (!empty($param['is_recom']) && 1 == intval($param['is_recom'])) $where['a.is_recom'] = 1;
        
        // 搜索问题
        if (!empty($param['search_name'])) {
        	$where['a.ask_title'] = ['LIKE', "%{$param['search_name']}%"];
        	$where['SearchName']  = $param['search_name'];
        }
        
        return $where;
    }

    // Url处理
    public function GetUrlData($param = array(), $SpecifyUrl = null)
    {
        if (empty($param['ask_id'])) $param['ask_id'] = 0;
    	$result = [];
    	// 最新问题url
        $result['NewDateUrl'] = askurl('home/Ask/index');
        
        // 问题详情页url
        $result['AskDetailsUrl'] = askurl('home/Ask/details', ['ask_id'=>$param['ask_id']]);

        // 推荐问题url
        $result['RecomDateUrl'] = askurl('home/Ask/index', ['type_id'=>0, 'is_recom'=>1]);

        // 等待回答url
        $result['PendingAnswerUrl'] = askurl('home/Ask/index', ['type_id'=>0, 'is_recom'=>2]);

        // 悬赏问题列表url
        $result['RewardUrl'] = askurl('home/Ask/index', ['type_id'=>0, 'is_recom'=>3]);

        // 提交回答url
        $result['AddAnswerUrl'] = askurl('home/Ask/ajax_add_answer', ['ask_id'=>$param['ask_id'], '_ajax'=>1], true, false, 1, 1, 0);

        // 删除回答url
        $result['DelAnswerUrl'] = askurl('home/Ask/ajax_del_answer', ['ask_id'=>$param['ask_id'], '_ajax'=>1], true, false, 1, 1, 0);

        // 点赞回答url
        $result['ClickLikeUrl'] = askurl('home/Ask/ajax_click_like', ['_ajax'=>1], true, false, 1, 1, 0);

		// 发布问题url
		$result['AddAskUrl'] = askurl('home/Ask/add_ask');
        // 提交问题url
        $result['SubmitAddAsk'] = askurl('home/Ask/add_ask', ['_ajax'=>1], true, false, 1, 1, 0);

		// 编辑问题url
		$result['EditAskUrl'] = askurl('home/Ask/edit_ask', ['ask_id'=>$param['ask_id']]);

		// 用户问题首页
		$result['UsersIndexUrl'] = askurl('home/Ask/ask_index');

		// 编辑回答url
		$result['EditAnswer'] = askurl('home/Ask/ajax_edit_answer');
        if ('ajax_edit_answer' == request()->action()) {
            $result['EditAnswer'] = askurl('home/Ask/ajax_edit_answer', ['_ajax'=>1], true, false, 1, 1, 0);
        }

		// 采纳最佳答案url
		$result['BestAnswerUrl'] = askurl('home/Ask/ajax_best_answer', ['ask_id'=>$param['ask_id'], '_ajax'=>1], true, false, 1, 1, 0);

        // 获取指定数量的评论数据（分页）
        $result['ShowCommentUrl'] = askurl('home/Ask/ajax_show_comment', ['ask_id'=>$param['ask_id'], '_ajax'=>1], true, false, 1, 1, 0);

        // 创始人审核评论URL(前台)
        $result['ReviewCommentUrl'] = askurl('home/Ask/ajax_review_comment', ['ask_id'=>$param['ask_id'], '_ajax'=>1], true, false, 1, 1, 0);

        // 创始人审核问题URL(前台)
        $result['ReviewAskUrl'] = askurl('home/Ask/ajax_review_ask', ['_ajax'=>1], true, false, 1, 1, 0);

		// 按点赞量排序url
		$result['AnswerLikeNum'] = askurl('home/Ask/details', ['ask_id' => $param['ask_id']], true, false, 1, 1, 0);
        
        // 等待回答url
        if (!empty($param['type_id'])) {
            $result['PendingAnswerUrl'] = askurl('home/Ask/index', ['type_id'=>$param['type_id'], 'is_recom'=>2]);
        }

        if (!empty($SpecifyUrl)) {
            if (!empty($result[$SpecifyUrl])) {
                return $result[$SpecifyUrl];
            }else{
                return $result['NewDateUrl'];
            }
        }else{
            return $result;
        }

    }

    // 关键词标红
    public function GetRedKeyWord($SearchName, $ask_title)
    {
        $ks = explode(' ',$SearchName);
        foreach($ks as $k){
            $k = trim($k);
            if($k == '') continue;
            if(ord($k[0]) > 0x80 && strlen($k) < 1) continue;
            $ask_title = str_replace($k, "<font color='red'>$k</font>", $ask_title);
        }
        return $ask_title;
    }

    // 内容转义处理
    public function ContentDealWith($param = null)
    {
    	if (!empty($param['content'])) {
            $content = $param['content'];
        }else if(!empty($param['ask_content'])){
            $content = $param['ask_content'];
        }else{
        	return false;
        }

    	// 斜杆转义
        $content = addslashes($content);
        // 过滤内容的style属性
        $content = preg_replace('/style(\s*)=(\s*)[\'|\"](.*?)[\'|\"]/i', '', $content);
        // 过滤内容的class属性
        $content = preg_replace('/class(\s*)=(\s*)[\'|\"](.*?)[\'|\"]/i', '', $content);

        return $content;
    }

    // 栏目分类格式化输出
    public function GetTypeHtmlCode($PidData = array(), $TidData = array(), $type_id = null)
    {
    	// 下拉框拼装
    	$HtmlCode = '<select name="ask_type_id" id="ask_type_id" class="input_reward">';
        $HtmlCode .= '<option value="0">请选择分类</option>';
    	foreach ($PidData as $P_key => $PidValue) {
    		/*是否默认选中*/
    		$selected = '';
    		if ($type_id == $PidValue['type_id']) $selected = 'selected';
    		/* END */

    		/*一级下拉框*/
    		$HtmlCode .= '<option value="'.$PidValue['type_id'].'" '.$selected.'>'.$PidValue['type_name'].'</option>';
    		/* END */

    		foreach ($TidData as $T_key => $TidValue) {
    			if ($TidValue['parent_id'] == $PidValue['type_id']) {
    				/*是否默认选中*/
    				$selected = '';
    				if ($type_id == $TidValue['type_id']) $selected = 'selected';
    				/* END */

    				/*二级下拉框*/
    				$HtmlCode .= '<option value="'.$TidValue['type_id'].'" '.$selected.'>&nbsp; &nbsp; &nbsp;'.$TidValue['type_name'].'</option>';
    				/* END */
    			}
    		}
    	}
    	$HtmlCode .= '</select>';
    	return $HtmlCode;
    }

    // 拼装html代码
    public function GetReplyHtml($data = array())
    {
        $ReplyHtml = '';
        // 如果是需要审核的评论则返回空
        if (empty($data['is_review'])) return $ReplyHtml;
        
        /*拼装html代码*/
        // 友好显示时间
        $data['add_time'] = friend_date($data['add_time']);
        // 处理内容格式
        $data['content']  = htmlspecialchars_decode($data['content']);
        if (!empty($data['at_users_id'])) {
            $data['content'] = '回复 @'.$data['at_usersname'].':&nbsp;'.$data['content'];
        }
        // 删除评论回答URL
        $DelAnswerUrl = $this->GetUrlData($data, 'DelAnswerUrl');

        // 拼装html
        $ReplyHtml = <<<EOF
<li class="secend-li" id="{$data['answer_id']}_answer_li">
    <div class="head-secend">
        <a><img src="{$data['head_pic']}" style="width:30px;height:30px;border-radius:100%;margin-right: 16px;"></a>
        <strong>{$data['username']}</strong>
        <span style="margin:0 10px"> | </span>
        <span>{$data['add_time']}</span>
        <div style="flex-grow:1"></div>
        <span id="{$data['answer_id']}_replyA" onclick="replyUser('{$data['answer_pid']}','{$data['users_id']}','{$data['username']}','{$data['answer_id']}')" class="secend-huifu-btn" style="cursor: pointer;">回复</span>
        &nbsp;&nbsp;|&nbsp;&nbsp;
        <a data-url="{$DelAnswerUrl}" onclick="DataDel(this, '{$data['answer_id']}', 2)" class="secend-huifu-btn" style="cursor: pointer; color:red;">删除</a>
    </div>
    <div class="secend-huifu-text">
        {$data['content']}
    </div>
</li>
EOF;
    // 返回html
    $ReturnHtml = ['review' => false, 'htmlcode' => $ReplyHtml];
    return $ReturnHtml;
    }

    // 获取指定条数的评论(分页)
    public function ForeachReplyHtml($data = array(), $parent_id = null)
    {
        $ReplyHtml = '';
        foreach ($data as $key => $value) {
            // 如果是需要审核的评论则返回空
            $review = '';
            if (empty($value['is_review']) && 0 == $parent_id) {
                // 创始人审核评论URL(前台)
                $ReviewCommentUrl = $this->GetUrlData($value, 'ReviewCommentUrl');
                $review = <<<EOF
<span id='{$value['answer_id']}_Review'>
    <span data-url='{$ReviewCommentUrl}' onclick="Review(this, '{$value['answer_id']}')" class="secend-huifu-btn" style="cursor: pointer; color: red;" title="该评论未审核，可点击审核，仅创始人可操作">审核</span>
    <span style="margin:0 10px"> | </span>
</span>
EOF;
            } else if (empty($value['is_review'])) {
                // 其他人查询数据，去除未审核评论，跳过这条数据拼装
                unset($value); continue;
            }

            /*拼装html代码*/
            if (!empty($value['at_users_id'])) {
                $value['content'] = '回复 @'.$value['at_usersname'].':&nbsp;'.$value['content'];
            }

            // 删除评论回答URL
            $DelAnswerUrl = $this->GetUrlData($value, 'DelAnswerUrl');
            // 拼装html
            $ReplyHtml .= <<<EOF
<li class="secend-li" id="{$value['answer_id']}_answer_li">
    <div class="head-secend">
        <a><img src="{$value['head_pic']}" style="width:30px;height:30px;border-radius:100%;margin-right: 16px;"></a>
        <strong>{$value['username']}</strong>
        <span style="margin:0 10px"> | </span>
        <span>{$value['add_time']}</span>
        <div style="flex-grow:1"></div>
        {$review}
        <span id="{$value['answer_id']}_replyA" onclick="replyUser('{$value['answer_pid']}','{$value['users_id']}','{$value['username']}','{$value['answer_id']}')" class="secend-huifu-btn" style="cursor: pointer;">回复</span>
        &nbsp;&nbsp;|&nbsp;&nbsp;
        <a data-url="{$DelAnswerUrl}" onclick="DataDel(this, '{$value['answer_id']}', 2)" class="secend-huifu-btn" style="cursor: pointer; color:red;">删除</a>
    </div>
    <div class="secend-huifu-text">
        {$value['content']}
    </div>
</li>
EOF;
        }

    // 返回html
    $ReturnHtml = ['review' => false, 'htmlcode' => $ReplyHtml];
    return $ReturnHtml;
    }

    /**
     * 获取SEO信息
     * @param string $inc_type [description]
     */
    public function GetSeoData($type_id = 0)
    {
        $inc_type = !empty($type_id) ? 'lists' : 'index';

        $seoInfo = [
            'seo_title' => '问答中心',
            'seo_keywords' => '',
            'seo_description' => '',
        ];

        $arctypeInfo = Db::name('arctype')->field('typename,seo_title,seo_keywords,seo_description')->where(['current_channel'=>51, 'lang'=>get_home_lang()])->order('id desc')->find();
        if ('index' == $inc_type) {
            $seoInfo['seo_title'] = !empty($arctypeInfo['seo_title']) ? $arctypeInfo['seo_title'] : $arctypeInfo['typename'];
            $seoInfo['seo_keywords'] = !empty($arctypeInfo['seo_keywords']) ? $arctypeInfo['seo_keywords'] : '';
            $seoInfo['seo_description'] = !empty($arctypeInfo['seo_description']) ? $arctypeInfo['seo_description'] : '';
        } else if ('lists' == $inc_type) {
            $result = Db::name('ask_type')->field('*')->where(['type_id'=>$type_id])->find();
            $seoInfo['seo_title'] = !empty($result['seo_title']) ? $result['seo_title'] : $result['type_name'] . ' - ' . $arctypeInfo['typename'];
            $seoInfo['seo_keywords'] = !empty($result['seo_keywords']) ? $result['seo_keywords'] : '';
            $seoInfo['seo_description'] = !empty($result['seo_description']) ? $result['seo_description'] : '';
        }

        return $seoInfo;
    }
}