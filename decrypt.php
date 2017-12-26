<?php
define('RJ256_KY', 'lkirwf897+22#bbtrm8814z5qq=498j5'); // 32 * 8 = 256 bit key
define('RJ256_IV', '741952hheeyy66#cs!9hjv887mxx7@8y'); // 32 * 8 = 256 bit iv

$key_count = 15;

if( (isset($_POST['data']) && $_POST['data'] != "" )
    ){
    
    $data = $_POST['data'];
    print_r(json_decode(rtrim(decryptRJ256(RJ256_KY, RJ256_IV, $data))));
    
}

function decryptRJ256($key,$iv,$string_to_decrypt){
	$string_to_decrypt = base64_decode($string_to_decrypt);
	$rtn = mcrypt_decrypt(MCRYPT_RIJNDAEL_256, $key, $string_to_decrypt, MCRYPT_MODE_CBC, $iv);
	$rtn = rtrim($rtn, "");
	return $rtn;
}
?>

<html>
<head></head>
<body>
	<form action="decript.php" method="post">
		data:<input type='text' name='data' value=''><br />
		<input type="submit" value="実行">
	</form>
</body>
</html>


