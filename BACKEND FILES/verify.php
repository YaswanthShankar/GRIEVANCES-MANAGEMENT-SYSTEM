<?php
require 'connection.php';
include 'tokken.php';
if($azp == $value1||$azp==$value2)
{
$sql="select usr.Email,usr.Acctype, dt.department ,dt.id from user usr inner join department dt on usr.D_id = dt.id where usr.Email = '{$email}'";
//$sql="select * from user where Email='{$email}' limit 1";
$result  = mysqli_query($conn, $sql);
$res['login'] = true;
$res['email']=$email;
$res['user'] = false;
$res['admin'] = false;
if(mysqli_num_rows($result)==1){

	$res['user'] = true;

$row = mysqli_fetch_assoc($result);
if($row['Acctype'] == 1){
	$res['admin'] = true;
	
       
}


}

}

echo json_encode($res);
?>