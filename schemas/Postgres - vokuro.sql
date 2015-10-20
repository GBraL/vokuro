-- Postgres SQL Dump
-- Database: vokuro
--

-- Role: vokuro

-- DROP ROLE vokuro;

CREATE ROLE vokuro LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

ALTER ROLE vokuro ENCRYPTED PASSWORD 'md51f0f6dea0e2c82c271cfc7612d4ae8f6'; -- Password = 123456789

CREATE DATABASE vokuro
  WITH OWNER = "vokuro"
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       CONNECTION LIMIT = -1;

-- --------------------------------------------------------

--
-- Table structure for table profiles
--

DROP TABLE IF EXISTS profiles;
CREATE TABLE IF NOT EXISTS profiles (
  id serial  NOT NULL ,
  name varchar(64) NOT NULL,
  active varchar(1) NOT NULL,
  PRIMARY KEY (id)
);

--
-- Dumping data for table profiles
--

INSERT INTO profiles (id, name, active) VALUES
(1, 'Administrators', 'Y'),
(2, 'Users', 'Y'),
(3, 'Read-Only', 'Y');
SELECT PG_CATALOG.SETVAL('profiles_id_seq', 3, TRUE);

-- --------------------------------------------------------

--
-- Table structure for table users
--

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id serial  NOT NULL ,
  name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(60) NOT NULL,
  mustChangePassword varchar(1) DEFAULT NULL,
  profilesId int4  NOT NULL,
  banned varchar(1) NOT NULL,
  suspended varchar(1) NOT NULL,
  active varchar(1) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT profilesId FOREIGN KEY (profilesId)
      REFERENCES Profiles (ID)
      ON DELETE RESTRICT ON UPDATE RESTRICT
) ;

-- --------------------------------------------------------

--
-- Table structure for table email_confirmations
--

DROP TABLE IF EXISTS email_confirmations;
CREATE TABLE IF NOT EXISTS email_confirmations (
  id serial NOT NULL,
  usersId int4  NOT NULL,
  code varchar(32) NOT NULL,
  createdAt timestamp without time zone NOT NULL DEFAULT now(),
  modifiedat timestamp without time zone DEFAULT NULL,
  confirmed varchar(1) DEFAULT 'N',
  PRIMARY KEY (id)
);

-- --------------------------------------------------------

--
-- Table structure for table failed_logins
--

DROP TABLE IF EXISTS failed_logins;
CREATE TABLE IF NOT EXISTS failed_logins (
  id serial  NOT NULL ,
  usersId int4  DEFAULT NULL,
  ipAddress varchar(15) NOT NULL,
  attempted timestamp without time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  CONSTRAINT usersId FOREIGN KEY (usersId)
      REFERENCES Users (ID)
      ON DELETE RESTRICT ON UPDATE RESTRICT
) ;

-- --------------------------------------------------------

--
-- Table structure for table password_changes
--

DROP TABLE IF EXISTS password_changes;
CREATE TABLE IF NOT EXISTS password_changes (
  id serial  NOT NULL ,
  usersId int4  NOT NULL,
  ipAddress varchar(15) NOT NULL,
  userAgent varchar(150) NOT NULL,
  createdAt timestamp without time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  CONSTRAINT usersId FOREIGN KEY (usersId)
      REFERENCES Users (ID)
      ON DELETE RESTRICT ON UPDATE RESTRICT
) ;

-- --------------------------------------------------------

--
-- Table structure for table permissions
--

DROP TABLE IF EXISTS permissions;
CREATE TABLE IF NOT EXISTS permissions (
  id serial  NOT NULL ,
  profilesId int4  NOT NULL,
  resource varchar(16) NOT NULL,
  action varchar(16) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT profilesId FOREIGN KEY (profilesId)
      REFERENCES Profiles (ID)
      ON DELETE RESTRICT ON UPDATE RESTRICT
) ;

--
-- Dumping data for table permissions
--

