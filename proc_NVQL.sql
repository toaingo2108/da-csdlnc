USE QLDH

GO
--Tao don nhap
CREATE -- ALTER
PROC TaoDonNhap
	@ngaynhanhang DATE,
	@mancc INT,
	@macnhanh INT,
	@madn INT OUTPUT
AS
BEGIN
	IF NOT EXISTS (SELECT *
		FROM NhaCungCap
		WHERE MaNCC = @mancc)
	BEGIN
		PRINT 'Khong ton tai nha cung cap nay!'
		RETURN 0
	END
	IF NOT EXISTS (SELECT *
		FROM ChiNhanh
		WHERE MaCNhanh = @macnhanh)
	BEGIN
		PRINT 'Khong ton tai chi nhanh nay!'
		RETURN 0
	END
	--them don nhap
	SET @madn = 1
	INSERT DonNhap (TongTienNhap,NgayNhanHang,MaNCC,MaCNhanh)
		VALUES (0, @ngaynhanhang, @mancc, @macnhanh)
	PRINT 'Them don nhap thanh cong!'
	SET @madn = @@IDENTITY
	RETURN 1
END

GO
--Tao chi tiet don nhap
CREATE -- ALTER
PROC TaoChiTietDonNhap
	@madn INT,
	@masp INT,
	@soluongnhap INT,
	@gianhap INT
AS
BEGIN
	IF NOT EXISTS (SELECT *
	FROM SanPham
	WHERE MaSP = @masp)
	BEGIN
		PRINT 'Khong ton tai san pham nay!'
		RETURN 0
	END
	IF NOT EXISTS (SELECT *
	 	FROM DonNhap
		WHERE MaDNhap = @madn)
	BEGIN
		PRINT 'Khong ton tai don nhap nay!'
		RETURN 0
	END
	--them chi tiet don nhap
	DECLARE @thanhtien INT
	SET @thanhtien = @soluongnhap * @gianhap
	INSERT ChiTietDNhap
	VALUES
		(@madn, @masp, @soluongnhap, @gianhap, @thanhtien)
	PRINT 'Them chi tiet don nhap thanh cong!'
	
	--cap nhat lai don nhap
	DECLARE @tongtiennhap INT
	SELECT @tongtiennhap = TongTienNhap
	FROM DonNhap
	WHERE MaDNhap = @madn
	SET @tongtiennhap = @tongtiennhap + @thanhtien
	UPDATE DonNhap SET TongTienNhap = @tongtiennhap WHERE MaDNhap = @madn
	
	--cap nhat so luong ton
	DECLARE @soluongton INT, @macnhanh INT
	SELECT @soluongton = SPCN.SoLuongTon, @macnhanh=SPCN.MaCNhanh
	FROM SP_CN SPCN, DonNhap DN
	WHERE SPCN.MaCNhanh = DN.MaCNhanh AND SPCN.MaSP=@masp
	SET @soluongton = @soluongton - @soluongnhap
	UPDATE SP_CN SET SoLuongTon = @soluongton WHERE MaSP = @masp AND MaCNhanh = @macnhanh
END

GO
--Them lich su thuong nhan vien
CREATE -- ALTER
PROC ThemLichSuThuong
	@manv INT,
	@tienthuong INT,
	@lydo NVARCHAR(500)
AS
BEGIN
	IF NOT EXISTS (SELECT *
	FROM NhanVien
	WHERE MaNV = @manv)
	BEGIN
		PRINT 'Khong ton tai nhan vien nay!'
		RETURN 0
	END
	IF (@tienthuong < 0)
	BEGIN
		PRINT 'Tien thuong phai la mot so nguyen duong!'
		RETURN 0
	END
	--them lich su thuong
	INSERT LichSuThuong (TienThuong,NgayThuong,MaNV,LyDo)
		VALUES (@tienthuong, GETDATE(), @manv, @lydo)
	PRINT 'Them lich su thuong thanh cong!'
END

GO
--Them lich su luong nhan vien
CREATE -- ALTER
PROC ThemLichSuLuong
	@manv INT,
	@luong INT
