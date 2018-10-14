# Create a User

CREATE USER 'user_name'@'localhost' IDENTIFIED BY ‘PASSWORD’;

GRANT SELECT ON website.* TO 'user_name'@'localhost';
GRANT UPDATE ON website.* TO 'user_name'@'localhost';
GRANT CREATE ON website.* TO 'user_name'@'localhost';
GRANT DELETE ON website.* TO 'user_name'@'localhost';
GRANT DROP ON website.* TO 'user_name'@'localhost';
GRANT ALTER ON website.* TO 'user_name'@'localhost';
GRANT INSERT ON website.* TO 'user_name'@'localhost';
GRANT DROP ON website.* TO 'user_name'@'localhost';

GRANT LOCK TABLES ON website.* TO 'user_name'@'localhost';

SHOW GRANTS FOR 'user_name'@'localhost';