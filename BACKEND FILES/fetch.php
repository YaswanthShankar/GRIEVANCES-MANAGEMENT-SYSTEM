<?php
require 'connection.php';
include 'tokken.php';
$res['user'] = false;
$res['admin'] = false;
if ($azp == $value1 || $azp == $value2) {
	$sql = "select usr.Email,usr.Acctype, dt.department ,dt.id from user usr inner join department dt on usr.D_id = dt.id where usr.Email = '{$email}'";
	$result  = mysqli_query($conn, $sql);
	$res['login'] = true;
	if (mysqli_num_rows($result) == 1) {
		$res['user'] = true;
	}
	$row = mysqli_fetch_assoc($result);
	if ($row['Acctype'] == 1) {
		$dId = $row['id'];
		$greven = array();
		$sql1 = "select d.*,dt.department from department dt inner join user usr on dt.id = usr.D_id inner join data d on dt.id = d.Dp_id where d.state =1 and usr.D_id=$dId";
		$result1 = mysqli_query($conn, $sql1);
		while($row1 = mysqli_fetch_assoc($result1)){
			$greven[] = $row1;
		}
		$res['greven'] = $greven;
	}
	if ($row['Acctype'] == 0) {
		$dId = $row['id'];
		$greven = array();
		$sql1 = "select d.*,dt.department from department dt inner join user usr on dt.id = usr.D_id inner join data d on dt.id = d.Dp_id where d.state =1 and usr.D_id=$dId";
		$result1 = mysqli_query($conn, $sql1);
		while($row1 = mysqli_fetch_assoc($result1)){
			$greven[] = $row1;
		}
		$res['greven'] = $greven;
	}
}
echo json_encode($res);
?>