AS
BEGIN
	IF NOT EXISTS (SELECT *
	FROM NhanVien
	WHERE MaNV = @manv)
	BEGIN
		PRINT 'Khong ton tai nhan vien nay!'
		RETURN 0
	END
	IF (@luong <= 0)
	BEGIN
		PRINT 'Luong phai la mot so nguyen duong!'
		RETURN 0
	END
	--them lich su luong + cap nhat luong
	INSERT LichSuLuong 
		(MaNV,NgayBD,Luong)
		VALUES 
		(@manv, GETDATE(), @luong)
	PRINT 'Them lich su luong thanh cong!'
	UPDATE NhanVien 
		SET LuongHienTai = @luong 
		WHERE MaNV=@manv
	PRINT 'Cap nhat luong nhan vien thanh cong!'
END

GO
--Them san pham
CREATE -- ALTER
PROC ThemSanPham
	@tensp NVARCHAR(50),
	@chude TINYINT,
	@mausac TINYINT,
	@loaihoa SMALLINT,
	@mota NVARCHAR(MAX),
	@trangthaihd BIT,
	@giatruocgiam INT,
	@giasaugiam INT
AS
BEGIN
	IF EXISTS (SELECT *
		FROM SanPham
		WHERE TenSP like @tensp)
	BEGIN
		PRINT 'San pham da co san. Khong the them duoc!'
		RETURN 0
	END
	--them lich su luong + cap nhat luong
	INSERT SanPham 
		(TenSP, ChuDe,MauSac,LoaiHoa,MoTa,TrangThaiHD,GiaTruocGiam,GiaSauGiam)
		VALUES 
		(@tensp, @chude, @mausac, @loaihoa, @mota, @trangthaihd, @giatruocgiam, @giasaugiam)
	PRINT 'Them san pham thanh cong!'
END

GO
--Sua san pham
CREATE -- ALTER
PROC SuaSanPham
	@masp INT,
	@tensp NVARCHAR(50),
	@chude TINYINT,
	@mausac TINYINT,
	@loaihoa SMALLINT,
	@mota NVARCHAR(max),
	@trangthaihd BIT,
	@giatruocgiam INT,
	@giasaugiam INT
AS
BEGIN
	IF NOT EXISTS (SELECT *
		FROM SanPham
		WHERE MaSP = @masp)
	BEGIN
		PRINT 'Khong ton tai san pham nay!'
		RETURN 0
	END
	IF EXISTS (SELECT *
		FROM SanPham
		WHERE TenSP like @tensp)
	BEGIN
		PRINT 'San pham da co san. Khong the sua duoc!'
		RETURN 0
	END
	
	--sua thong tin san pham 
	UPDATE SanPham SET TenSP = @tensp WHERE MaSP = @masp
	UPDATE SanPham SET ChuDe = @chude WHERE MaSP = @masp
	UPDATE SanPham SET MauSac = @mausac WHERE MaSP = @masp
	UPDATE SanPham SET LoaiHoa = @loaihoa WHERE MaSP = @masp
	UPDATE SanPham SET MoTa = @mota WHERE MaSP = @masp
	UPDATE SanPham SET TrangThaiHD = @trangthaihd WHERE MaSP = @masp
	
	--them lich su gia
	DECLARE @giacu INT, @giamoi INT
	SELECT @giacu = GiaTruocGiam, @giamoi = GiaSauGiam
		FROM SanPham
		WHERE MaSP = @masp
	IF (@giacu != @giatruocgiam OR @giamoi != @giasaugiam)
		INSERT LichSuGia
		(MaSP,GiaTruocGiam,GiaSauGiam,NgayApDung)
	VALUES
		(@masp, @giacu, @giamoi, GETDATE())
	UPDATE SanPham SET GiaTruocGiam = @giatruocgiam WHERE MaSP = @masp
	UPDATE SanPham SET GiaSauGiam = @giasaugiam WHERE MaSP = @masp
	PRINT 'Sua san pham thanh cong!'
END

GO
--Xoa san pham
CREATE -- ALTER
PROC XoaSanPham
	@masp INT
AS
BEGIN
	IF NOT EXISTS (SELECT *
		FROM SanPham
		WHERE MaSP = @masp)
	BEGIN
		PRINT 'Khong ton tai san pham nay!'
		RETURN 0
	END
	--sua trang thai hoat dong
	UPDATE SanPham SET TrangThaiHD = 0 WHERE MaSP = @masp
	PRINT 'Xoa san pham thanh cong!'
