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
    if($res['login'] == true)
    {
        $temp = "select * from data where  email = '{$email}' and state = 1 ";
        $query =  mysqli_query($conn, $temp);
        while($fetch = mysqli_fetch_array($query)){
            $greven[] = $fetch;
        }
        $res['greven'] = $greven;         
    }
}
echo json_encode($res);
?>
