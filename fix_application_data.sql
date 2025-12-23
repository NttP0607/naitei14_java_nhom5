-- Tắt safe update mode tạm thời
SET SQL_SAFE_UPDATES = 0;

-- Xóa dữ liệu cũ
DELETE FROM application_status;
DELETE FROM application_documents;
DELETE FROM applications;

-- Reset auto increment
ALTER TABLE applications AUTO_INCREMENT = 1;
ALTER TABLE application_status AUTO_INCREMENT = 1;

-- Insert applications
INSERT INTO applications (id, application_code, citizen_id, service_id, submitted_at, assigned_staff, last_updated, note, active) VALUES
(1,'APP0001',1,1,NOW(),3,NOW(),'Nộp trực tiếp',1),
(2,'APP0002',2,8,NOW(),5,NOW(),'Nộp trực tiếp',1),
(3,'APP0003',3,1,NOW(),7,NOW(),'Nộp online',1),
(4,'APP0004',4,20,NOW(),8,NOW(),'Nộp trực tiếp',1),
(5,'APP0005',5,15,NOW(),6,NOW(),'Nộp trực tiếp',1),
(6,'APP0006',6,1,NOW(),3,NOW(),'Nộp trực tiếp',1),
(7,'APP0007',7,1,NOW(),3,NOW(),'Nộp trực tiếp',1),
(8,'APP0008',8,8,NOW(),5,NOW(),'Nộp online',1),
(9,'APP0009',9,27,NOW(),7,NOW(),'Nộp trực tiếp',1),
(10,'APP0010',10,1,NOW(),3,NOW(),'Nộp trực tiếp',1),
(11,'APP0011',11,21,NOW(),8,NOW(),'Nộp trực tiếp',1),
(12,'APP0012',12,23,NOW(),4,NOW(),'Nộp trực tiếp',1),
(13,'APP0013',13,25,NOW(),3,NOW(),'Nộp trực tiếp',1),
(14,'APP0014',14,27,NOW(),9,NOW(),'Nộp trực tiếp',1),
(15,'APP0015',15,29,NOW(),5,NOW(),'Nộp trực tiếp',1),
(16,'APP0016',16,31,NOW(),6,NOW(),'Nộp trực tiếp',1),
(17,'APP0017',17,33,NOW(),7,NOW(),'Nộp trực tiếp',1),
(18,'APP0018',18,35,NOW(),7,NOW(),'Nộp trực tiếp',1),
(19,'APP0019',19,37,NOW(),8,NOW(),'Nộp trực tiếp',1),
(20,'APP0020',20,40,NOW(),9,NOW(),'Nộp trực tiếp',1),
(21,'APP0021',1,2,NOW(),3,NOW(),'Nộp trực tiếp',1),
(22,'APP0022',2,4,NOW(),5,NOW(),'Nộp trực tiếp',1),
(23,'APP0023',3,6,NOW(),3,NOW(),'Nộp trực tiếp',1),
(24,'APP0024',4,9,NOW(),5,NOW(),'Nộp trực tiếp',1),
(25,'APP0025',5,11,NOW(),5,NOW(),'Nộp trực tiếp',1),
(26,'APP0026',6,13,NOW(),3,NOW(),'Nộp trực tiếp',1),
(27,'APP0027',7,15,NOW(),6,NOW(),'Nộp trực tiếp',1),
(28,'APP0028',8,17,NOW(),4,NOW(),'Nộp trực tiếp',1),
(29,'APP0029',9,18,NOW(),7,NOW(),'Nộp trực tiếp',1),
(30,'APP0030',10,21,NOW(),8,NOW(),'Nộp trực tiếp',1);

