USE QLDH
GO

set identity_insert NhaCungCap on;

    insert NhaCungCap ([MaNCC],[TenNCC],[DiaChiNCC],[SDT_NCC],[EmailNCC])
    select 1,N'Trại hoa Cường',N'Đường Đường Đòn Dông BC, Tân Hiệp, Kiên Giang','0238435797','1mail@email.com' UNION ALL
    select 2,N'Trại hoa Lâm',N'Đường Nguyễn Trãi, Châu Thành, An Giang','0291973448','2mail@email.com' UNION ALL
    select 3,N'Trại hoa Hải',N'Đường Phan Chu Trinh, Cẩm Lệ, Đà Nẵng','0175357794','3mail@email.com' UNION ALL
    select 4,N'Trại hoa Dương',N'Đường Nguyễn Thượng Hiền, Đà Lạt, Lâm Đồng','0204053136','4mail@email.com' UNION ALL
    select 5,N'Trại hoa Phương',N'Đường Lê Quang Định, Rạch Giá, Kiên Giang','0806953063','5mail@email.com' UNION ALL
    select 6,N'Trại hoa Linh',N'Đường Phong Bắc 11, Cẩm Lệ, Đà Nẵng','0272654641','6mail@email.com' UNION ALL
    select 7,N'Trại hoa Tuaân',N'Đường Tỉnh 827B, Châu Thành, Long An','0273362813','7mail@email.com' UNION ALL
    select 8,N'Trại hoa Triệu Đức',N'Đường 8, Gò Vấp, Hồ Chí Minh','0707097701','8mail@email.com' UNION ALL
    select 9,N'Trại hoa Hùng',N'Phố Trần Đại Nghĩa, Lạng Sơn, Lạng Sơn','0273327785','9mail@email.com' UNION ALL
    select 10,N'Trại hoa Linh',N'Đường Nguyễn Văn Cừ, Đồng Hới, Quảng Bình','0536434162','10mail@email.com' UNION ALL
    select 11,N'Trại hoa Long',N'Đường Võ Thị Sáu, Sóc Trăng, Sóc Trăng','0322306016','11mail@email.com' UNION ALL
    select 12,N'Trại hoa Toàn',N'Đường Âu Cơ, Châu Đức, Bà Rịa Vũng Tàu','0260540211','12mail@email.com' UNION ALL
    select 13,N'Trại hoa Nguyễn Tiên',N'Đường Hưng Sơn, Hoằng Hóa, Thanh Hóa','0620354655','13mail@email.com' UNION ALL
    select 14,N'Trại hoa Đặng Hà',N'Đường Nguyễn Văn Côn, Hồng Ngự, Đồng Tháp','0453898979','14mail@email.com' UNION ALL
    select 15,N'Trại hoa Phát',N'Đường Phùng Thị Chinh, Kiến An, Hải Phòng','0893797710','15mail@email.com' UNION ALL
    select 16,N'Trại hoa Du',N'Đường Phai Vệ, Lạng Sơn, Lạng Sơn','0734890819','16mail@email.com' UNION ALL
    select 17,N'Trại hoa Linh',N'Đường Đinh Công Tráng, KonTum, Kon Tum','0369961535','17mail@email.com' UNION ALL
    select 18,N'Trại hoa Thịnh',N'Đường Số 21, Nha Trang, Khánh Hòa','0103709114','18mail@email.com' UNION ALL
    select 19,N'Trại hoa Tùng',N'Đường An Sơn 36, Thuận An, Bình Dương','0101410464','19mail@email.com' UNION ALL
    select 20,N'Trại hoa Đăng',N'Đường T15, Lào Cai, Lào Cai','0588743011','20mail@email.com' UNION ALL
    select 21,N'Trại hoa Khôi',N'Đường Nguyệt Quế 19-32, Long Biên, Hà Nội','0461617467','21mail@email.com' UNION ALL
    select 22,N'Trại hoa Nhiêu Lực',N'Đường 240, Long Thành, Đồng Nai','0479271593','22mail@email.com' UNION ALL
    select 23,N'Trại hoa Trần Thuý',N'Đường Nguyễn Du, Dĩ An, Bình Dương','0474028500','23mail@email.com' UNION ALL
    select 24,N'Trại hoa Tùng',N'Đường Số 5, Tân An, Long An','0825037456','24mail@email.com' UNION ALL
    select 25,N'Trại hoa Minh',N'Đường Quốc Lộ 22, Hóc Môn, Hồ Chí Minh','0672342557','25mail@email.com' UNION ALL
    select 26,N'Trại hoa Quí',N'Đường Đội Cấn, Đồng Hới, Quảng Bình','0187667957','26mail@email.com' UNION ALL
    select 27,N'Trại hoa Viên Khải',N'Đường Tỉnh lộ 505, Như Thanh, Thanh Hóa','0905258579','27mail@email.com' UNION ALL
    select 28,N'Trại hoa Lê Hiếu',N'Đường Bạch Đằng 10, Tân Uyên, Bình Dương','0727557799','28mail@email.com' UNION ALL
    select 29,N'Trại hoa Tuấn',N'Đường Lê Thánh Tông, Lê Chân, Hải Phòng','0674820744','29mail@email.com' UNION ALL
    select 30,N'Trại hoa Thanh',N'Đường NL10, Bến Cát, Bình Dương','0588434848','30mail@email.com' UNION ALL
    select 31,N'Trại hoa Vũ',N'Đường Nguyễn Văn Lâu, Vĩnh Long, Vĩnh Long','0357826268','31mail@email.com' UNION ALL
    select 32,N'Trại hoa Trường',N'Đường Lê Thị Phỉ, Mỹ Tho, Tiền Giang','0394667176','32mail@email.com' UNION ALL
    select 33,N'Trại hoa Lê Long',N'Đường Đông Thạnh 6-1, Hóc Môn, Hồ Chí Minh','0280667945','33mail@email.com' UNION ALL
    select 34,N'Trại hoa Thủy',N'Đường Quốc Lộ 1, Thủ Đức, Hồ Chí Minh','0496997453','34mail@email.com' UNION ALL
    select 35,N'Trại hoa Khải',N'Đường Ngô Quyền, Tuy Hòa, Phú Yên','0835202289','35mail@email.com' UNION ALL
    select 36,N'Trại hoa Khương',N'Phố 36, Tân Uyên, Bình Dương','0993414152','36mail@email.com' UNION ALL
    select 37,N'Trại hoa Phát',N'Đường Lê Minh Nhất, Củ Chi, Hồ Chí Minh','0260426917','37mail@email.com' UNION ALL
    select 38,N'Trại hoa Cẩm',N'Đường Kênh 11, Bình Chánh, Hồ Chí Minh','0456167634','38mail@email.com' UNION ALL
    select 39,N'Trại hoa Thuận',N'Đường 21D, Bình Tân, Hồ Chí Minh','0439190834','39mail@email.com' UNION ALL
    select 40,N'Trại hoa Huỳnh Thìn',N'Đường D52, Tân Bình, Hồ Chí Minh','0301944367','40mail@email.com' UNION ALL
    select 41,N'Trại hoa Hưng',N'Đường Phạm Ngọc Thạch, Tuy Hòa, Phú Yên','0951456388','41mail@email.com' UNION ALL
    select 42,N'Trại hoa Hạo',N'Đường Lê Trọng Thứ, Thái Bình, Thái Bình','0535549280','42mail@email.com' UNION ALL
    select 43,N'Trại hoa Nguyễn Dũng',N'Đường An Dương Vương, Gia Nghĩa, Đắk Nông','0435987976','43mail@email.com' UNION ALL
    select 44,N'Trại hoa Hiền',N'Phố Lương Định Của, Long Xuyên, An Giang','0347996700','44mail@email.com' UNION ALL
    select 45,N'Trại hoa Văn',N'Đường Hoàng Diệu, Nam Định, Nam Định','0691197298','45mail@email.com' UNION ALL
    select 46,N'Trại hoa Nam',N'Đường Hà Văn Trí, Cẩm Lệ, Đà Nẵng','0973745134','46mail@email.com' UNION ALL
    select 47,N'Trại hoa Lâm Khiêm',N'Đường Hòa Trung, Nha Trang, Khánh Hòa','0156999194','47mail@email.com' UNION ALL
    select 48,N'Trại hoa Nguyễn Hòa',N'Đường Lê Thị Hồng Gấm, Phủ Lý, Hà Nam','0603974340','48mail@email.com' UNION ALL
    select 49,N'Trại hoa Hà',N'Đường Nguyễn Văn Nghĩa, Biên Hòa, Đồng Nai','0427316432','49mail@email.com' UNION ALL
    select 50,N'Trại hoa Đỗ Tâm',N'Đường Tỉnh lộ 822, Đức Huệ, Long An','0533260252','50mail@email.com' UNION ALL
    select 51,N'Trại hoa Bách',N'Đường Trần Thừa, Nam Định, Nam Định','0622814305','51mail@email.com' UNION ALL
    select 52,N'Trại hoa Phước',N'Đường 10, Nga Sơn, Thanh Hóa','0570394777','52mail@email.com' UNION ALL
    select 53,N'Trại hoa Huy',N'Đường Hùng Vương, AYun Pa, Gia Lai','0460062810','53mail@email.com' UNION ALL
    select 54,N'Trại hoa Vinh',N'Đường Bùi Thị Xuân, Vĩnh Châu, Sóc Trăng','0953550041','54mail@email.com' UNION ALL
    select 55,N'Trại hoa Nhân',N'Phố 37, Bắc Yên, Sơn La','0761108709','55mail@email.com' UNION ALL
    select 56,N'Trại hoa Thạnh',N'Đường 18, Yên Phong, Bắc Ninh','0305073086','56mail@email.com' UNION ALL
    select 57,N'Trại hoa Hạnh',N'Đường NB12, Bến Cát, Bình Dương','0615942750','57mail@email.com' UNION ALL
    select 58,N'Trại hoa Huỳnh Bình',N'Đường Đại Từ, Hoàng Mai, Hà Nội','0219806538','58mail@email.com' UNION ALL
    select 59,N'Trại hoa Thuận',N'Đường Võ Duy Dương, Liên Chiểu, Đà Nẵng','0103512009','59mail@email.com' UNION ALL
    select 60,N'Trại hoa Khánh',N'Đường Trương Công Hy, Ngũ Hành Sơn, Đà Nẵng','0290751661','60mail@email.com' UNION ALL
    select 61,N'Trại hoa Quang',N'Đường Trưng Nhị, Thủ Đức, Hồ Chí Minh','0965833270','61mail@email.com' UNION ALL
    select 62,N'Trại hoa Thông',N'Đường Quốc lộ 16, Yên Phong, Bắc Ninh','0899203378','62mail@email.com' UNION ALL
    select 63,N'Trại hoa Lê Sơn',N'Đường N9, Quận 9, Hồ Chí Minh','0884358165','63mail@email.com' UNION ALL
    select 64,N'Trại hoa Duyệt',N'Đường Long Biên 2, Hoàn Kiếm, Hà Nội','0953340448','64mail@email.com' UNION ALL
    select 65,N'Trại hoa Thái Nhật',N'Đường 69, Yên Mỹ, Hưng Yên','0658854544','65mail@email.com' UNION ALL
    select 66,N'Trại hoa Khoa',N'Đường Minh Khai, Hải Dương, Hải Dương','0924552462','66mail@email.com' UNION ALL
    select 67,N'Trại hoa Tài',N'Đường 2, Thuận An, Bình Dương','0842453458','67mail@email.com' UNION ALL
    select 68,N'Trại hoa Trần Đạt',N'Đường Hòa Minh 8, Liên Chiểu, Đà Nẵng','0524435211','68mail@email.com' UNION ALL
    select 69,N'Trại hoa Bùi Duy',N'Đường Ấp Đông 5, Hóc Môn, Hồ Chí Minh','0935609989','69mail@email.com' UNION ALL
    select 70,N'Trại hoa Trung',N'Đường Trần Hưng Đạo, Tam Kỳ, Quảng Nam','0245609829','70mail@email.com' UNION ALL
    select 71,N'Trại hoa Nhân',N'Đường Cẩm Thành, Quảng Ngãi, Quảng Ngãi','0244884835','71mail@email.com' UNION ALL
    select 72,N'Trại hoa Lê Xoan',N'Đường 359, Gò Vấp, Hồ Chí Minh','0459068459','72mail@email.com' UNION ALL
    select 73,N'Trại hoa An',N'Đường Phan Trọng Tuệ, Hà Đông, Hà Nội','0431045832','73mail@email.com' UNION ALL
    select 74,N'Trại hoa Phúc',N'Đường 21, Nhà Bè, Hồ Chí Minh','0275152506','74mail@email.com' UNION ALL
    select 75,N'Trại hoa Lê Anh',N'Đường Quốc Lộ 1, Quận 9, Hồ Chí Minh','0344573862','75mail@email.com' UNION ALL
    select 76,N'Trại hoa Quân',N'Đường Bản Lè, Nghĩa Lộ, Yên Bái','0860864000','76mail@email.com' UNION ALL
    select 77,N'Trại hoa Nguyễn Hải',N'Đường Nguyễn Thị Rành, Hóc Môn, Hồ Chí Minh','0383485114','77mail@email.com' UNION ALL
    select 78,N'Trại hoa Đinh Thuận',N'Phố Trần Nguyên Hãn, Sầm Sơn, Thanh Hóa','0494407294','78mail@email.com' UNION ALL
    select 79,N'Trại hoa Vui',N'Đường Phan Đình Gót, Cẩm Xuyên, Hà Tĩnh','0130535497','79mail@email.com' UNION ALL
    select 80,N'Trại hoa Pháp',N'Đường D4, Cái Răng, Cần Thơ','0993321621','80mail@email.com' UNION ALL
    select 81,N'Trại hoa Phương',N'Đường 8K, Quận 2, Hồ Chí Minh','0556933662','81mail@email.com' UNION ALL
    select 82,N'Trại hoa Nguyễn Long',N'Đường Tỉnh lộ 355, Kiến An, Hải Phòng','0703292767','82mail@email.com' UNION ALL
    select 83,N'Trại hoa Yến',N'Đường Hồng Sơn, Vinh, Nghệ An','0561395500','83mail@email.com' UNION ALL
    select 84,N'Trại hoa Thân Trí',N'Đường Nguyễn Trung Ngạn, Quận 1, Hồ Chí Minh','0279288890','84mail@email.com' UNION ALL
    select 85,N'Trại hoa Thiệp',N'Đường An Lạc 2, Hồng Bàng, Hải Phòng','0197022222','85mail@email.com' UNION ALL
    select 86,N'Trại hoa Bảo',N'Đường 7, Châu Phú, An Giang','0791331369','86mail@email.com' UNION ALL
    select 87,N'Trại hoa Hoàng',N'Đường Tỉnh Lộ 10, Cần Đước, Long An','0226896445','87mail@email.com' UNION ALL
    select 88,N'Trại hoa Khánh',N'Đường Duy Tân, Long Khánh, Đồng Nai','0297060056','88mail@email.com' UNION ALL
    select 89,N'Trại hoa Đức',N'Đường Quốc lộ 1A, Hàm Thuận Bắc, Bình Thuận  ','0552322656','89mail@email.com' UNION ALL
    select 90,N'Trại hoa Phong',N'Đường Nguyễn Thái Học, Biên Hòa, Đồng Nai','0727913976','90mail@email.com' UNION ALL
    select 91,N'Trại hoa Vinh',N'Đường D3, Nhà Bè, Hồ Chí Minh','0168388480','91mail@email.com' UNION ALL
    select 92,N'Trại hoa Tuyến',N'Đường Tam Tân, Đức Hòa, Long An','0617020926','92mail@email.com' UNION ALL
    select 93,N'Trại hoa Trực',N'Đường Nguyễn Thị Triệu, Củ Chi, Hồ Chí Minh','0102451862','93mail@email.com' UNION ALL
    select 94,N'Trại hoa Quân',N'Đường Từ Đạo Hạnh, Thanh Hóa, Thanh Hóa','0605083906','94mail@email.com' UNION ALL
    select 95,N'Trại hoa Long',N'Đường ĐT 835, Bến Lức, Long An','0647008835','95mail@email.com' UNION ALL
    select 96,N'Trại hoa Lê Minh',N'Phố Hai Bà Trưng, Buôn Ma Thuột, Đắk Lắk','0880520800','96mail@email.com' UNION ALL
    select 97,N'Trại hoa Nguyễn Chăm',N'Đường Nguyễn Minh Đường, Tân An, Long An','0109765395','97mail@email.com' UNION ALL
    select 98,N'Trại hoa Trần Thắng',N'Đường Hậu Lân, Cẩm Lệ, Đà Nẵng','0161542108','98mail@email.com' UNION ALL
    select 99,N'Trại hoa Nguyễn Thái',N'Phố Hai Bà Trưng, Huế, Thừa Thiên Huế','0362422667','99mail@email.com' UNION ALL
    select 100,N'Trại hoa Hoàng',N'Đường Trần Thủ Độ, Hoàng Mai, Hà Nội','0854484994','100mail@email.com' UNION ALL
    select 101,N'Trại hoa Vũ',N'Đường Phan Đình Giót, Thanh Hóa, Thanh Hóa','0251504873','101mail@email.com' UNION ALL
    select 102,N'Trại hoa Nguyễn Tiến',N'Đường Số 17, Bình Tân, Hồ Chí Minh','0765846014','102mail@email.com' UNION ALL
    select 103,N'Trại hoa Kỳ',N'Đường Bà Điểm 10, Hóc Môn, Hồ Chí Minh','0589639582','103mail@email.com' UNION ALL
    select 104,N'Trại hoa Trương Việt',N'Đường Nguyễn Thái Học, Ba Đình, Hà Nội','0365512828','104mail@email.com' UNION ALL
    select 105,N'Trại hoa Trần Luận',N'Phố Cử Bình, Hồng Bàng, Hải Phòng','0820066740','105mail@email.com' UNION ALL
    select 106,N'Trại hoa Khôi',N'Đường Tân Thành, Quận 11, Hồ Chí Minh','0258376361','106mail@email.com' UNION ALL
    select 107,N'Trại hoa Nguyên',N'Đường 73, Quận 9, Hồ Chí Minh','0126096764','107mail@email.com' UNION ALL
    select 108,N'Trại hoa Tuấn',N'Đường Lê Văn Long, Hải Châu, Đà Nẵng','0446891723','108mail@email.com' UNION ALL
    select 109,N'Trại hoa Phúc',N'Đường Phan Đình Phùng, KonTum, Kon Tum','0822495187','109mail@email.com' UNION ALL
    select 110,N'Trại hoa Phú',N'Đường Hà Hoàng Hổ, Long Xuyên, An Giang','0948011524','110mail@email.com' UNION ALL
    select 111,N'Trại hoa Minh',N'Đường 188, Lâm Bình, Tuyên Quang','0793666679','111mail@email.com' UNION ALL
    select 112,N'Trại hoa Huỳnh Hiếu',N'Đường Trần Phương, Kiến An, Hải Phòng','0196628663','112mail@email.com' UNION ALL
    select 113,N'Trại hoa Bình',N'Đường Phan Đình Phùng, Gia Nghĩa, Đắk Nông','0713041851','113mail@email.com' UNION ALL
    select 114,N'Trại hoa An',N'Đường Thuận Giao 10, Thuận An, Bình Dương','0640645456','114mail@email.com' UNION ALL
    select 115,N'Trại hoa Nguyễn Vũ',N'Đường Chu Văn An, Việt Trì, Phú Thọ','0798583062','115mail@email.com' UNION ALL
    select 116,N'Trại hoa An',N'Đường Phạm Hồng Thái, Vĩnh Yên, Vĩnh Phúc','0722640446','116mail@email.com' UNION ALL
    select 117,N'Trại hoa Nguyễn Đại',N'Đường Làng Tăng Phú, Quận 9, Hồ Chí Minh','0132216503','117mail@email.com' UNION ALL
    select 118,N'Trại hoa Thoa',N'Đường Sang Hán, Nghĩa Lộ, Yên Bái','0197280843','118mail@email.com' UNION ALL
    select 119,N'Trại hoa Hiếu',N'Đường Võ Thị Sáu, Phù Mỹ, Bình Định','0336963060','119mail@email.com' UNION ALL
    select 120,N'Trại hoa Hồ Ni',N'Phố Lê Trọng Tấn, Long Xuyên, An Giang','0581840642','120mail@email.com' UNION ALL
    select 121,N'Trại hoa Thắng',N'Đường Bến Miễu, Giồng Trôm, Bến Tre','0997479694','121mail@email.com' UNION ALL
    select 122,N'Trại hoa Huỳnh Ñoàng',N'Đường Phạm Văn Nghị, Hải Châu, Đà Nẵng','0545754271','122mail@email.com' UNION ALL
    select 123,N'Trại hoa Bá Khanh',N'Đường Trần Hữu Dực, Huế, Thừa Thiên Huế','0412739896','123mail@email.com' UNION ALL
    select 124,N'Trại hoa Võ Löïc',N'Phố 72, Hạ Long, Quảng Ninh','0653606517','124mail@email.com' UNION ALL
    select 125,N'Trại hoa Lê Kỵ',N'Đường Trường Chinh 2, Kiến An, Hải Phòng','0819014319','125mail@email.com' UNION ALL
    select 126,N'Trại hoa Long',N'Đường Đinh Tiên Hoàng, Hạ Long, Quảng Ninh','0389854966','126mail@email.com' UNION ALL
    select 127,N'Trại hoa Hân',N'Đường Thới An 32, Quận 12, Hồ Chí Minh','0121082642','127mail@email.com' UNION ALL
    select 128,N'Trại hoa Tuân',N'Đường 40, Gò Vấp, Hồ Chí Minh','0711827145','128mail@email.com' UNION ALL
    select 129,N'Trại hoa Quỳnh',N'Đường Nguyễn Đăng Giai, Sơn Trà, Đà Nẵng','0793829635','129mail@email.com' UNION ALL
    select 130,N'Trại hoa Nguyễn Tình',N'Đường Hoành Hữu Chấp, Vạn Ninh, Khánh Hòa','0477319670','130mail@email.com' UNION ALL
    select 131,N'Trại hoa Sĩ',N'Đường Hoàng Thiều Hoa, Tân Phú, Hồ Chí Minh','0569367414','131mail@email.com' UNION ALL
    select 132,N'Trại hoa Khánh',N'Đường Nguyễn Thiện, Bỉm Sơn, Thanh Hóa','0583150179','132mail@email.com' UNION ALL
    select 133,N'Trại hoa Só',N'Đường Bà Điểm, Bình Chánh, Hồ Chí Minh','0451886938','133mail@email.com' UNION ALL
    select 134,N'Trại hoa Nguyễn Luật',N'Đường Bế Văn Đàn, Thuận An, Bình Dương','0938098040','134mail@email.com' UNION ALL
    select 135,N'Trại hoa Trường',N'Đường Ngọc Châu, Hạ Long, Quảng Ninh','0623069264','135mail@email.com' UNION ALL
    select 136,N'Trại hoa Binh',N'Đường Nguyễn Hữu Thọ, Gò Dầu, Tây Ninh','0805881131','136mail@email.com' UNION ALL
    select 137,N'Trại hoa Anh',N'Đường Bến Tràm, Phú Quốc, Kiên Giang','0618828771','137mail@email.com' UNION ALL
    select 138,N'Trại hoa Chung',N'Đường Dân Chủ, Tân Uyên, Bình Dương','0563872652','138mail@email.com' UNION ALL
    select 139,N'Trại hoa Chinh',N'Đường 22, Bình Tân, Hồ Chí Minh','0743968950','139mail@email.com' UNION ALL
    select 140,N'Trại hoa Nguyễn Sang',N'Đường ĐT 830, Cần Giuộc, Long An','0361135153','140mail@email.com' UNION ALL
    select 141,N'Trại hoa Đặng Duy',N'Đường Vũng Thiện, Dĩ An, Bình Dương','0375859756','141mail@email.com' UNION ALL
    select 142,N'Trại hoa Lợi',N'Đường 21/3, Xuân Lộc, Đồng Nai','0350881946','142mail@email.com' UNION ALL
    select 143,N'Trại hoa Tuấn',N'Đường Lê Hồng Phong, Điện Bàn, Quảng Nam','0227167784','143mail@email.com' UNION ALL
    select 144,N'Trại hoa Tuấn',N'Đường Ông Ích Khiêm, Xuyên Mộc, Bà Rịa Vũng Tàu','0472909383','144mail@email.com' UNION ALL
    select 145,N'Trại hoa Tiến',N'Đường Từ Lương Xâm, Hải An, Hải Phòng','0612385979','145mail@email.com' UNION ALL
    select 146,N'Trại hoa Võ Thành',N'Đường Công Nghiệp 4, Long Biên, Hà Nội','0713412501','146mail@email.com' UNION ALL
    select 147,N'Trại hoa Phan Đạt',N'Đường Khánh Bình 38, Tân Uyên, Bình Dương','0597502391','147mail@email.com' UNION ALL
    select 148,N'Trại hoa Hồ Trực',N'Đường Khuê Bắc 1, Ngũ Hành Sơn, Đà Nẵng','0956081830','148mail@email.com' UNION ALL
    select 149,N'Trại hoa Việt',N'Đường Cận Sơn 2, Kiến An, Hải Phòng','0632524292','149mail@email.com' UNION ALL
    select 150,N'Trại hoa Nguyễn Phúc',N'Đường Phan Văn Trị, Nhơn Trạch, Đồng Nai','0693807854','150mail@email.com';

set identity_insert NhaCungCap off;