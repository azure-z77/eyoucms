<?php

$dir_arr = array();
$delfile_arr = array();
foreach (['public','template'] as $key => $val) {
    delDirFile($val, $delfile_arr);
	array_push($dir_arr, $val.'/');
}
$dirstr = implode('<br/>', $dir_arr);

if (empty($delfile_arr)) {
	$str = '没发现可疑文件！';
	$filestr = '';
} else {
	$str = '<font color="red">清除可疑文件成功！</font>';
	$filestr = '<br/><br/><strong>可疑文件：</strong><br/>'.implode('<br/>', $delfile_arr);
}

die(sprintf('%s<br/><br/><strong>扫描目录：</strong><br/>%s%s',$str,$dirstr,$filestr));

// 刪除指定文件
function delDirFile($dirpath, &$delfile_arr, $ext = 'php|php3|php4|php5|php7|pht|phtml|asp|aspx|jsp|exe')
{
    $fileList = getDirFile($dirpath);
    foreach ($fileList as $key => $val) {
        if (stristr($val, 'UEditorSnapscreen.exe')) {
            continue;
        }
        if (preg_match('/\.('.$ext.')$/i', $val)) {
            $file = $dirpath.DIRECTORY_SEPARATOR.$val;
			array_push($delfile_arr, $file);
            @unlink($file);
        }
    }
}

// 递归读取文件夹文件
function getDirFile($directory, $dir_name='', &$arr_file = array()) {
    if (!file_exists($directory) ) {
        return false;
    }

    $mydir = dir($directory);
    while($file = $mydir->read())
    {
        if((is_dir("$directory/$file")) AND ($file != ".") AND ($file != ".."))
        {
            if ($dir_name) {
                getDirFile("$directory/$file", "$dir_name/$file", $arr_file);
            } else {
                getDirFile("$directory/$file", "$file", $arr_file);
            }
            
        }
        else if(($file != ".") AND ($file != ".."))
        {
            if ($dir_name) {
                $arr_file[] = "$dir_name/$file";
            } else {
                $arr_file[] = "$file";
            }
        }
    }
    $mydir->close();

    return $arr_file;
}

?>