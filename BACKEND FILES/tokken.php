<?php
$json= file_get_contents("https://www.googleapis.com/oauth2/v3/tokeninfo?access_token={$_GET['token']}");
$json=json_decode($json,true);
$azp= $json['azp'];
$email= $json['email'];
$res= array();
$res['login']=false;
$value1= '983084414142-r8il4fo4fsmulsbjis1p7jdhtpl5uotm.apps.googleusercontent.com';
$value2 = '983084414142-ff1j5arab2l5h8qetnlu6c68cl7idki4.apps.googleusercontent.com';
?>