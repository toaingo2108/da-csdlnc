USE QLDH
GO

ALTER TABLE QuaTangKem
ADD LinkHinhAnh NVARCHAR(500)

CREATE TABLE LinkHinhAnh
(
    id INT PRIMARY KEY IDENTITY,
    link NVARCHAR(500),
)
GO

UPDATE QuaTangKem
    SET TenQT = 'Plum Blossom'
    WHERE MaQTang = 14
UPDATE QuaTangKem
    SET TenQT = 'Pomegranate & Sage'
    WHERE MaQTang = 15
UPDATE QuaTangKem
    SET TenQT = N'Giỏ táo xanh'
    WHERE MaQTang = 16
UPDATE QuaTangKem
    SET TenQT = N'Pear & Sage'
    WHERE MaQTang = 17
UPDATE QuaTangKem
    SET TenQT = N'Mocha Square 2'
    WHERE MaQTang = 18   
UPDATE QuaTangKem
    SET TenQT = N'Yogurt strawberry'
    WHERE MaQTang = 19
GO

INSERT INTO LinkHinhAnh 
    (link)
    VALUES
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/gau-bong/12522_teddy-ca-tinh-size.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/gau-bong/12243_tho-sweetie-hong-vay-xoe.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/gau-bong/11228_teddy-honey.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/gau-bong/11222_husky-kem-chan.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/banh-kem-tous-les-jours/8454_propose-heart.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/banh-kem-tous-les-jours/8436_purple-dream-fresh.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/banh-kem-tous-les-jours/8437_fruity-fresh-cream.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/banh-kem-tous-les-jours/8434_square-choco.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/trai-cay/3734_apple-mix.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/trai-cay/3748_oranges-box.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/trai-cay/3751_fresh-fruit.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/nen-thom-va-hoa/12255_holiday-blue-spruce.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/trai-cay/3742_fresh-fruit.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/nen-thom-va-hoa/12253_plum-blossom.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/nen-thom-va-hoa/12251_pomegranate-sage.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/trai-cay/3730_green-apples.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/nen-thom-va-hoa/12249_pear-sage.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/banh-kem-tous-les-jours/8428_mocha-square.jpg'),
    ('https://hyt.r.worldssl.net/hinh-hoa-tuoi/banh-kem-tous-les-jours/8427_yogurt-strawberry.jpg')
GO

DECLARE @maQT INT = 1

WHILE @maQT < 20
BEGIN
    UPDATE QuaTangKem
        SET LinkHinhAnh = (SELECT link FROM LinkHinhAnh WHERE id = @maQT)
        WHERE MaQTang = @maQT
    SET @maQT = @maQT + 1
END
GO

DROP TABLE LinkHinhAnh