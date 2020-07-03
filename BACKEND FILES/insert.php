<?php 
include_once 'connection.php';
extract($_POST);
$sql= "insert into data (name,phonenumber,email,Dp_id,Description,Pics,Date_Time)values('{$name}','{$phonenumber}',
'{$email}','{$catageory}','{$Description}','{$Pics}','{$Date}')";
if(mysqli_query($conn,$sql)){
$res['result']="success";
}
else{$res['result']="failed".mysqli_error($conn);}
$res['post'] = $_POST;
echo json_encode($res);
?>