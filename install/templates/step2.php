<!doctype html>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="Content-Language" content="zh-cn"/>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<title><?php echo $Title; ?> - <?php echo $Powered; ?></title>
<link rel="stylesheet" href="./css/install.css?v=9.0" />
<style type="text/css">
.btn_a{ width: 58px; }
#table td{ text-align: center; }
#table td.first{ text-align: left; }
</style>
</head>
<body>
<div class="wrap">
  <?php require './templates/header.php';?>
  <section class="section">
    <div class="blank30"></div>
    <div class="go go2"></div>
    <div class="blank30"></div>
    <div class="server">
      <table width="100%" id="table" cellspacing="1">
        <tr>
          <td class="td1">环境检测</td>
          <td class="td1" width="23%">推荐配置</td>
          <td class="td1" width="46%">当前状态</td>
        </tr>
        <tr>
          <td class="first">服务器环境</td>
          <td>IIS/apache2.0以上/nginx1.6以上</td>
          <td><?php echo $_SERVER['SERVER_SOFTWARE']; ?></td>
        </tr>
        <tr>
          <td class="first">PHP版本</td>
          <td>>5.4.x</td>
          <td><?php echo $phpvStr; ?></td>
        </tr>
        <tr>
          <td class="first">safe_mode</td>
          <td>基础配置</td>
          <td><?php echo $safe_mode; ?></td>
        </tr>
        <tr>
          <td class="first">GD库</td>
          <td>必须开启</td>
          <td><?php echo $gd; ?></td>
        </tr>
        <tr>
          <td class="first">mysqli</td>
          <td>必须开启</td>
          <td><?php echo $mysql; ?></td>
        </tr>
        <tr>
          <td class="first">pdo</td>
          <td>必须开启</td>
          <td><?php echo $pdo; ?></td>
        </tr>
        <tr>
          <td class="first">pdo_mysql</td>
          <td>必须开启</td>
          <td><?php echo $pdo_mysql; ?></td>
        </tr>
      </table>

      <table width="100%" id="table" cellspacing="1">
        <tr>
          <td class="td1">函数检测</td>
          <td class="td1" width="23%">推荐配置</td>
          <td class="td1" width="46%">是否通过</td>
        </tr>
        <tr>
          <td class="first">curl_init</td>
          <td>必须扩展</td>
          <td><?php echo $curl; ?></td>
        </tr>
        <tr>
          <td class="first">file_put_contents</td>
          <td>建议开启</td>
          <td><?php echo $file_put_contents; ?></td>
        </tr>
        <tr>
          <td class="first">scandir</td>
          <td><a href="http://www.eyoucms.com/bbs/823.html" target="_blank">必须支持</a></td>
          <td><?php echo $scandir; ?></td>
        </tr>
      </table>

      <table width="100%" id="table" cellspacing="1">
        <tr>
          <td class="td1">目录、文件权限检查</td>
          <td class="td1" width="23%">推荐配置</td>
          <td class="td1" width="46%">是否通过</td>
        </tr>
		<?php
		foreach($folder as $dir){
		     $Testdir = SITEDIR.$dir;
			 //echo "<br/>";
		         dir_create($Testdir);
			 if(TestWrite($Testdir)){
			     $w = '<img src="images/ok.png">';
			 }else{
			     $w = '<img src="images/del.png">';
				 $err++;
			 }
			 
		?>
		        <tr>
		          <td class="first"><?php echo $dir; ?></td>
		          <td>读写</td>
		          <td><?php echo $w; ?></td>
		        </tr>
		<?php
		}                
		?>   
                <tr>
                  <td class="first">application/database.php</td>
                  <td>读写</td>
                  <?php
                     if (is_writable(SITEDIR.'application/database.php')){
                        echo "<td><img src='images/ok.png'></td>";                 
                     }else{
                         $err++;
                        echo "<td><img src='images/del.png'></td>";                        
                     }
                  ?>
                </tr>            
                <tr>
                  <td class="first">application/config.php</td>
                  <td>读写</td>
                  <?php
                     if (is_writable(SITEDIR.'application/config.php')){
                        echo "<td><img src='images/ok.png'></td>";                 
                     }else{
                         $err++;
                        echo "<td><img src='images/del.png'></td>";                        
                     }
                  ?>
                </tr>                                 
      </table>
      
    </div>
    <div class="bottom tac"> 
      <div class="blank20"></div>
      <center>
	    <a href="<?php echo $_SERVER['PHP_SELF']; ?>?step=2" class="btn_b">重新检测</a>
	    <?php if($err>0){?>
	    <a href="javascript:void(0)" onClick="javascript:alert('安装环境检测未通过，请检查')" class="btn_a" style="background: gray;">下一步</a> 
	    <?php }else{?>
	    <a href="<?php echo $_SERVER['PHP_SELF']; ?>?step=3" class="btn_a">下一步</a> 
	    <?php }?>
      </center>
    </div>
  </section>
</div>
 <div class="blank20"></div>
<?php require './templates/footer.php';?>
</body>
</html>