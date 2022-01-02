USE QLDH
GO
--15.   Thêm tài khoản khách hàng
CREATE 
PROC usp_THEMKHACHHANG
	@HOKH nvarchar(30), 
	@TENKH nvarchar(30), 
	@SDT_KH VARCHAR(15), 
	@EmailKH VARCHAR(30), 
	@MatKhauKH VARCHAR(20),
	@DiaChiKH NVARCHAR(255),
	@error nvarchar(MAX) output
AS 
BEGIN 
	begin try
		INSERT INTO KHACHHANG( HOKH,TENKH,SDT_KH,EmailKH,MatKhauKH,DiaChiKH) 
		output inserted.* 
		VALUES ( @HOKH,@TENKH,@SDT_KH,@EmailKH,@MatKhauKH,@DiaChiKH) 
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
END 
go 
--16.   Sửa thông tin  khách hàng
CREATE 
proc usp_DoiMatKhauKhachHang
	@MaKH int,
	@MatKhauCu varchar(20),
	@MatKhauMoi varchar(20),
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from KhachHang where MaKH = @MaKH)
		begin
			RAISERROR ('Mã khách hàng %d không tồn tại', 11, 1, @MaKH)
		end
	
		declare @MatKhauKH varchar(20)
		set @MatKhauKH = (select MatKhauKH from KhachHang where MaKH = @MaKH)

		if (@MatKhauKH != @MatKhauCu)
		begin
			RAISERROR ('Mật khẩu cũ không chính xác', 11, 2)
		end

		update KhachHang set MatKhauKH = @MatKhauMoi
		output inserted.* 
		where MaKH = @MaKH
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end
GO

CREATE
--alter
PROC uspSUAKHACHHANG
	@MAKH INT, 
	@HOKH nvarchar(30), 
	@TENKH nvarchar(30), 
	@SDT_KH VARCHAR(15), 
	@EmailKH VARCHAR(30), 
	@DiaChiKH NVARCHAR(255),
	@error nvarchar(MAX) output
AS 
BEGIN 
	begin try
		IF NOT EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		begin
			RAISERROR ('Mã khách hàng %d không tồn tại', 11, 1, @MAKH)
		end
		UPDATE KHACHHANG  SET HoKH=@HOKH, TenKH=@TENKH, SDT_KH=@SDT_KH,EmailKH=@EmailKH,DiaChiKH=@DiaChiKH
		output inserted.*
		WHERE MaKH=@MAKH
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
END 
GO
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
END