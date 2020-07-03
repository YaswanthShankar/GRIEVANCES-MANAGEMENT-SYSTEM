<?php 
include_once 'connection.php';
extract($_POST);
$sql1 ="update data set state ={$state} where id ={$id}";

$value=mysqli_query($conn,$sql1);
$res = array();
$res['query'] = $sql1;
echo "hi";
echo json_encode($res);
?>