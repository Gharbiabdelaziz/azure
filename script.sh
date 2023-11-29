sudo apt update
sudo apt install apache2 -y
echo "<html>
  <body style=\"background-color:green;\">
    <h1 style=\"color:white;\">Hello world</h1>
  </body>
</html>" | sudo tee /var/www/html/index.html
