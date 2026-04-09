DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id         VARCHAR(50)  PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    phone_number    VARCHAR(20),
    mail_id         VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME    NOT NULL,
    room_no      VARCHAR(50),
    user_id      VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id   VARCHAR(50)    PRIMARY KEY,
    item_name VARCHAR(100)   NOT NULL,
    item_rate DECIMAL(10, 2) NOT NULL
);

CREATE TABLE booking_commercials (
    id            VARCHAR(50)    PRIMARY KEY,
    booking_id    VARCHAR(50),
    bill_id       VARCHAR(50),
    bill_date     DATETIME,
    item_id       VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe',    '9712345678', 'john.doe@example.com',    'XX, Street Y, ABC City'),
('usr-ab12cd-ef34', 'Jane Smith',  '9823456789', 'jane.smith@example.com',  '12, Park Avenue, DEF City'),
('usr-gh56ij-kl78', 'Ravi Kumar',  '9934567890', 'ravi.kumar@example.com',  '34, Lake View, GHI City'),
('usr-mn90op-qr12', 'Priya Nair',  '9045678901', 'priya.nair@example.com',  '56, Rose Street, JKL City'),
('usr-st34uv-wx56', 'Ali Hassan',  '9156789012', 'ali.hassan@example.com',  '78, Green Park, MNO City');

INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu',  'Tawa Paratha',         18.00),
('itm-a07vh-aer8', 'Mix Veg',              89.00),
('itm-w978-23u4',  'Dal Tadka',            75.00),
('itm-b123-xc45',  'Paneer Butter Masala', 150.00),
('itm-c456-yz89',  'Butter Naan',          30.00),
('itm-d789-mn01',  'Lassi',                45.00),
('itm-e012-op23',  'Gulab Jamun',          60.00),
('itm-f345-qr56',  'Chicken Curry',        180.00),
('itm-g678-st78',  'Fried Rice',           120.00),
('itm-h901-uv90',  'Cold Coffee',          80.00);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj',  '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-10a1b-22cd',  '2021-10-05 10:15:00', 'rm-c3d4-efgh',  'usr-ab12cd-ef34'),
('bk-10a2c-33ef',  '2021-10-18 14:22:00', 'rm-e5f6-ijkl',  'usr-gh56ij-kl78'),
('bk-11a3d-44gh',  '2021-11-02 09:00:00', 'rm-g7h8-mnop',  'usr-mn90op-qr12'),
('bk-11a4e-55ij',  '2021-11-15 11:30:00', 'rm-i9j0-qrst',  'usr-st34uv-wx56'),
('bk-11a5f-66kl',  '2021-11-28 16:45:00', 'rm-k1l2-uvwx',  '21wrcxuy-67erfn'),
('bk-12a6g-77mn',  '2021-12-10 08:00:00', 'rm-m3n4-yzab',  'usr-ab12cd-ef34'),
('bk-09b7h-88op',  '2021-09-30 18:00:00', 'rm-o5p6-cdef',  'usr-gh56ij-kl78'),
('bk-10b8i-99qr',  '2021-10-25 20:00:00', 'rm-q7r8-ghij',  'usr-mn90op-qr12'),
('bk-12b9j-11st',  '2021-12-20 13:00:00', 'rm-s9t0-klmn',  'usr-st34uv-wx56');

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu',  3.0),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1.0),
('r01-sep2-0001',   'bk-09b7h-88op', 'bl-sep2-b001',  '2021-09-30 20:10:00', 'itm-b123-xc45',  5.0),
('r02-sep2-0002',   'bk-09b7h-88op', 'bl-sep2-b001',  '2021-09-30 20:10:00', 'itm-c456-yz89',  8.0),
('r03-oct1-0001',   'bk-10a1b-22cd', 'bl-oct1-c001',  '2021-10-05 12:00:00', 'itm-w978-23u4',  4.0),
('r04-oct1-0002',   'bk-10a1b-22cd', 'bl-oct1-c001',  '2021-10-05 12:00:00', 'itm-d789-mn01',  3.0),
('r05-oct1-0003',   'bk-10a1b-22cd', 'bl-oct1-c002',  '2021-10-07 09:00:00', 'itm-f345-qr56',  10.0),
('r06-oct2-0001',   'bk-10a2c-33ef', 'bl-oct2-d001',  '2021-10-18 15:00:00', 'itm-g678-st78',  6.0),
('r07-oct2-0002',   'bk-10a2c-33ef', 'bl-oct2-d001',  '2021-10-18 15:00:00', 'itm-e012-op23',  4.0),
('r08-oct3-0001',   'bk-10b8i-99qr', 'bl-oct3-e001',  '2021-10-25 21:00:00', 'itm-h901-uv90',  7.0),
('r09-oct3-0002',   'bk-10b8i-99qr', 'bl-oct3-e001',  '2021-10-25 21:00:00', 'itm-f345-qr56',  5.0),
('r10-nov1-0001',   'bk-11a3d-44gh', 'bl-nov1-f001',  '2021-11-02 10:00:00', 'itm-a9e8-q8fu',  10.0),
('r11-nov1-0002',   'bk-11a3d-44gh', 'bl-nov1-f001',  '2021-11-02 10:00:00', 'itm-b123-xc45',  3.0),
('r12-nov2-0001',   'bk-11a4e-55ij', 'bl-nov2-g001',  '2021-11-15 12:30:00', 'itm-g678-st78',  8.0),
('r13-nov2-0002',   'bk-11a4e-55ij', 'bl-nov2-g001',  '2021-11-15 12:30:00', 'itm-c456-yz89',  5.0),
('r14-nov3-0001',   'bk-11a5f-66kl', 'bl-nov3-h001',  '2021-11-28 17:00:00', 'itm-f345-qr56',  2.0),
('r15-nov3-0002',   'bk-11a5f-66kl', 'bl-nov3-h001',  '2021-11-28 17:00:00', 'itm-d789-mn01',  6.0),
('r16-dec1-0001',   'bk-12a6g-77mn', 'bl-dec1-i001',  '2021-12-10 09:00:00', 'itm-h901-uv90',  12.0),
('r17-dec1-0002',   'bk-12a6g-77mn', 'bl-dec1-i001',  '2021-12-10 09:00:00', 'itm-e012-op23',  8.0),
('r18-dec2-0001',   'bk-12b9j-11st', 'bl-dec2-j001',  '2021-12-20 14:00:00', 'itm-a07vh-aer8', 9.0),
('r19-dec2-0002',   'bk-12b9j-11st', 'bl-dec2-j001',  '2021-12-20 14:00:00', 'itm-w978-23u4',  11.0);