INSERT INTO permissions (id, profilesId, resource, action) VALUES
(1, 3, 'users', 'index'),
(2, 3, 'users', 'search'),
(3, 3, 'profiles', 'index'),
(4, 3, 'profiles', 'search'),
(5, 1, 'users', 'index'),
(6, 1, 'users', 'search'),
(7, 1, 'users', 'edit'),
(8, 1, 'users', 'create'),
(9, 1, 'users', 'delete'),
(10, 1, 'users', 'changePassword'),
(11, 1, 'profiles', 'index'),
(12, 1, 'profiles', 'search'),
(13, 1, 'profiles', 'edit'),
(14, 1, 'profiles', 'create'),
(15, 1, 'profiles', 'delete'),
(16, 1, 'permissions', 'index'),
(17, 2, 'users', 'index'),
(18, 2, 'users', 'search'),
(19, 2, 'users', 'edit'),
(20, 2, 'users', 'create'),
(21, 2, 'profiles', 'index'),
(22, 2, 'profiles', 'search'),
(23, 2, 'permissions', 'search'),
(24, 2, 'permissions', 'save');
SELECT PG_CATALOG.SETVAL('permissions_id_seq', 24, TRUE);
-- --------------------------------------------------------

--
-- Table structure for table remember_tokens
--

DROP TABLE IF EXISTS remember_tokens;
CREATE TABLE IF NOT EXISTS remember_tokens (
  id serial  NOT NULL ,
  usersId int4  NOT NULL,
  token varchar(32) NOT NULL,
  userAgent varchar(150) NOT NULL,
  createdAt timestamp without time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
)  ;

-- --------------------------------------------------------

--
-- Table structure for table reset_passwords
--

DROP TABLE IF EXISTS reset_passwords;
CREATE TABLE IF NOT EXISTS reset_passwords (
  id serial  NOT NULL ,
  usersId int4  NOT NULL,
  code varchar(48) NOT NULL,
  createdAt timestamp without time zone NOT NULL DEFAULT now(),
  modifiedat timestamp without time zone DEFAULT NULL,
  reset varchar(1) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT usersId FOREIGN KEY (usersId)
      REFERENCES Users (ID)
      ON DELETE RESTRICT ON UPDATE RESTRICT
)  ;

-- --------------------------------------------------------

--
-- Table structure for table success_logins
--

DROP TABLE IF EXISTS success_logins;
CREATE TABLE IF NOT EXISTS success_logins (
  id serial  NOT NULL ,
  usersId int4  NOT NULL,
  ipAddress varchar(15) NOT NULL,
  userAgent varchar(150) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT usersId FOREIGN KEY (usersId)
      REFERENCES Users (ID)
      ON DELETE RESTRICT ON UPDATE RESTRICT
)  ;

--
-- Dumping data for table users
--

INSERT INTO users (id, name, email, password, mustChangePassword, profilesId, banned, suspended, active) VALUES
(1, 'Bob Burnquist', 'bob@phalconphp.com', '$2a$08$Lx1577KNhPa9lzFYKssadetmbhaveRtCoVaOnoXXxUIhrqlCJYWCW', 'N', 1, 'N', 'N', 'Y'),
(2, 'Erik', 'erik@phalconphp.com', '$2a$08$f4llgFQQnhPKzpGmY1sOuuu23nYfXYM/EVOpnjjvAmbxxDxG3pbX.', 'N', 1, 'Y', 'Y', 'Y'),
(3, 'Veronica', 'veronica@phalconphp.com', '$2a$08$NQjrh9fKdMHSdpzhMj0xcOSwJQwMfpuDMzgtRyA89ADKUbsFZ94C2', 'N', 1, 'N', 'N', 'Y'),
(4, 'Yukimi Nagano', 'yukimi@phalconphp.com', '$2a$08$cxxpy4Jvt6Q3xGKgMWIILuf75RQDSroenvoB7L..GlXoGkVEMoSr.', 'N', 2, 'N', 'N', 'Y');
SELECT PG_CATALOG.SETVAL('users_id_seq', 4, TRUE);
