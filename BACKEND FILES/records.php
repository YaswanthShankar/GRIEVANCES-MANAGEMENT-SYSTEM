<?php
include 'connection.php';
extract($_POST);
$sql= "SELECT * FROM data where DATE(Date_Time) BETWEEN DATE'{$Date_Time}' AND DATE '{$Date_Time1}'";
 $res['er']=$_POST;
$str = mysqli_query($conn,$sql);

$data= array();
while($row=mysqli_fetch_array($str)){
$data[] =$row;
}

echo json_encode($data);

?>