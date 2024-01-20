<?php

/**
 * Firebase PHP Client Library
 *
 * @author Tamas Kalman <ktamas77@gmail.com>
 * @link   https://www.firebase.com/docs/rest-api.html
 *
 */

/**
 * Firebase PHP Class
 *
 * @author Tamas Kalman <ktamas77@gmail.com>
 * @link   https://www.firebase.com/docs/rest-api.html
 *
 */
class FirebaseFCM
{

    private $_baseURI;
    private $_timeout;
    private $_tokenFCM;

    /**
     * Constructor
     *
     * @param String $baseURI Base URI
     *
     * @return void
     */
    function __construct($tokenFCM = '')
    {
        if (!extension_loaded('curl')) {
            trigger_error('Extension CURL is not loaded.', E_USER_ERROR);
        }

        $this->setTimeOut(10);
        $this->setTokenFCM($tokenFCM);
    }

    /**
     * Sets Token FCM
     *
     * @param String $token Token FCM
     *
     * @return void
     */
    public function setTokenFCM($token)
    {
        $this->_tokenFCM = $token;
    }

    /**
     * Sets REST call timeout in seconds
     *
     * @param Integer $seconds Seconds to timeout
     *
     * @return void
     */
    public function setTimeOut($seconds)
    {
        $this->_timeout = $seconds;
    }

    /**
     * Returns with the normalized JSON absolute path
     *
     * @param String $path to data
     */
    public function setNotification($title, $body)
    {
        $msg =
            [
                'title'   => "This is From PHP Arduino",
                'message'   => "Sending Notification to All Devices",
            ];

        $notification = [
            "title" => $title,
            "body" => $body,
            // "sound" => "default",
            "click_action" => "MAIN_ACTIVITY",
            // "icon" => "fcm_push_icon"
        ];

        $fields =
            [
                'to' => '/topics/allDevices',
                "notification" => $notification,
                'data'      => $msg
            ];

        $headers =
            [
                'Authorization: key=' . $this->_tokenFCM,
                'Content-Type: application/json'
            ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
        $result = curl_exec($ch);
        curl_close($ch);
        return $result;
    }
}
