DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinics;

CREATE TABLE clinics (
    cid         VARCHAR(50)  PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL,
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);

CREATE TABLE customer (
    uid    VARCHAR(50)  PRIMARY KEY,
    name   VARCHAR(100) NOT NULL,
    mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
    oid           VARCHAR(50)    PRIMARY KEY,
    uid           VARCHAR(50),
    cid           VARCHAR(50),
    amount        DECIMAL(12, 2) NOT NULL,
    datetime      DATETIME       NOT NULL,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid         VARCHAR(50)    PRIMARY KEY,
    cid         VARCHAR(50),
    description TEXT,
    amount      DECIMAL(12, 2) NOT NULL,
    datetime    DATETIME       NOT NULL,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ Clinic',       'Mumbai',    'Maharashtra',  'India'),
('cnc-0100002', 'ABC Health',       'Pune',      'Maharashtra',  'India'),
('cnc-0100003', 'CareFirst Clinic', 'Bangalore', 'Karnataka',    'India'),
('cnc-0100004', 'LifeLine Clinic',  'Mysore',    'Karnataka',    'India'),
('cnc-0100005', 'MediCure Center',  'Delhi',     'Delhi',        'India'),
('cnc-0100006', 'HealWell Clinic',  'Noida',     'Uttar Pradesh','India'),
('cnc-0100007', 'WellBeing Hub',    'Chennai',   'Tamil Nadu',   'India'),
('cnc-0100008', 'PrimeCare Clinic', 'Coimbatore','Tamil Nadu',   'India');

INSERT INTO customer (uid, name, mobile) VALUES
('cust-001', 'Jon Doe',       '9712345678'),
('cust-002', 'Anita Sharma',  '9823456780'),
('cust-003', 'Ravi Verma',    '9934567891'),
('cust-004', 'Sunita Patel',  '9045678902'),
('cust-005', 'Mohan Singh',   '9156789013'),
('cust-006', 'Rekha Nair',    '9267890124'),
('cust-007', 'Arjun Mehta',   '9378901235'),
('cust-008', 'Pooja Iyer',    '9489012346'),
('cust-009', 'Vijay Kumar',   '9590123457'),
('cust-010', 'Deepa Rao',     '9601234568');

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-001-001', 'cust-001', 'cnc-0100001', 24999, '2021-01-10 10:00:00', 'online'),
('ord-001-002', 'cust-002', 'cnc-0100001', 15000, '2021-01-15 11:30:00', 'walkin'),
('ord-001-003', 'cust-003', 'cnc-0100002', 18500, '2021-01-20 09:45:00', 'sodat'),
('ord-002-001', 'cust-004', 'cnc-0100003', 22000, '2021-02-05 14:00:00', 'online'),
('ord-002-002', 'cust-005', 'cnc-0100003', 9800,  '2021-02-12 16:30:00', 'walkin'),
('ord-002-003', 'cust-001', 'cnc-0100004', 31000, '2021-02-22 10:15:00', 'sodat'),
('ord-003-001', 'cust-006', 'cnc-0100001', 14500, '2021-03-08 09:00:00', 'online'),
('ord-003-002', 'cust-007', 'cnc-0100002', 27000, '2021-03-18 13:00:00', 'walkin'),
('ord-003-003', 'cust-008', 'cnc-0100005', 8500,  '2021-03-25 15:00:00', 'sodat'),
('ord-004-001', 'cust-009', 'cnc-0100006', 19000, '2021-04-02 11:00:00', 'online'),
('ord-004-002', 'cust-010', 'cnc-0100007', 33000, '2021-04-14 12:00:00', 'walkin'),
('ord-004-003', 'cust-002', 'cnc-0100008', 11500, '2021-04-28 10:00:00', 'sodat'),
('ord-005-001', 'cust-003', 'cnc-0100001', 26000, '2021-05-06 09:30:00', 'online'),
('ord-005-002', 'cust-004', 'cnc-0100003', 17000, '2021-05-19 14:30:00', 'walkin'),
('ord-005-003', 'cust-005', 'cnc-0100004', 42000, '2021-05-30 16:00:00', 'sodat'),
('ord-006-001', 'cust-006', 'cnc-0100005', 13000, '2021-06-09 10:00:00', 'online'),
('ord-006-002', 'cust-007', 'cnc-0100006', 21000, '2021-06-20 11:30:00', 'walkin'),
('ord-006-003', 'cust-008', 'cnc-0100007', 38000, '2021-06-29 15:00:00', 'sodat'),
('ord-007-001', 'cust-009', 'cnc-0100008', 16500, '2021-07-07 09:00:00', 'online'),
('ord-007-002', 'cust-010', 'cnc-0100001', 29000, '2021-07-19 13:00:00', 'walkin'),
('ord-007-003', 'cust-001', 'cnc-0100002', 44000, '2021-07-28 14:00:00', 'sodat'),
('ord-008-001', 'cust-002', 'cnc-0100003', 12500, '2021-08-04 10:30:00', 'online'),
('ord-008-002', 'cust-003', 'cnc-0100004', 35000, '2021-08-14 12:00:00', 'walkin'),
('ord-008-003', 'cust-004', 'cnc-0100005', 23000, '2021-08-25 16:30:00', 'sodat'),
('ord-009-001', 'cust-005', 'cnc-0100006', 18000, '2021-09-01 09:00:00', 'online'),
('ord-009-002', 'cust-006', 'cnc-0100007', 27500, '2021-09-13 11:00:00', 'walkin'),
('ord-009-003', 'cust-007', 'cnc-0100008', 51000, '2021-09-23 12:03:22', 'sodat'),
('ord-010-001', 'cust-008', 'cnc-0100001', 14000, '2021-10-08 10:00:00', 'online'),
('ord-010-002', 'cust-009', 'cnc-0100002', 32000, '2021-10-19 13:00:00', 'walkin'),
('ord-010-003', 'cust-010', 'cnc-0100003', 20000, '2021-10-28 15:00:00', 'sodat'),
('ord-011-001', 'cust-001', 'cnc-0100004', 45000, '2021-11-05 09:30:00', 'online'),
('ord-011-002', 'cust-002', 'cnc-0100005', 16000, '2021-11-16 12:00:00', 'walkin'),
('ord-011-003', 'cust-003', 'cnc-0100006', 28000, '2021-11-27 14:30:00', 'sodat'),
('ord-012-001', 'cust-004', 'cnc-0100007', 39000, '2021-12-03 10:00:00', 'online'),
('ord-012-002', 'cust-005', 'cnc-0100008', 22000, '2021-12-15 11:00:00', 'walkin'),
('ord-012-003', 'cust-006', 'cnc-0100001', 55000, '2021-12-29 16:00:00', 'sodat');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-001-001', 'cnc-0100001', 'first-aid supplies',    557,  '2021-01-05 07:36:48'),
('exp-001-002', 'cnc-0100002', 'electricity bill',      3200, '2021-01-10 08:00:00'),
('exp-001-003', 'cnc-0100003', 'staff salaries',        45000,'2021-01-31 17:00:00'),
('exp-002-001', 'cnc-0100001', 'medical equipment',     8000, '2021-02-08 09:00:00'),
('exp-002-002', 'cnc-0100004', 'housekeeping',          2500, '2021-02-15 10:00:00'),
('exp-002-003', 'cnc-0100003', 'staff salaries',        45000,'2021-02-28 17:00:00'),
('exp-003-001', 'cnc-0100005', 'office supplies',       1200, '2021-03-12 09:30:00'),
('exp-003-002', 'cnc-0100001', 'maintenance',           5500, '2021-03-20 11:00:00'),
('exp-003-003', 'cnc-0100002', 'staff salaries',        40000,'2021-03-31 17:00:00'),
('exp-004-001', 'cnc-0100006', 'rent',                  15000,'2021-04-01 08:00:00'),
('exp-004-002', 'cnc-0100007', 'utilities',             3800, '2021-04-14 09:00:00'),
('exp-004-003', 'cnc-0100008', 'medicines restocking',  9000, '2021-04-25 14:00:00'),
('exp-005-001', 'cnc-0100001', 'electricity bill',      4200, '2021-05-05 07:00:00'),
('exp-005-002', 'cnc-0100003', 'staff salaries',        45000,'2021-05-31 17:00:00'),
('exp-005-003', 'cnc-0100004', 'lab chemicals',         6700, '2021-05-20 10:00:00'),
('exp-006-001', 'cnc-0100005', 'rent',                  18000,'2021-06-01 08:00:00'),
('exp-006-002', 'cnc-0100006', 'miscellaneous',         2200, '2021-06-18 09:30:00'),
('exp-006-003', 'cnc-0100007', 'staff salaries',        38000,'2021-06-30 17:00:00'),
('exp-007-001', 'cnc-0100008', 'medical equipment',     12000,'2021-07-10 09:00:00'),
('exp-007-002', 'cnc-0100001', 'maintenance',           4800, '2021-07-22 11:00:00'),
('exp-007-003', 'cnc-0100002', 'staff salaries',        40000,'2021-07-31 17:00:00'),
('exp-008-001', 'cnc-0100003', 'housekeeping',          3100, '2021-08-06 08:30:00'),
('exp-008-002', 'cnc-0100004', 'electricity bill',      5000, '2021-08-18 09:00:00'),
('exp-008-003', 'cnc-0100005', 'staff salaries',        42000,'2021-08-31 17:00:00'),
('exp-009-001', 'cnc-0100006', 'rent',                  15000,'2021-09-01 08:00:00'),
('exp-009-002', 'cnc-0100007', 'office supplies',       1800, '2021-09-15 10:00:00'),
('exp-009-003', 'cnc-0100008', 'staff salaries',        35000,'2021-09-30 17:00:00'),
('exp-010-001', 'cnc-0100001', 'medicines restocking',  7500, '2021-10-05 09:00:00'),
('exp-010-002', 'cnc-0100002', 'utilities',             4100, '2021-10-16 10:00:00'),
('exp-010-003', 'cnc-0100003', 'staff salaries',        45000,'2021-10-31 17:00:00'),
('exp-011-001', 'cnc-0100004', 'maintenance',           6200, '2021-11-08 09:30:00'),
('exp-011-002', 'cnc-0100005', 'rent',                  18000,'2021-11-01 08:00:00'),
('exp-011-003', 'cnc-0100006', 'staff salaries',        36000,'2021-11-30 17:00:00'),
('exp-012-001', 'cnc-0100007', 'electricity bill',      5500, '2021-12-05 07:00:00'),
('exp-012-002', 'cnc-0100008', 'medical equipment',     10000,'2021-12-18 09:00:00'),
('exp-012-003', 'cnc-0100001', 'staff salaries',        47000,'2021-12-31 17:00:00');
