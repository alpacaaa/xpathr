<?php

	header('Content-type: text/css');

	$css = @filemtime('style.css');
	$lss = filemtime('style.less');

	if ($css > $lss && !isset($_GET['force']))
		die(file_get_contents('style.css'));

	require_once 'less.inc.php';

	$less = new lessc('style.less');
	$data = $less->parse();

	file_put_contents('style.css', $data);
	echo $data;
