CREATE TABLE IF NOT EXISTS user (id BIGINT PRIMARY KEY, name VARCHAR(50), login VARCHAR(50), password VARCHAR(50));
CREATE TABLE IF NOT EXISTS role (id BIGINT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE IF NOT EXISTS user_role (user_id BIGINT NOT NULL,role_id BIGINT  NOT NULL);

-- if u want use jdbc tokenstore, than use schema-oauth-mysql.sql