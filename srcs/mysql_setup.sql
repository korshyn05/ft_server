CREATE DATABASE wordpress;
CREATE USER 'tludwig'@'localhost' IDENTIFIED BY 'tludwig';
GRANT ALL PRIVILEGES ON wordpress.* TO 'tludwig'@'localhost';
FLUSH PRIVILEGES;