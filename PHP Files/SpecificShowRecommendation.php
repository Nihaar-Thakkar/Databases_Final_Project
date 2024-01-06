<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<?php
$mysqli= new mysqli("dbase.cs.jhu.edu","23fa_nthakka7","LWHe8weh9f","23fa_nthakka7_db");
/* check connection */
if (mysqli_connect_errno()) {
printf("Connect failed: %s<br>", mysqli_connect_error());
exit();
}

$year = (int)$_POST['year']; 
$genre = $_POST['genre']; 

if ($mysqli->multi_query("CALL SpecificShowRecommendation('".$year."','".$genre."');")) {
    do {
        if ($result = $mysqli->store_result()) {
            $firstRow = $result->fetch_assoc();
            if (isset($firstRow['Error Message'])) 
            {
                echo '<p>Error: ' . $firstRow['Error Message'] . '</p>';
            } 
            else
            {
                echo '<table border="1">';
                echo '<tr><th>originalTitle</th><th>averageRating</th><th>genres</th></tr>';
                echo '<tr>';
                    foreach ($firstRow as $value) 
                    {
                        echo '<td>' . $value . '</td>';
                    }
                    echo '</tr>';
                while ($row = $result->fetch_row()) 
                {
                    echo '<tr>';
                    foreach ($row as $value) 
                    {
                        echo '<td>' . $value . '</td>';
                    }
                    echo '</tr>';
                }
                $result->close();
            }
        }
    } while ($mysqli->more_results()); 

    echo '</table>';
}
else {
    printf("<br>Error: %s\n", $mysqli->error);
}



?>

</body>
</html>