<?php
require_once 'firebaseLibFCM.php';
$url = 'https://smart-toilet-f1337-default-rtdb.firebaseio.com';
$tokenFCM = 'AAAAfnL1vdg:APA91bFaSChDm4c03c2cR9j3WqX_U_-crdZePsMJqY199VdkmBxocqW6PHB7VGMJEsJ7946giMN-eDpclXRYtQmpFV4ZVZIXdZ-AQufyeFojm8E55G2LVx7pPXkDxD_utBIl2m2uAhGm';

if (empty($_GET['title']) || empty($_GET['notification'])) {
    die("Data Invalid");
}

date_default_timezone_set('Asia/Bangkok');
$resultTime = (new DateTime())->format("Y/m/d H:i:s:u");

$fbFCM = new FirebaseFCM($tokenFCM);
$response = $fbFCM->setNotification($_GET['title'], $_GET['notification']);
printf($resultTime . " " . $response);
