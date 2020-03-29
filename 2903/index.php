<?php

if(isset($_POST['username']) && isset($_POST['password']))
{
  $username = $_POST['username'];
  $password = $_POST['password'];

  if(!empty($username) && !empty($password))
  {
    $mysqli = new mysqli("localhost","akhil","1234","lab");

    if ($mysqli -> connect_errno) {
      echo "Failed to connect to MySQL: " . $mysqli -> connect_error;
      exit();
    }

    if ($result = $mysqli -> query("SELECT * FROM users WHERE username='$username' AND password='$password'")) {
      $user = $result->fetch_assoc();

      if($user){
      echo 'Hello ' . $user['name'] ;

      }else{
        echo 'Username or Password is incorrect';
      }
    }

    $mysqli -> close();
  }

}
?>


<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Login Page</title>
  </head>
  <body>


    <form class="form" action="index.php" method="post">
      <input type="text" name="username" placeholder="Username">
      <input type="password" name="password" placeholder="Password">
      <input type="submit" value="Login">
    </form>

    <div class="info">
      <small>Username: admin</small>
      <small>Password: admin</small>
    </div>

  </body>
</html>
