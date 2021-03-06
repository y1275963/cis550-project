# DDL code to initialize schema
CREATE TABLE users (
    username VARCHAR(20) NOT NULL PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    fb_id NUMBER,
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);

CREATE TABLE friends (
    user1 VARCHAR(20) NOT NULL,
    user2 VARCHAR(20) NOT NULL,
    PRIMARY KEY (user1, user2),
    FOREIGN KEY (user1) REFERENCES users(username),
    FOREIGN KEY (user2) REFERENCES users(username)
);

# weak entity, one user can save multiple addresses
CREATE TABLE address (
	address_label VARCHAR(30) NOT NULL,
	username VARCHAR(20) NOT NULL,
	address VARCHAR(150) NOT NULL,
	lat FLOAT(15) NOT NULL,
	lon FLOAT(15) NOT NULL,
	PRIMARY KEY (username, address_label),
	FOREIGN KEY (username) REFERENCES users ON DELETE CASCADE
);

CREATE TABLE groups (
    group_id INTEGER NOT NULL PRIMARY KEY,
    group_name VARCHAR(20) NOT NULL
);

CREATE TABLE in_group (
    group_id INTEGER NOT NULL,
    username VARCHAR(20) NOT NULL,
    PRIMARY KEY (group_id, username),
    FOREIGN KEY (group_id) REFERENCES groups,
    FOREIGN KEY (username) REFERENCES users
);

CREATE TABLE restaurant (
    rid VARCHAR(30) NOT NULL PRIMARY KEY,
    name VARCHAR(70) NOT NULL,
    stars FLOAT(4),
    address VARCHAR(115) NOT NULL,
    lat FLOAT(15) NOT NULL,
    lon FLOAT(15) NOT NULL,
    city VARCHAR(50),
    state CHAR(4),
    review_count INTEGER
);

CREATE TABLE hours (
   sunday_open CHAR(5),
   sunday_close CHAR(5),
   monday_open CHAR(5),
   monday_close CHAR(5),
   tuesday_open CHAR(5),
   tuesday_close CHAR(5),
   wednesday_open CHAR(5),
   wednesday_close CHAR(5),
   thursday_open CHAR(5),
   thursday_close CHAR(5),
   friday_open CHAR(5),
   friday_close CHAR(5),
   saturday_open CHAR(5),
   saturday_close CHAR(5),
   rid VARCHAR(30) NOT NULL PRIMARY KEY,
   FOREIGN KEY (rid) REFERENCES restaurant ON DELETE CASCADE
);

CREATE TABLE category (
    category_name VARCHAR(35) NOT NULL,
    rid VARCHAR(30) NOT NULL,
    PRIMARY KEY (category_name, rid),
    FOREIGN KEY (rid) REFERENCES restaurant
);

CREATE TABLE group_fav (
    group_id INTEGER NOT NULL,
    rid VARCHAR(30) NOT NULL,
    PRIMARY KEY (group_id, rid),
    FOREIGN KEY (group_id) REFERENCES groups,
    FOREIGN KEY (rid) REFERENCES restaurant
);

CREATE TABLE user_fav (
    username VARCHAR(20) NOT NULL,
    rid VARCHAR(30) NOT NULL,
    PRIMARY KEY (username, rid),
    FOREIGN KEY (username) REFERENCES users,
    FOREIGN KEY (rid) REFERENCES restaurant
);

drop table user_fav;
drop table group_fav;
drop table category;
drop table hours;
