
DROP TABLE IF EXISTS ORDER_LINE;
DROP TABLE IF EXISTS NEW_ORDER;
DROP TABLE IF EXISTS STOCK;
DROP TABLE IF EXISTS OORDER;
DROP TABLE IF EXISTS HISTORY;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS DISTRICT;
DROP TABLE IF EXISTS ITEM;
DROP TABLE IF EXISTS WAREHOUSE;

CREATE TABLE WAREHOUSE (
  W_ID INT NOT NULL,
  W_YTD DECIMAL(12,2) NOT NULL,
  W_TAX DECIMAL(4,4) NOT NULL,
  W_NAME VARCHAR(10) NOT NULL,
  W_STREET_1 VARCHAR(20) NOT NULL,
  W_STREET_2 VARCHAR(20) NOT NULL,
  W_CITY VARCHAR(20) NOT NULL,
  W_STATE VARCHAR(2) NOT NULL,
  W_ZIP VARCHAR(9) NOT NULL,
  PRIMARY KEY (W_ID)
);

CREATE TABLE DISTRICT (
  D_W_ID INT NOT NULL,
  D_ID INT NOT NULL,
  D_YTD DECIMAL(12,2) NOT NULL,
  D_TAX DECIMAL(4,4) NOT NULL,
  D_NEXT_O_ID INT NOT NULL,
  D_NAME VARCHAR(10) NOT NULL,
  D_STREET_1 VARCHAR(20) NOT NULL,
  D_STREET_2 VARCHAR(20) NOT NULL,
  D_CITY VARCHAR(20) NOT NULL,
  D_STATE VARCHAR(2) NOT NULL,
  D_ZIP VARCHAR(9) NOT NULL,
  PRIMARY KEY (D_W_ID,D_ID)
);

-- TODO: C_SINCE ON UPDATE CURRENT_TIMESTAMP,
CREATE TABLE CUSTOMER (
  C_W_ID INT NOT NULL,
  C_D_ID INT NOT NULL,
  C_ID INT NOT NULL,
  C_DISCOUNT DECIMAL(4,4) NOT NULL,
  C_CREDIT VARCHAR(2) NOT NULL,
  C_LAST VARCHAR(16) NOT NULL,
  C_FIRST VARCHAR(16) NOT NULL,
  C_CREDIT_LIM DECIMAL(12,2) NOT NULL,
  C_BALANCE DECIMAL(12,2) NOT NULL,
  C_YTD_PAYMENT REAL NOT NULL,
  C_PAYMENT_CNT INT NOT NULL,
  C_DELIVERY_CNT INT NOT NULL,
  C_STREET_1 VARCHAR(20) NOT NULL,
  C_STREET_2 VARCHAR(20) NOT NULL,
  C_CITY VARCHAR(20) NOT NULL,
  C_STATE VARCHAR(2) NOT NULL,
  C_ZIP VARCHAR(9) NOT NULL,
  C_PHONE VARCHAR(16) NOT NULL,
  C_SINCE TIMESTAMP NOT NULL,
  C_MIDDLE VARCHAR(2) NOT NULL,
  C_DATA VARCHAR(500) NOT NULL,
  PRIMARY KEY (C_W_ID, C_D_ID, C_ID)
);

-- TODO: O_ENTRY_D  ON UPDATE CURRENT_TIMESTAMP
CREATE TABLE OORDER (
  O_W_ID INT NOT NULL,
  O_D_ID INT NOT NULL,
  O_ID INT NOT NULL,
  O_C_ID INT NOT NULL,
  O_CARRIER_ID INT NULL,
  O_OL_CNT DECIMAL(2,0) NOT NULL,
  O_ALL_LOCAL DECIMAL(1,0) NOT NULL,
  O_ENTRY_D TIMESTAMP NOT NULL,
  PRIMARY KEY (O_W_ID,O_D_ID,O_ID),
  UNIQUE (O_W_ID,O_D_ID,O_C_ID,O_ID)
);

CREATE TABLE NEW_ORDER (
  NO_W_ID INT NOT NULL,
  NO_D_ID INT NOT NULL,
  NO_O_ID INT NOT NULL,
  PRIMARY KEY (NO_W_ID,NO_D_ID,NO_O_ID)
);

-- TODO: H_DATE ON UPDATE CURRENT_TIMESTAMP
CREATE TABLE HISTORY (
  H_C_ID INT NOT NULL,
  H_C_D_ID INT NOT NULL,
  H_C_W_ID INT NOT NULL,
  H_D_ID INT NOT NULL,
  H_W_ID INT NOT NULL,
  H_DATE TIMESTAMP NOT NULL,
  H_AMOUNT DECIMAL(6,2) NOT NULL,
  H_DATA VARCHAR(24) NOT NULL
);

