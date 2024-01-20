<?php
require_once 'firebaseLibFCM.php';
require_once 'firebaseLibFirestore.php';

$projectID = 'smart-toilet-f1337';
$tokenFirestore = '';

$url = 'https://smart-toilet-f1337-default-rtdb.firebaseio.com';
$tokenFCM = 'AAAAfnL1vdg:APA91bFaSChDm4c03c2cR9j3WqX_U_-crdZePsMJqY199VdkmBxocqW6PHB7VGMJEsJ7946giMN-eDpclXRYtQmpFV4ZVZIXdZ-AQufyeFojm8E55G2LVx7pPXkDxD_utBIl2m2uAhGm';

$fbFirestore = new FirebaseFirestore($tokenFirestore, $projectID);
$fullName = $fbFirestore->getNameForToday('schedule');

if (isset($fullName)) {
    $fbFCM = new FireBaseFCM($tokenFCM);
    $response = $fbFCM->setNotification("Jadwal Kerja", "Hari ini jadwalnya " . $fullName);
    printf("Result: %s\n", $response);
}
