drop database if exists ecoBusMileSystem;
create database ecoBusMileSystem
default character set utf8
default collate utf8_general_ci;
use ecoBusMileSystem;

-- ebm_user Table Create SQL
CREATE TABLE ebm_user
(
    `uidx`  INT            NOT NULL    AUTO_INCREMENT, 
    `id`    VARCHAR(45)    NOT NULL, 
    `pw`    VARCHAR(45)    NOT NULL, 
    PRIMARY KEY (uidx),
    UNIQUE INDEX (id)
)ENGINE=InnoDB
default character set utf8
default collate utf8_general_ci;


-- ebm_card Table Create SQL
CREATE TABLE ebm_card
(
    `uidx`  INT            NOT NULL, 
    `type`  VARCHAR(15)    NOT NULL, 
    `cpw`   VARCHAR(45)    NOT NULL, 
    `cid`   VARCHAR(45)    NOT NULL, 
    PRIMARY KEY (uidx),
    UNIQUE INDEX (cid)
)ENGINE=InnoDB
default character set utf8
default collate utf8_general_ci;

ALTER TABLE ebm_card
    ADD CONSTRAINT FK_ebm_card_uidx_ebm_user_uidx FOREIGN KEY (uidx)
        REFERENCES ebm_user (uidx) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- ebm_token Table Create SQL
CREATE TABLE ebm_token
(
    `uidx`         INT             NOT NULL, 
    `accessToken`  VARCHAR(64)    NOT NULL, 
    PRIMARY KEY (uidx),
    UNIQUE INDEX (accessToken)
)ENGINE=InnoDB
default character set utf8
default collate utf8_general_ci;

ALTER TABLE ebm_token
    ADD CONSTRAINT FK_ebm_token_uidx_ebm_user_uidx FOREIGN KEY (uidx)
        REFERENCES ebm_user (uidx) ON DELETE RESTRICT ON UPDATE RESTRICT;
		
-- ebm_merchandise Table Create SQL
CREATE TABLE ebm_merchandise
(
    `id`     int            NOT NULL    AUTO_INCREMENT, 
    `kind`   varchar(64)    NULL, 
    `name`   varchar(64)    NULL, 
    `price`  int            NULL, 
    `image`  MEDIUMBLOB     NOT NULL, 
    PRIMARY KEY (id)
);


-- ebm_station Table Create SQL
CREATE TABLE ebm_station
(
    `stationnum`   int            NULL, 
    `region`       varchar(64)    NULL, 
    `stationname`  varchar(64)    NULL, 
    PRIMARY KEY (stationnum)
);


-- ebm_weather Table Create SQL
CREATE TABLE ebm_weather
(
    `id`        int            NOT NULL    AUTO_INCREMENT, 
    `region`    varchar(64)    NULL, 
    `time`      DATETIME       NULL, 
    `finedust`  float          NULL, 
    PRIMARY KEY (id)
);