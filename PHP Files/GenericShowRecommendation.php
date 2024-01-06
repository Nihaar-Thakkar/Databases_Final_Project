<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<?php
$mysqli = new mysqli("dbase.cs.jhu.edu", "23fa_nthakka7", "LWHe8weh9f", "23fa_nthakka7_db");

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s<br>", mysqli_connect_error());
    exit();
}

$year = (int)$_POST['year'];

if ($mysqli->multi_query("CALL GenericShowRecommendation('".$year."');")) {
    $resultCounter = 0;

    do {
        if ($result = $mysqli->store_result()) {
            $firstRow = $result->fetch_assoc();

            // Check if the result set is not empty
            if ($firstRow !== null) {
                // Output table header
                echo '<table border="1">';
                echo '<tr><th>originalTitle</th><th>averageRating</th><th>genres</th></tr>';
                echo '<tr>';

                foreach ($firstRow as $value) {
                    echo '<td>' . $value . '</td>';
                }

                echo '</tr>';

                // Output the rest of the rows
                while ($row = $result->fetch_row()) {
                    echo '<tr>';
                    foreach ($row as $value) {
                        echo '<td>' . $value . '</td>';
                    }
                    echo '</tr>';
                }

                echo '</table>';

                // Add spacing between tables
                echo '<br>';
            }

            $result->close();
            $resultCounter++;

            // Move to the next result set
            $mysqli->next_result();
        }
    } while ($mysqli->more_results());

    if ($resultCounter === 0) {
        // No results were found
        echo '<p>No results found.</p>';
    }
} else {
    printf("<br>Error: %s\n", $mysqli->error);
}

$mysqli->close();
?>

</body>
</html>