<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>密码修改工具 - 易优CMS</title>
</head>
<body>
<?php
    error_reporting(E_ALL & ~E_NOTICE);
    header('Content-Type: text/html; charset=UTF-8');

    $database = include_once "application/database.php";
    $dbHost = trim($database['hostname']);
    $dbport = $database['hostport'] ? $database['hostport'] : '3306';
    $dbName = trim($database['database']);
    $dbUser = trim($database['username']);
    $dbPwd = trim($database['password']);
    $dbPrefix = empty($database['prefix']) ? 'ey_' : trim($database['prefix']);
    $charset = trim($database['charset']);

    $conn = @mysqli_connect($dbHost, $dbUser, $dbPwd,$dbName,$dbport);
    if (mysqli_connect_errno($conn)){
        $msg = "连接数据库失败!".mysqli_connect_error($conn);
        tips($msg);
    }
    mysqli_set_charset($conn, $charset);

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {

        $user_name = $_POST['user_name'];
        $password = $_POST['password'];
        if (empty($password)) {
            tips("新密码不能为空！");
        }

        $config = include_once "application/config.php";
        $auth_code = $config['AUTH_CODE'];
        $password = md5($auth_code.$password);

        $sql = "UPDATE `{$dbPrefix}admin` SET `password`='{$password}' WHERE `user_name`='{$user_name}'";
        $ret = mysqli_query($conn,$sql);
        if ($ret) {
            $msg = "修改成功";
        } else {
            $msg = "修改失败，请联系技术！";
        }

        tips($msg);

    } else {

        $sql = "SELECT * FROM `{$dbPrefix}admin`";
        $ret = mysqli_query($conn,$sql);
        $select_html = "";
        while($row = mysqli_fetch_array($ret))
        {
            $select_html .= "<option value='{$row['user_name']}'>{$row['user_name']}</option>";
        }

    }
    mysqli_close($conn);

    function tips($msg)
    {
        die('<script type="text/javascript">alert("'.$msg.'");window.location.href = "setpwd.php";</script>');
    }
?>

易优CMS - 修改密码小工具<br/><br/>
<form action="setpwd.php" method="post" id="post_form">
    用户名：
    <select name="user_name">
        <?php echo $select_html;?>
    </select><br/><br/>
    新密码：<input type="password" name="password" value=""><br/><br/>
    <input type="submit" name="submit" value="确认修改">
</form>
</body>
</html>