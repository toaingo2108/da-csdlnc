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
	@DiaChiKH NVARCHAR(255),
	@error nvarchar(MAX) output
AS 
BEGIN 
SET IDENTITY_INSERT KHACHHANG ON
	begin try
	IF EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
	begin
			RAISERROR ('Mã khách hàng %d đã tồn tại', 11, 1, @MaKH)
			RETURN 2
	end
		
	INSERT INTO KHACHHANG(MAKH, HOKH,TENKH,SDT_KH,EmailKH,MatKhauKH,DiaChiKH) VALUES (@MAKH, @HOKH,@TENKH,@SDT_KH,@EmailKH,@MatKhauKH,@DiaChiKH) 
	RETURN 1
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
SET IDENTITY_INSERT KHACHHANG OFF
END 
go 

------------------------------------------
--16.   Sửa thông tin tài khoản khách hàng
CREATE 
PROC uspSUAKHACHHANG 
	@MAKH INT, 
	@HOKH nvarchar(30), 
	@TENKH nvarchar(30), 
	@SDT_KH VARCHAR(15), 
	@EmailKH VARCHAR(30), 
	@MatKhauKH VARCHAR(20),
	@DiaChiKH NVARCHAR(255),
	@error nvarchar(MAX) output
AS 
BEGIN 
	BEGIN TRY
		IF NOT EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		begin
				RAISERROR ('Mã khách hàng %d không tồn tại', 11, 1, @MaKH)
				RETURN 2
		end
		UPDATE KHACHHANG SET HoKH=@HOKH, TenKH=@TENKH, SDT_KH=@SDT_KH,EmailKH=@EmailKH,MatKhauKH=@MatKhauKH,DiaChiKH=@DiaChiKH
		WHERE MaKH=@MAKH
		RETURN 1
	END TRY
	BEGIN CATCH
		SET @error = ERROR_MESSAGE()
	END CATCH

END 
go 
--17.   Xem tình trạng đơn hàng và giao hàng
CREATE 
PROC uspXEMTINHTRANGDONHANG 
	@MADH INT,
	@error nvarchar(MAX) output
AS 
BEGIN 
	BEGIN TRY
		IF NOT EXISTS (SELECT* FROM DONHANG WHERE MaDH = @MADH)
		begin
				RAISERROR ('Mã đơn hàng %d không tồn tại', 11, 1, @MaDH)
				RETURN 2
		end
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
	END TRY
	BEGIN CATCH
		SET @error = ERROR_MESSAGE()
	END CATCH
END 
go 
--18.   Thêm và xem yêu cầu hỗ trợ
-- Thêm
CREATE 
PROC usp_THEMYEUCAUHOTRO
	@MaYC INT,
	@MaKH INT,
	@Noidung NVARCHAR(MAX),
	@TrangThaiYCau TINYINT,
	@error nvarchar(MAX) output
AS 
BEGIN 
SET IDENTITY_INSERT YeuCauHoTro ON
	BEGIN TRY
		IF EXISTS (SELECT* FROM YeuCauHoTro WHERE MaYC = @MAYC)
		begin
				RAISERROR ('Mã yêu cầu hỗ trợ %d đã tồn tại', 11, 1, @MaYC)
				RETURN 2
		end
		IF NOT EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		begin
				RAISERROR ('Mã khách hàng %d không tồn tại', 11, 1, @MaKH)
				RETURN 3
		end
		INSERT INTO YeuCauHoTro(MaYC,MaKH,Noidung,TrangThaiYCau) VALUES (@MaYC,@MaKH,@Noidung,@TrangThaiYCau)
		RETURN 1
	END TRY
	BEGIN CATCH
		SET @error = ERROR_MESSAGE()
	END CATCH
SET IDENTITY_INSERT YeuCauHoTro OFF
END 
go 
-- Xem
CREATE
PROC usp_XEMYEUCAUHOTRO
	@MaYC INT,
	@MaKH INT,
	@error nvarchar(MAX) output
AS 
BEGIN 
	BEGIN TRY
		IF NOT EXISTS (SELECT* FROM YeuCauHoTro WHERE MaYC = @MAYC)
		begin
				RAISERROR ('Mã yêu cầu hỗ trợ %d không tồn tại', 11, 1, @MaYC)
				RETURN 2
		end
		IF NOT EXISTS (SELECT* FROM KHACHHANG WHERE MaKH = @MAKH)
		begin
				RAISERROR ('Mã khách hàng %d không tồn tại', 11, 1, @MaKH)
				RETURN 3
		end
		SELECT * FROM YeuCauHoTro WHERE MaYC=@MAYC
		RETURN 1
	END TRY
	BEGIN CATCH
		SET @error = ERROR_MESSAGE()
	END CATCH
END 
go 
--19.   Tìm kiếm sản phẩm có chứa chuỗi "…."

CREATE 
PROC usp_TIMSANPHAM
	@CHUOICANTIM NVARCHAR(50)
	
AS 
BEGIN 
		SELECT * FROM SANPHAM WHERE TenSP LIKE '%'+@CHUOICANTIM+'%'
		RETURN 1
END 
go 

--20.   Xem danh sách sản phẩm theo một khoảng đơn giá
CREATE 
PROC usp_XEMSANPHAM
	@MIN INT,
	@MAX INT,
	@error nvarchar(MAX) output
AS
BEGIN
	BEGIN TRY
		IF(@MIN >= @MAX)
		BEGIN
			RAISERROR('Khoảng giá không hợp lệ!', 11, 1)
		END
		
		SELECT * FROM SanPham
		WHERE (@MAX>= GiaSauGiam AND @MIN <= GiaSauGiam)
		RETURN 1
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
END
