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

class FirebaseFirestore
{
    private $_baseURI;
    private $_timeout;
    private $_apiKey;
    private $_projectId;

    public function __construct($apiKey, $projectId)
    {
        if (!extension_loaded('curl')) {
            trigger_error('Extension CURL is not loaded.', E_USER_ERROR);
        }

        $this->_apiKey = $apiKey;
        $this->_projectId = $projectId;

        $this->setTimeOut(10);
        $this->setBaseURI('https://firestore.googleapis.com/v1/projects/' . $projectId . '/databases/(default)/documents/');
    }

    public function setTimeOut($seconds)
    {
        $this->_timeout = $seconds;
    }

    public function setBaseURI($baseURI)
    {
        $this->_baseURI = $baseURI;
    }

    public function saveData($collection, $document, $data)
    {
        $uri = $this->_baseURI . "$collection/$document?key=" . $this->_apiKey;

        $headers = [
            'Content-Type: application/json',
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PATCH');
        curl_setopt($ch, CURLOPT_TIMEOUT, $this->_timeout);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(['fields' => $data]));

        $result = curl_exec($ch);
        curl_close($ch);

        return $result;
    }

    public function getNameForToday($collection)
    {
        $firestoreUrl = 'https://firestore.googleapis.com/v1/projects/' . $this->_projectId . '/databases/(default)/documents:runQuery';
        date_default_timezone_set('Asia/Jakarta');
        $currentDate = date('Y-m-d\T17:00:00\Z', time());
        $query = [
            "structuredQuery" => [
                "select" => [
                    "fields" => [
                        ["fieldPath" => "fullName"],
                        ["fieldPath" => "date"]
                    ]
                ],
                "where" => [
                    "fieldFilter" => [
                        "field" => ["fieldPath" => "date"],
                        "op" => "EQUAL",
                        "value" => ["timestampValue" => $currentDate]
                    ]
                ],
                "from" => [["collectionId" => $collection]]
            ]
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $firestoreUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($query));
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
        ]);

        $data = json_decode(curl_exec($ch), true);
        if ($data !== null) {
            foreach ($data as $item) {
                if (isset($item['document']['fields']['date']['timestampValue'])) {
                    $timestamp = $item['document']['fields']['date']['timestampValue'];
                    $date = new DateTime($timestamp);
                    $targetDate = $date->format('Y-m-d\TH:i:s\Z');
                    if ($targetDate == $currentDate) {
                        $fullName = $item['document']['fields']['fullName']['stringValue'];
                        return $fullName;
                    }
                }
            }
        } else {
            echo "Failed to decode JSON response.";
        }

        curl_close($ch);
        return null;
    }
    public function getData($collection, $document)
    {
        $uri = $this->_baseURI . $collection . '/' . $document;

        $headers = [
            'Authorization: Bearer ' . $this->_apiKey,
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $result = curl_exec($ch);
        curl_close($ch);

        return $result;
    }

    public function getAllData($collection)
    {
        $uri = $this->_baseURI . $collection;

        $headers = [
            // 'Authorization: Bearer ' . $this->_apiKey,
            'Authorization: Bearer ' . $this->_apiKey,
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $result = curl_exec($ch);
        curl_close($ch);

        return $result;
    }
}
