USE QLDH
GO
-- INSERT LOAI HOA
INSERT INTO LoaiHoa
    (TenLoaiHoa)
    VALUES   
    (N'Cẩm chướng'),
    (N'Hồ điệp'),
    (N'Hồng'),
    (N'Lan'),
    (N'Cát tường'),
    (N'Cẩm tú cầu '),
    (N'Đinh lăng'),
    (N'Sao'),
    (N'Hướng dương'),
    (N'Đồng tiền'),
    (N'Cúc'),
    (N'Lily'),
    (N'thạch thảo')
GO
-- INSERT CHU DE
INSERT INTO ChuDe
    (ChuDe)
    VALUES
    (N'Hoa Sinh Nhật'),
    (N'Hoa Khai Trương'),
    (N'Hoa Chúc Mừng'),
    (N'Hoa Chia Buồn'),
    (N'Hoa Chúc Sức Khỏe'),
    (N'Hoa Cảm Ơn'),
    (N'Hoa Mừng Tốt Nghiệp')
GO
-- INSERT MAU
INSERT INTO Mau
    (TenMau)
    VALUES
    (N'Hồng'),
    (N'Đỏ'),
    (N'Xanh lam'),
    (N'Tím'),
    (N'Vàng'),
    (N'Cam'),
    (N'Hồng tím'),
    (N'Đen')
GO

