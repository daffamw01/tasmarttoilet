<?php
require_once 'firebaseLib.php';
// --- This is your Firebase URL
$url = 'https://smart-toilet-f1337-default-rtdb.firebaseio.com';
// --- Use your token from Firebase here
$token = 'y58Prx5iTKnBq7qgaDE7FqUJbG64P3UKbeo8RKYZ';
// --- Here is your parameter from the http GET
$YOUR_data = $_GET['YOUR_data'];
// --- Set up your Firebase url structure here
$firebasePath = '/monitoring';

/// --- Making calls
$fb = new fireBase($url, $token);
$response = $fb->set($firebasePath, $rfidid);

sleep(2);