CREATE TABLE ITEM (
  I_ID INT NOT NULL,
  I_NAME VARCHAR(24) NOT NULL,
  I_PRICE DECIMAL(5,2) NOT NULL,
  I_DATA VARCHAR(50) NOT NULL,
  I_IM_ID INT NOT NULL,
  PRIMARY KEY (I_ID)
);

CREATE TABLE STOCK (
  S_W_ID INT NOT NULL,
  S_I_ID INT NOT NULL,
  S_QUANTITY DECIMAL(4,0) NOT NULL,
  S_YTD DECIMAL(8,2) NOT NULL,
  S_ORDER_CNT INT NOT NULL,
  S_REMOTE_CNT INT NOT NULL,
  S_DATA VARCHAR(50) NOT NULL,
  S_DIST_01 VARCHAR(24) NOT NULL,
  S_DIST_02 VARCHAR(24) NOT NULL,
  S_DIST_03 VARCHAR(24) NOT NULL,
  S_DIST_04 VARCHAR(24) NOT NULL,
  S_DIST_05 VARCHAR(24) NOT NULL,
  S_DIST_06 VARCHAR(24) NOT NULL,
  S_DIST_07 VARCHAR(24) NOT NULL,
  S_DIST_08 VARCHAR(24) NOT NULL,
  S_DIST_09 VARCHAR(24) NOT NULL,
  S_DIST_10 VARCHAR(24) NOT NULL,
  PRIMARY KEY (S_W_ID, S_I_ID)
);

CREATE TABLE ORDER_LINE (
  OL_W_ID INT NOT NULL,
  OL_D_ID INT NOT NULL,
  OL_O_ID INT NOT NULL,
  OL_NUMBER INT NOT NULL,
  OL_I_ID INT NOT NULL,
  OL_DELIVERY_D TIMESTAMP,
  OL_AMOUNT DECIMAL(6,2) NOT NULL,
  OL_SUPPLY_W_ID INT NOT NULL,
  OL_QUANTITY DECIMAL(2,0) NOT NULL,
  OL_DIST_INFO VARCHAR(24) NOT NULL,
  PRIMARY KEY (OL_W_ID,OL_D_ID,OL_O_ID,OL_NUMBER)
);

ALTER TABLE CUSTOMER ADD CONSTRAINT C_FKEY_D FOREIGN KEY (C_W_ID, C_D_ID) REFERENCES DISTRICT (D_W_ID, D_ID) ON DELETE CASCADE;
ALTER TABLE DISTRICT ADD CONSTRAINT D_FKEY_W FOREIGN KEY (D_W_ID) REFERENCES WAREHOUSE (W_ID) ON DELETE CASCADE;
ALTER TABLE HISTORY ADD CONSTRAINT H_FKEY_C FOREIGN KEY (H_C_W_ID, H_C_D_ID, H_C_ID) REFERENCES CUSTOMER (C_W_ID, C_D_ID, C_ID) ON DELETE CASCADE;
ALTER TABLE HISTORY ADD CONSTRAINT H_FKEY_D FOREIGN KEY (H_W_ID, H_D_ID) REFERENCES DISTRICT (D_W_ID, D_ID) ON DELETE CASCADE;
ALTER TABLE NEW_ORDER ADD CONSTRAINT NO_FKEY_O FOREIGN KEY (NO_W_ID, NO_D_ID, NO_O_ID) REFERENCES OORDER (O_W_ID, O_D_ID, O_ID) ON DELETE CASCADE;
ALTER TABLE STOCK ADD CONSTRAINT S_FKEY_W FOREIGN KEY (S_W_ID) REFERENCES WAREHOUSE (W_ID) ON DELETE CASCADE;
ALTER TABLE STOCK ADD CONSTRAINT S_FKEY_I FOREIGN KEY (S_I_ID) REFERENCES ITEM (I_ID) ON DELETE CASCADE;
ALTER TABLE OORDER ADD CONSTRAINT O_FKEY_C FOREIGN KEY (O_W_ID, O_D_ID, O_C_ID) REFERENCES CUSTOMER (C_W_ID, C_D_ID, C_ID) ON DELETE CASCADE;
ALTER TABLE ORDER_LINE ADD CONSTRAINT OL_FKEY_O FOREIGN KEY (OL_W_ID, OL_D_ID, OL_O_ID) REFERENCES OORDER (O_W_ID, O_D_ID, O_ID) ON DELETE CASCADE;
ALTER TABLE ORDER_LINE ADD CONSTRAINT OL_FKEY_S FOREIGN KEY (OL_SUPPLY_W_ID, OL_I_ID) REFERENCES STOCK (S_W_ID, S_I_ID) ON DELETE CASCADE;

CREATE INDEX IDX_CUSTOMER_NAME ON CUSTOMER (C_W_ID,C_D_ID,C_LAST,C_FIRST);
