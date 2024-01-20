<?php

$firestoreUrl = 'https://firestore.googleapis.com/v1/projects/smart-toilet-f1337/databases/(default)/documents:runQuery';

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
        "from" => [["collectionId" => "schedule"]]
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

// die(curl_exec($ch));

$data = json_decode(curl_exec($ch), true);
if ($data !== null) {
    foreach ($data as $item) {
        if (isset($item['document']['fields']['date']['timestampValue'])) {
            $timestamp = $item['document']['fields']['date']['timestampValue'];
            $date = date('Y-m-d', strtotime($timestamp));
            $targetTimestamp = $date;
            $currentTimestamp = date('Y-m-d', time());
            if ($targetTimestamp == $currentTimestamp) {
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
