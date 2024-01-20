<?php
require_once 'firebaseLibFirestore.php';
$projectID = 'smart-toilet-f1337';
$tokenFirestore = '';

date_default_timezone_set('Asia/Jakarta');
$resultTime = (new DateTime())->format("Y/m/d H:i:s:u");

$fbFirestore = new FirebaseFirestore($tokenFirestore, $projectID);
$response = $fbFirestore->getNameForToday('schedule');
printf($resultTime . " => " . $response);
