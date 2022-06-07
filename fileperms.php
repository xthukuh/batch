<?php
$dir = getcwd();
$opts = getopt("r::f::");
$folder = null;
foreach (is_array($argv) ? $argv : [] as $i => $val){
	if (!$i || array_key_exists(preg_replace('/^-*/', '', $val), $opts)) continue;
	$folder = $val;
	break;
}
if ($folder){
	$tmp = realpath($folder);
	if (!(file_exists($tmp) && is_dir($tmp))){
		pr('File perms...');
		pr("\nERROR: Directory ($folder) not found!\n");
		exit(1);
	}
	$dir = $tmp;
}
$recursion = false;
if (array_key_exists('r', $opts)){
	$recursion = 1;
	if (is_numeric($tmp = $opts['r'])) $recursion = abs((int) $tmp);
}
$full_path = array_key_exists('f', $opts) && !in_array(strtolower($opts['f']), ['0', 'false']);
$GLOBALS['recursion'] = $recursion;
$GLOBALS['full_path'] = $full_path;
$GLOBALS['root_path'] = $dir;
$GLOBALS['sep'] = $sep = DIRECTORY_SEPARATOR;
$tmp = '';
if ($recursion) $tmp .= 'recursion=' . json_encode($recursion);
if ($full_path) $tmp .= ($tmp !== '' ? ',' : '') . 'full-path';
pr(sprintf("File perms...%s", $tmp ? " ($tmp)" : ''));
pr("");
pr(sprintf('-d-%s %s%s', get_perms($dir), $full_path ? $dir : '.', $sep));
$done = dir_perms($dir);
pr("");
exit($done ? 0 : 1);

function pr($str){
	echo "$str\n";
}

function get_perms($path){
	return substr(sprintf('%o', fileperms($path)), -4);
	return fileperms($path);
}

function dir_perms($dir, $depth=0, $sp='   '){
	if (!(file_exists($dir) && is_dir($dir))) return pr("ERROR: Invalid dir path. ($dir)");
	$recurse = 0;
	$recursion = $GLOBALS['recursion'];
	$full_path = $GLOBALS['full_path'];
	$root_path = $GLOBALS['root_path'];
	$sep = $GLOBALS['sep'];
	$folders = [];
	if ($recursion === true) $recurse = 1;
	elseif (is_integer($recursion) && $recursion > 0 && $depth < $recursion) $recurse = 1;
	foreach (scandir($dir) as $item){
		if (in_array($item, ['.', '..'])) continue;
		$path = $dir . $sep . $item;
		$name = $full_path ? $path : str_replace($root_path . $sep, '', $path);
		$perms = get_perms($path);
		if (is_dir($path)) $folders[] = [$path, $name, $perms];
		else pr(sprintf('-f-%s%s%s', $perms, $sp, $name));
	}
	foreach ($folders as $arr){
		$path = $arr[0];
		$name = $arr[1];
		$perms = $arr[2];
		pr(sprintf('-d-%s%s%s%s', $perms, $sp, $name, $recurse ? $sep : ''));
		if ($recurse && !dir_perms($path, $depth + 1, $sp . $sp)) return false;
	}
	return true;
}