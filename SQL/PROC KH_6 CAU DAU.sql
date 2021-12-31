USE QLDH
GO
--15.   Thêm tài khoản khách hàng
CREATE 
PROC uspTHEMKHACHHANG 
	@MAKH INT, 
	@HOKH nvarchar(30), 
	@TENKH nvarchar(30), 
	@SDT_KH VARCHAR(15), 
	@EmailKH VARCHAR(30), 
	@MatKhauKH VARCHAR(20),
	@DiaChiKH NVARCHAR(255)
AS 
BEGIN 
SET IDENTITY_INSERT KHACHHANG ON
	IF EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		RETURN 2
	INSERT INTO KHACHHANG(MAKH, HOKH,TENKH,SDT_KH,EmailKH,MatKhauKH,DiaChiKH) VALUES (@MAKH, @HOKH,@TENKH,@SDT_KH,@EmailKH,@MatKhauKH,@DiaChiKH) 
	RETURN 1
SET IDENTITY_INSERT KHACHHANG OFF
END 
go 
--16.   Sửa thông tin tài khoản khách hàng
CREATE 
PROC uspSUAKHACHHANG 
	@MAKH INT, 
	@HOKH nvarchar(30), 
	@TENKH nvarchar(30), 
	@SDT_KH VARCHAR(15), 
	@EmailKH VARCHAR(30), 
	@MatKhauKH VARCHAR(20),
	@DiaChiKH NVARCHAR(255)
AS 
BEGIN 
	IF NOT EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		RETURN 2
	UPDATE KHACHHANG SET HoKH=@HOKH, TenKH=@TENKH, SDT_KH=@SDT_KH,EmailKH=@EmailKH,MatKhauKH=@MatKhauKH,DiaChiKH=@DiaChiKH
	WHERE MaKH=@MAKH
	RETURN 1
END 
go 
--17.   Xem tình trạng đơn hàng và giao hàng
CREATE 
PROC uspXEMTINHTRANGDONHANG 
	@MADH INT
AS 
BEGIN 
	IF NOT EXISTS (SELECT* FROM DONHANG WHERE MaDH = @MADH)
		RETURN 2
	DECLARE @TT TINYINT
	SET @TT = (SELECT TrangThaiDH FROM DONHANG WHERE MaDH = @MADH)
	IF (@TT = 1)
		PRINT(N'Đơn hàng đã giao')
		RETURN 1
	IF (@TT = 2)
		PRINT(N'Đơn hàng chưa hoàn thành')
		RETURN 1
	IF (@TT = 3)
		PRINT(N'Đơn hàng đã hủy')
		RETURN 1
	IF (@TT = 0)
		PRINT(N'Đơn hàng chưa giao')
		RETURN 1
END 
go 
--18.   Thêm và xem yêu cầu hỗ trợ
-- Thêm
CREATE 
PROC usp_THEMYEUCAUHOTRO
	@MaYC INT,
	@MaKH INT,
	@Noidung NVARCHAR(MAX),
	@TrangThaiYCau TINYINT
AS 
BEGIN 
SET IDENTITY_INSERT YeuCauHoTro ON
	IF EXISTS (SELECT* FROM YeuCauHoTro WHERE MaYC = @MAYC)
		RETURN 2
	IF NOT EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		RETURN 3
	INSERT INTO YeuCauHoTro(MaYC,MaKH,Noidung,TrangThaiYCau) VALUES (@MaYC,@MaKH,@Noidung,@TrangThaiYCau)
	RETURN 1
SET IDENTITY_INSERT YeuCauHoTro OFF
END 
go 
-- Xem
CREATE
PROC usp_XEMYEUCAUHOTRO
	@MaYC INT,
	@MaKH INT
AS 
BEGIN 
	IF NOT EXISTS (SELECT* FROM YeuCauHoTro WHERE MaYC = @MAYC)
		RETURN 2
	IF NOT EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		RETURN 3
	SELECT * FROM YeuCauHoTro WHERE MaYC=@MAYC
	RETURN 1
END 
go 
--19.   Tìm kiếm sản phẩm có chứa chuỗi "…."

CREATE 
PROC usp_TIMSANPHAM
	@CHUOICANTIM NVARCHAR(50)
AS 
BEGIN 
	DECLARE @TENLUOCDO VARCHAR(50), @TENBANG VARCHAR(50)
	SET @TENLUOCDO = 'TenSP'
	SET @TENBANG = 'SanPham'
	DECLARE @sqlCommand varchar(max) = 'SELECT * FROM [' + @TENLUOCDO + '].[' + @TENBANG + '] WHERE ' 
	   
   SELECT @sqlCommand = @sqlCommand + '[' + COLUMN_NAME + '] LIKE ''' + @CHUOICANTIM + ''' OR '
   FROM INFORMATION_SCHEMA.COLUMNS 
   WHERE TABLE_SCHEMA = @TENLUOCDO
   AND TABLE_NAME = @TENBANG 
   AND DATA_TYPE IN ('char','nchar','ntext','nvarchar','text','varchar')

   SET @sqlCommand = left(@sqlCommand,len(@sqlCommand)-3)
   EXEC (@sqlCommand)
   PRINT @sqlCommand
	RETURN 1
END 
go 
--20.   Xem danh sách sản phẩm theo một khoảng đơn giá
CREATE 
PROC usp_XEMSANPHAM
	@MIN INT,
	@MAX INT
AS
BEGIN
	SELECT * FROM SanPham
	WHERE (@MIN <= GiaSauGiam AND @MAX>= GiaSauGiam)
	RETURN 1
END