-- Insert application status với thứ tự thời gian tăng dần
-- Application 1: RECEIVED -> PROCESSING -> APPROVED
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(1,'RECEIVED','Hệ thống tiếp nhận',3, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(1,'PROCESSING','Chuyên viên đang thẩm định',3, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(1,'APPROVED','Đã hoàn tất',3, NOW());

-- Application 2: RECEIVED -> PROCESSING -> APPROVED
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(2,'RECEIVED','Hệ thống tiếp nhận',5, DATE_SUB(NOW(), INTERVAL 3 HOUR)),
(2,'PROCESSING','Đang kiểm tra hồ sơ doanh nghiệp',5, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(2,'APPROVED','Đã cấp giấy chứng nhận ĐKKD',5, NOW());

-- Application 3: RECEIVED -> REJECTED
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(3,'RECEIVED','Hệ thống tiếp nhận',7, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(3,'REJECTED','Hồ sơ thiếu công chứng, trả về',7, NOW());

-- Application 4: RECEIVED -> PROCESSING
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(4,'RECEIVED','Hệ thống tiếp nhận',8, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(4,'PROCESSING','Đang in bằng lái',8, NOW());

-- Application 5: RECEIVED -> APPROVED
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(5,'RECEIVED','Hệ thống tiếp nhận',6, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(5,'APPROVED','Đã cấp giấy phép xây dựng',6, NOW());

-- Application 6: RECEIVED only
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(6,'RECEIVED','Hệ thống tiếp nhận',3, NOW());

-- Application 7: RECEIVED -> PROCESSING
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(7,'RECEIVED','Hệ thống tiếp nhận',3, DATE_SUB(NOW(), INTERVAL 30 MINUTE)),
(7,'PROCESSING','Đang tra cứu lý lịch',3, NOW());

-- Application 8: RECEIVED -> APPROVED
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(8,'RECEIVED','Hệ thống tiếp nhận',5, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(8,'APPROVED','Hồ sơ hợp lệ',5, NOW());

-- Application 9: RECEIVED -> REJECTED
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(9,'RECEIVED','Hệ thống tiếp nhận',7, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(9,'REJECTED','Sai thông tin đất đai',7, NOW());

-- Application 10-20: RECEIVED only
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(10,'RECEIVED','Đã nộp hồ sơ',3, NOW()),
(11,'RECEIVED','Đã nộp hồ sơ',8, NOW()),
(12,'RECEIVED','Đã nộp hồ sơ',4, NOW()),
(13,'RECEIVED','Đã nộp hồ sơ',3, NOW()),
(14,'RECEIVED','Đã nộp hồ sơ',9, NOW()),
(15,'RECEIVED','Đã nộp hồ sơ',5, NOW()),
(16,'RECEIVED','Đã nộp hồ sơ',6, NOW()),
(17,'RECEIVED','Đã nộp hồ sơ',7, NOW()),
(18,'RECEIVED','Đã nộp hồ sơ',7, NOW()),
(19,'RECEIVED','Đã nộp hồ sơ',8, NOW()),
(20,'RECEIVED','Đã nộp hồ sơ',9, NOW());

-- Application 13, 15, 18: Thêm PROCESSING
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(13,'PROCESSING','Đang thụ lý',3, NOW()),
(15,'PROCESSING','Đang xác minh',5, NOW()),
(18,'REJECTED','Không đủ điều kiện',7, NOW());

-- Application 21-30: RECEIVED only
INSERT INTO application_status (application_id, status, note, user_id, updated_at) VALUES
(21,'RECEIVED','Đã tiếp nhận',3, NOW()),
(22,'RECEIVED','Đã tiếp nhận',5, NOW()),
(23,'RECEIVED','Đã tiếp nhận',3, NOW()),
(24,'RECEIVED','Đã tiếp nhận',5, NOW()),
(25,'RECEIVED','Đã tiếp nhận',5, NOW()),
(26,'RECEIVED','Đã tiếp nhận',3, NOW()),
(27,'RECEIVED','Đã tiếp nhận',6, NOW()),
(28,'RECEIVED','Đã tiếp nhận',4, NOW()),
(29,'RECEIVED','Đã tiếp nhận',7, NOW()),
(30,'RECEIVED','Đã tiếp nhận',8, NOW());

-- Bật lại safe update mode
SET SQL_SAFE_UPDATES = 1;
