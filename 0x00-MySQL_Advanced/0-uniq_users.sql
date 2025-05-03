-- Create a table 'users' with id, email, and name attributes
-- 'id' is auto incremented and primary key
-- 'email' is unique and not null
-- 'name' is a string with a maximum length of 255 characters

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- id is the primary key, auto incremented
    email VARCHAR(255) NOT NULL UNIQUE,     -- email is unique and cannot be NULL
    name VARCHAR(255)                       -- name is a string, can be NULL
);