-- INSERT SAN PHAM
set identity_insert SanPham on;

    insert SanPham ([MaSP],[TenSP],[MaMau],[MaLoaiHoa],[TenLoaiHoa],[MoTa],[TrangThaiHD],[GiaTruocGiam],[GiaSauGiam])
    select 1,N'Đại phú quý (mừng tết)',2,7,N'Đinh lăng',N'',0,1880000,1880000 UNION ALL
    select 2,N'Lộc Phát (mừng tết)',4,10,N'Đồng tiền',N'',0,1760000,1500000 UNION ALL
    select 3,N'Thành công 4 (mừng tết)',2,3,N'Hồng',N'',0,2200000,2000000 UNION ALL
    select 4,N'Màu Của Nắng',2,8,N'Sao',N'',1,3300000,3300000 UNION ALL
    select 5,N'Rose Rapture (mừng tết)',1,6,N'Cẩm tú cầu ',N'',0,1800000,1800000 UNION ALL
    select 6,N'Bó Hoa Tú Cầu (mừng tết)',1,11,N'Cúc',N'',0,440000,400000 UNION ALL
    select 7,N'Yêu xa (mừng tết)',7,3,N'Hồng',N'',0,250000,220000 UNION ALL
    select 8,N'Hồng vàng ánh trăng (mừng tết)',5,3,N'Hồng',N'',0,780000,650000 UNION ALL
    select 9,N'Red box',2,6,N'Cẩm tú cầu ',N'',1,950000,880000 UNION ALL
    select 10,N'Khúc biệt ly (mừng tết)',1,9,N'Hướng dương',N'',0,650000,650000 UNION ALL
    select 11,N'Vững Bền',6,1,N'Cẩm chướng',N'',1,1430000,1200000 UNION ALL
    select 12,N'Ươm nắng 2 (mừng tết)',7,13,N'thạch thảo',N'',0,2900000,2750000 UNION ALL
    select 13,N'Tất Thắng (mừng tết)',5,13,N'thạch thảo',N'',0,1320000,1200000 UNION ALL
    select 14,N'Hồ điệp may mắn (mừng tết)',8,1,N'Cẩm chướng',N'',0,1550000,1500000 UNION ALL
    select 15,N'Pink baby',7,11,N'Cúc',N'',1,1300000,1200000 UNION ALL
    select 16,N'Thinking of you',6,11,N'Cúc',N'',1,770000,600000 UNION ALL
    select 17,N'Tiễn Biệt 2 (mừng tết)',4,9,N'Hướng dương',N'',0,1000000,920000 UNION ALL
    select 18,N'Hưng Thịnh 5 (mừng tết)',6,9,N'Hướng dương',N'',0,1320000,1150000 UNION ALL
    select 19,N'Deep condolences',6,5,N'Cát tường',N'',1,950000,850000 UNION ALL
    select 20,N'Nắng Hạ',2,4,N'Lan',N'',1,900000,870000 UNION ALL
    select 21,N'Pink Box',3,1,N'Cẩm chướng',N'',1,950000,850000 UNION ALL
    select 22,N'Bình Hồng Jumilia 30',8,4,N'Lan',N'',1,420000,350000 UNION ALL
    select 23,N'Bình hồng da 30',3,7,N'Đinh lăng',N'',1,420000,350000 UNION ALL
    select 24,N'Bình hồng đỏ ớt 30',3,8,N'Sao',N'',1,420000,350000 UNION ALL
    select 25,N'Bình hồng Samilia 30',3,9,N'Hướng dương',N'',1,420000,350000 UNION ALL
    select 26,N'Bình hồng candy 30',1,10,N'Đồng tiền',N'',1,420000,350000 UNION ALL
    select 27,N'Hồng đỏ ớt',6,4,N'Lan',N'',1,420000,350000 UNION ALL
    select 28,N'Hồng vàng ánh trăng (25)',7,13,N'thạch thảo',N'',1,420000,350000 UNION ALL
    select 29,N'Hồng sen (30 bông)',7,5,N'Cát tường',N'',1,480000,400000 UNION ALL
    select 30,N'Hồng trứng gà (30 bông)',1,1,N'Cẩm chướng',N'',1,480000,400000 UNION ALL
    select 31,N'Hồng mix (30 bông)',3,2,N'Hồ điệp',N'',1,480000,400000 UNION ALL
    select 32,N'Hồng Samilia (25 bông)',2,12,N'Lily',N'',1,420000,350000 UNION ALL
    select 33,N'Hồng mix (25 bông)',5,1,N'Cẩm chướng',N'',1,420000,350000 UNION ALL
    select 34,N'Hồng sen (25 bông)',4,3,N'Hồng',N'',1,420000,350000 UNION ALL
    select 35,N'Hồng đỏ sa (25 bông)',7,5,N'Cát tường',N'',1,420000,350000 UNION ALL
    select 36,N'Giã Biệt 1',6,4,N'Lan',N'',1,600000,550000 UNION ALL
    select 37,N'Kí ức xưa',2,4,N'Lan',N'',1,1100000,1050000 UNION ALL
    select 38,N'Hè Rực Rỡ',5,11,N'Cúc',N'',1,1104000,920000 UNION ALL
    select 39,N'Ngọc sắc',2,8,N'Sao',N'',1,750000,700000 UNION ALL
    select 40,N'Sun flower',7,2,N'Hồ điệp',N'',1,720000,600000 UNION ALL
    select 41,N'Thinking of you',2,3,N'Hồng',N'',1,770000,600000 UNION ALL
    select 42,N'Pink baby',1,5,N'Cát tường',N'',1,1300000,1200000 UNION ALL
    select 43,N'Hồ điệp may mắn',6,11,N'Cúc',N'',1,1550000,1500000 UNION ALL
    select 44,N'Tất Thắng',4,1,N'Cẩm chướng',N'',1,1320000,1200000 UNION ALL
    select 45,N'Ươm nắng 2',8,10,N'Đồng tiền',N'',1,2900000,2750000 UNION ALL
    select 46,N'Vững Bền',1,4,N'Lan',N'',1,1430000,1200000 UNION ALL
    select 47,N'Khúc biệt ly',1,10,N'Đồng tiền',N'',1,705000,650000 UNION ALL
    select 48,N'Red box',6,13,N'thạch thảo',N'',1,950000,880000 UNION ALL
    select 49,N'Hồng vàng ánh trăng',3,5,N'Cát tường',N'',1,780000,650000 UNION ALL
    select 50,N'Yêu xa 2',4,7,N'Đinh lăng',N'',1,250000,220000 UNION ALL
    select 51,N'Bó Hoa Tú Cầu',1,12,N'Lily',N'',1,440000,400000 UNION ALL
    select 52,N'Rose Rapture',1,1,N'Cẩm chướng',N'',1,1855000,1800000 UNION ALL
    select 53,N'Màu Của Nắng',7,1,N'Cẩm chướng',N'',1,3355000,3300000 UNION ALL
    select 54,N'Thành công 4',4,7,N'Đinh lăng',N'',1,2200000,2000000 UNION ALL
    select 55,N'Lộc Phát',5,7,N'Đinh lăng',N'',1,1760000,1500000 UNION ALL
    select 56,N'Đại phú quý',7,13,N'thạch thảo',N'',1,1935000,1880000 UNION ALL
    select 57,N'Đại phú quý',4,12,N'Lily',N'',1,1880000,1880000 UNION ALL
    select 58,N'Lộc Phát',8,6,N'Cẩm tú cầu ',N'',1,1760000,1500000 UNION ALL
    select 59,N'Thành công 4',7,4,N'Lan',N'',1,2200000,2000000 UNION ALL
    select 60,N'Màu Của Nắng',2,1,N'Cẩm chướng',N'',1,3300000,3300000 UNION ALL
    select 61,N'Rose Rapture',3,2,N'Hồ điệp',N'',1,1800000,1800000 UNION ALL
    select 62,N'Bó Hoa Tú Cầu',5,4,N'Lan',N'',1,440000,400000 UNION ALL
    select 63,N'Yêu xa 3',5,11,N'Cúc',N'',1,250000,220000 UNION ALL
    select 64,N'Hồng vàng ánh trăng',8,2,N'Hồ điệp',N'',1,780000,650000 UNION ALL
    select 65,N'Red box',7,11,N'Cúc',N'',1,950000,880000 UNION ALL
    select 66,N'Khúc biệt ly',5,7,N'Đinh lăng',N'',1,650000,650000 UNION ALL
    select 67,N'Vững Bền',8,1,N'Cẩm chướng',N'',1,1430000,1200000 UNION ALL
    select 68,N'Ươm nắng 2',8,6,N'Cẩm tú cầu ',N'',1,2900000,2750000 UNION ALL
    select 69,N'Tất Thắng',6,7,N'Đinh lăng',N'',1,1320000,1200000 UNION ALL
    select 70,N'Hồ điệp may mắn',7,8,N'Sao',N'',1,1550000,1500000 UNION ALL
    select 71,N'Pink baby',5,2,N'Hồ điệp',N'',1,1300000,1200000 UNION ALL
    select 72,N'Thinking of you',2,9,N'Hướng dương',N'',1,770000,600000 UNION ALL
    select 73,N'Tiễn Biệt 2',7,7,N'Đinh lăng',N'',1,1000000,920000 UNION ALL
    select 74,N'Hưng Thịnh 5',6,13,N'thạch thảo',N'',1,1320000,1150000;