END

GO
--Tao don hang
CREATE -- ALTER
PROC TaoDonHang
	@sdt_ngnhan char(10),
	@hinhthuctt TINYINT,
	@trangthaidh TINYINT,
	@phigiaohang INT,
	@makh INT,
	@maqtang INT,
	@macnhanh INT ,
	@makv INT,
	@madh INT OUTPUT
AS
BEGIN
	IF NOT EXISTS (SELECT *
	FROM KhachHang
	WHERE MaKH = @makh)
	BEGIN
		PRINT 'Khong ton tai khach hang nay!'
		RETURN 0
	END
	IF NOT EXISTS (SELECT *
	FROM QuaTangKem
	WHERE MaQTang = @maqtang)
	BEGIN
		PRINT 'Khong ton tai qua tang nay!'
		RETURN 0
	END
	IF NOT EXISTS (SELECT *
		FROM ChiNhanh
		WHERE MaCNhanh = @macnhanh)
	BEGIN
		PRINT 'Khong ton tai chi nhanh nay!'
		RETURN 0
	END
	--them don hang
	DECLARE @giaquatang INT
	IF (@maqtang != null)
		SELECT @giaquatang = Gia
		FROM QuaTangKem
		WHERE MaQTang = @maqtang
	ELSE
		SET @giaquatang = 0
	SET @madh = 1
	INSERT DONHANG
		(SDT_NgNhan, NgayLap, HinhThucTT, TrangThaiDH, TongTienSP, PhiGiaoHang, 
		TongTienDH, MaKH, MaQTang, MaCNhanh, MaKV)
	VALUES
		(@sdt_ngnhan, GETDATE(), @hinhthuctt, @trangthaidh, @giaquatang, @phigiaohang, 
		0, @makh, @maqtang, @macnhanh, @makv)
	SET @madh = @@IDENTITY
	RETURN 1
END

GO
--Tao chi tiet don hang
CREATE -- ALTER
PROC TaoChiTietDonHang
	@madh INT,
	@masp INT,
	@soluongdat INT
AS
BEGIN
	IF NOT EXISTS (SELECT *
	FROM SanPham
	WHERE MaSP = @masp)
	BEGIN
		PRINT 'Khong ton tai san pham nay!'
		RETURN 0
	END
	IF NOT EXISTS (SELECT *
	FROM DonHang
	WHERE MaDH = @madh)
	BEGIN
		PRINT 'Khong ton tai don hang nay!'
		RETURN 0
	END
	
	DECLARE @soluongton INT, @macnhanh INT
	SELECT @soluongton = SPCN.SoLuongTon, @macnhanh = SPCN.MaCNhanh
		FROM SP_CN SPCN, DonHang DH
		WHERE SPCN.MaCNhanh = DH.MaCNhanh AND SPCN.MaSP = @masp
	IF (@soluongdat <= 0 OR @soluongdat > @soluongton) 
	BEGIN
		PRINT 'So luong khong du de dat hang!'
		RETURN 0
	END
	
	--them chi tiet don hang
	DECLARE @giaban INT, @tensp NVARCHAR(50), @thanhtien INT
	SELECT @giaban = GiaSauGiam, @tensp = TenSP
		FROM SanPham
		WHERE MaSP = @masp
	SET @thanhtien = @soluongdat * @giaban
	INSERT ChiTietDH
		VALUES
		(@masp, @madh, @soluongdat, @giaban, @tensp, @thanhtien)
	PRINT 'Them chi tiet don hang thanh cong!'
	
	--cap nhat lai don hang
	DECLARE @tongtiensp INT, @phigh INT, @tongtiendh INT
	SELECT @tongtiensp = TongTienSP, @phigh = PhiGiaoHang
		FROM DonHang
		WHERE MaDH = @madh
	SET @tongtiensp = @tongtiensp + @thanhtien
	SET @tongtiendh = @tongtiensp + @phigh
	UPDATE DonHang SET TongTienSP = @tongtiensp,TongTienDH = @tongtiendh WHERE MaDH = @madh
	
	--cap nhat lai so luong ton san pham
	SET @soluongton = @soluongton - @soluongdat
	UPDATE SP_CN SET SoLuongTon = @soluongton WHERE MaSP = @masp AND MaCNhanh = @macnhanh
END
