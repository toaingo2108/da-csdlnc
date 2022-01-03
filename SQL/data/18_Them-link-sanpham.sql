USE QLDH
GO

ALTER TABLE SanPham
   ADD LinkHinhAnh varchar(500);
GO

-- TABLE này dùng để update link cho sanpham
CREATE TABLE link
(
    id INT PRIMARY KEY IDENTITY,
    LinkHinhAnh varchar(500)
)


INSERT INTO link (linkHinhAnh) VALUES
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/4342_dai-phu-quy.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/4940_loc-phat.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-khuyen-mai/10708_you-are-beautiful.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/5236_mau-cua-nang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/3043_rose-rapture.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/6041_bo-hoa-tu-cau.jpg'),
    ('https://hoayeuthuong.com/shop-hoa/bo-hoa-tuoi/3199_yeu-xa'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11605_hong-vang-anh-trang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-tuoi-hop/8289_red-box.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/8395_khuc-biet-ly.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/5774_vung-ben.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/10423_uom-nang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/10427_tat-thang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/lan-ho-diep/10420_ho-diep-may-man.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/10693_pink-baby.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/10680_thinking-of-you.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/3113_tien-biet.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/2999_hung-thinh.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/8396_deep-condolences.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/gio-hoa-tuoi/6925_nang-ha.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-tuoi-hop/8290_pink-box.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11668_binh-hong-jumilia.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11672_binh-hong-da.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11671_binh-hong-do-ot.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11677_binh-hong-samilia.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11669_binh-hong-candy.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11604_hong-do-ot--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11605_hong-vang-anh-trang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11529_hong-sen--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11531_hong-trung-ga--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11533_hong-mix--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11528_hong-samilia--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11530_hong-mix--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11532_hong-sen--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11534_hong-do-sa--bong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/3013_gia-biet.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/8390_ki-uc-xua.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/gio-hoa-tuoi/6928_he-ruc-ro.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/gio-hoa-tuoi/10707_ngoc-sac.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-tuoi-hop/8040_sun-flower.jpg'), -- 40
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/10680_thinking-of-you.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/10693_pink-baby.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/lan-ho-diep/10420_ho-diep-may-man.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/10427_tat-thang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/10423_uom-nang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/5774_vung-ben.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/8395_khuc-biet-ly.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-tuoi-hop/8289_red-box.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/11441_sparky.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/5256_yeu-xa.jpg'), -- 50
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/6041_bo-hoa-tu-cau.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/3043_rose-rapture.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/5236_mau-cua-nang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/3856_thanh-cong.jpg'),
    ('https://hoayeuthuong.com/shop-hoa/hoa-chuc-mung/5403_khai-truong-loc-phat'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/4342_dai-phu-quy.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/4342_dai-phu-quy.jpg'),
    ('https://hoayeuthuong.com/shop-hoa/hoa-chuc-mung/5403_khai-truong-loc-phat'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/3856_thanh-cong.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/5236_mau-cua-nang.jpg'), -- 60
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/3043_rose-rapture.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/6041_bo-hoa-tu-cau.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/3199_yeu-xa.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/11605_hong-vang-anh-trang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-tuoi-hop/8289_red-box.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/8395_khuc-biet-ly.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/5774_vung-ben.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/binh-hoa-tuoi/10423_uom-nang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/10427_tat-thang.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/lan-ho-diep/10420_ho-diep-may-man.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/10693_pink-baby.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/bo-hoa-tuoi/10680_thinking-of-you.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chia-buon/3113_tien-biet.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/hoa-chuc-mung/2999_hung-thinh.jpg')
GO


UPDATE SanPham
    SET LinkHinhAnh = (SELECT LinkHinhAnh FROM link WHERE id = MaSP)
    WHERE MaSP < 75

DROP TABLE link
GO