set identity_insert SanPham off;
GO
-- INSERT SP_CD
insert SP_CD ([MaSP],[MaCDe],[ChuDe])
    select 1,2,N'Hoa Khai Trương' UNION ALL
    select 2,3,N'Hoa Chúc Mừng' UNION ALL
    select 3,2,N'Hoa Khai Trương' UNION ALL
    select 3,4,N'Hoa Chia Buồn' UNION ALL
    select 4,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 5,4,N'Hoa Chia Buồn' UNION ALL
    select 6,1,N'Hoa Sinh Nhật' UNION ALL
    select 7,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 7,6,N'Hoa Cảm Ơn' UNION ALL
    select 8,4,N'Hoa Chia Buồn' UNION ALL
    select 9,1,N'Hoa Sinh Nhật' UNION ALL
    select 9,3,N'Hoa Chúc Mừng' UNION ALL
    select 10,4,N'Hoa Chia Buồn' UNION ALL
    select 11,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 12,4,N'Hoa Chia Buồn' UNION ALL
    select 12,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 13,6,N'Hoa Cảm Ơn' UNION ALL
    select 13,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 14,4,N'Hoa Chia Buồn' UNION ALL
    select 15,1,N'Hoa Sinh Nhật' UNION ALL
    select 15,2,N'Hoa Khai Trương' UNION ALL
    select 16,1,N'Hoa Sinh Nhật' UNION ALL
    select 16,6,N'Hoa Cảm Ơn' UNION ALL
    select 17,3,N'Hoa Chúc Mừng' UNION ALL
    select 17,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 18,4,N'Hoa Chia Buồn' UNION ALL
    select 18,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 19,2,N'Hoa Khai Trương' UNION ALL
    select 19,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 20,2,N'Hoa Khai Trương' UNION ALL
    select 21,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 22,4,N'Hoa Chia Buồn' UNION ALL
    select 22,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 23,3,N'Hoa Chúc Mừng' UNION ALL
    select 23,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 24,3,N'Hoa Chúc Mừng' UNION ALL
    select 25,1,N'Hoa Sinh Nhật' UNION ALL
    select 25,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 25,6,N'Hoa Cảm Ơn' UNION ALL
    select 26,6,N'Hoa Cảm Ơn' UNION ALL
    select 27,1,N'Hoa Sinh Nhật' UNION ALL
    select 27,4,N'Hoa Chia Buồn' UNION ALL
    select 28,2,N'Hoa Khai Trương' UNION ALL
    select 29,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 30,2,N'Hoa Khai Trương' UNION ALL
    select 30,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 31,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 32,1,N'Hoa Sinh Nhật' UNION ALL
    select 33,2,N'Hoa Khai Trương' UNION ALL
    select 33,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 34,1,N'Hoa Sinh Nhật' UNION ALL
    select 34,2,N'Hoa Khai Trương' UNION ALL
    select 35,3,N'Hoa Chúc Mừng' UNION ALL
    select 35,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 36,1,N'Hoa Sinh Nhật' UNION ALL
    select 36,2,N'Hoa Khai Trương' UNION ALL
    select 36,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 37,2,N'Hoa Khai Trương' UNION ALL
    select 38,1,N'Hoa Sinh Nhật' UNION ALL
    select 39,4,N'Hoa Chia Buồn' UNION ALL
    select 39,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 39,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 40,4,N'Hoa Chia Buồn' UNION ALL
    select 41,6,N'Hoa Cảm Ơn' UNION ALL
    select 42,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 43,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 43,6,N'Hoa Cảm Ơn' UNION ALL
    select 44,1,N'Hoa Sinh Nhật' UNION ALL
    select 45,3,N'Hoa Chúc Mừng' UNION ALL
    select 45,6,N'Hoa Cảm Ơn' UNION ALL
    select 46,2,N'Hoa Khai Trương' UNION ALL
    select 47,1,N'Hoa Sinh Nhật' UNION ALL
    select 47,3,N'Hoa Chúc Mừng' UNION ALL
    select 48,1,N'Hoa Sinh Nhật' UNION ALL
    select 48,3,N'Hoa Chúc Mừng' UNION ALL
    select 49,3,N'Hoa Chúc Mừng' UNION ALL
    select 50,4,N'Hoa Chia Buồn' UNION ALL
    select 51,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 51,6,N'Hoa Cảm Ơn' UNION ALL
    select 52,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 53,6,N'Hoa Cảm Ơn' UNION ALL
    select 53,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 54,6,N'Hoa Cảm Ơn' UNION ALL
    select 55,6,N'Hoa Cảm Ơn' UNION ALL
    select 55,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 56,4,N'Hoa Chia Buồn' UNION ALL
    select 56,6,N'Hoa Cảm Ơn' UNION ALL
    select 57,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 57,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 58,6,N'Hoa Cảm Ơn' UNION ALL
    select 59,2,N'Hoa Khai Trương' UNION ALL
    select 60,6,N'Hoa Cảm Ơn' UNION ALL
    select 61,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 62,6,N'Hoa Cảm Ơn' UNION ALL
    select 63,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 64,6,N'Hoa Cảm Ơn' UNION ALL
    select 65,1,N'Hoa Sinh Nhật' UNION ALL
    select 65,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 66,3,N'Hoa Chúc Mừng' UNION ALL
    select 67,3,N'Hoa Chúc Mừng' UNION ALL
    select 68,3,N'Hoa Chúc Mừng' UNION ALL
    select 69,3,N'Hoa Chúc Mừng' UNION ALL
    select 69,5,N'Hoa Chúc Sức Khỏe' UNION ALL
    select 70,1,N'Hoa Sinh Nhật' UNION ALL
    select 70,3,N'Hoa Chúc Mừng' UNION ALL
    select 71,2,N'Hoa Khai Trương' UNION ALL
    select 72,2,N'Hoa Khai Trương' UNION ALL
    select 72,4,N'Hoa Chia Buồn' UNION ALL
    select 72,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 73,4,N'Hoa Chia Buồn' UNION ALL
    select 73,7,N'Hoa Mừng Tốt Nghiệp' UNION ALL
    select 74,5,N'Hoa Chúc Sức Khỏe';
GO