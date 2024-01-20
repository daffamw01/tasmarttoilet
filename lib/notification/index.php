<?php
require_once 'firebaseLib.php';
require_once 'firebaseLibFCM.php';

$url = 'https://smart-toilet-f1337-default-rtdb.firebaseio.com';
$tokenRTDB = 'y58Prx5iTKnBq7qgaDE7FqUJbG64P3UKbeo8RKYZ';
$tokenFCM = 'AAAAfnL1vdg:APA91bFaSChDm4c03c2cR9j3WqX_U_-crdZePsMJqY199VdkmBxocqW6PHB7VGMJEsJ7946giMN-eDpclXRYtQmpFV4ZVZIXdZ-AQufyeFojm8E55G2LVx7pPXkDxD_utBIl2m2uAhGm';
$tokenFirestore = 'y58Prx5iTKnBq7qgaDE7FqUJbG64P3UKbeo8RKYZ';

date_default_timezone_set('Asia/Jakarta');

function saveSeconds()
{
    file_put_contents("micros.txt", microtime(true));
}

function getSeconds()
{
    return floatval(file_get_contents("micros.txt"));
}

if (
    empty($_GET['id']) || empty($_GET['bilik']) || empty($_GET['kelembapan']) || empty($_GET['kejernihanAir']) || empty($_GET['sabun']) ||
    empty($_GET['suhuRuang']) || empty($_GET['tingkatBau']) || empty($_GET['tissue']) || empty($_GET['volumeAir']) || empty($_GET['statusKenyamanan'])
) {
    die("Data Invalid");
}

$dataInput = [
    'bilik' => $_GET['bilik'],
    'kelembapan' => $_GET['kelembapan'],
    'kejernihanAir' => $_GET['kejernihanAir'],
    'sabun' => $_GET['sabun'],
    'suhuAir' => $_GET['suhuAir'],
    'suhuRuang' => $_GET['suhuRuang'],
    'tingkatBau' => $_GET['tingkatBau'],
    'tissue' => $_GET['tissue'],
    'volumeAir' => $_GET['volumeAir'],
    'statusKenyamanan' => $_GET['statusKenyamanan'],
];

// Retrieve Now Timestamp
$currentTimestamp = date("Y_m_d_H_i_s", strtotime("now"));
$resultTime = (new DateTime())->format("Y/m/d H:i:s:u");
printf("%s | ", $resultTime);

// Set up your Firebase url structure here
$firebasePathHistoryBilik = '/datahistory/' . $_GET['id'] . '/' . $currentTimestamp;
$firebasePathBilik = '/monitoring/' . $_GET['id'];

// Making calls RTDB
$fb = new FirebaseRTDB($url, $tokenRTDB);
$response = $fb->set($firebasePathHistoryBilik, $dataInput);
$response = $fb->set($firebasePathBilik, $dataInput);
printf("Result RTDB: %s\n", $response);

// Making calls notification FCM
printf("Time to update FCM: %s", (60 * 60) - (microtime(true) - getSeconds()));
if (microtime(true) - getSeconds() > 60 * 60) {
    $fbFCM = new FirebaseFCM($tokenFCM);
    if ($dataInput['statusKenyamanan'] < 40) {
        $response = $fbFCM->setNotification("[" . $_GET['bilik'] . "] Status Kenyamanan", "Kenyamanan toilet sekarang di bawah 40%");
        printf("Result FCM: %s\n", $response);
    }
    if ($dataInput['sabun'] < 40) {
        $response = $fbFCM->setNotification("[" . $_GET['bilik'] . "] Sabun", "Isi sabun sekarang di bawah 10%");
        printf("Result FCM: %s\n", $response);
    }
    if ($dataInput['tissue'] < 40) {
        $response = $fbFCM->setNotification("[" . $_GET['bilik'] . "] Tisu", "Isi tisu sekarang di bawah 10%");
        printf("Result FCM: %s\n", $response);
    }
    saveSeconds();
}
