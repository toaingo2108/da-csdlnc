use QLDH
--Nhân viên quản lý
--Thêm nhân viên
go
create 
--alter
proc usp_ThemNhanVien
	@HoTenNV NVARCHAR(50),
	@LuongHienTai INT,
	@TrangThaiHD BIT,
	@TenCViec NVARCHAR(50),
	@MaCViec INT,
	@MaCNhanh INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)
		insert into NhanVien (HoTenNV, LuongHienTai, TrangThaiHD, TenCViec, MaCViec, MaCNhanh) 
		output inserted.* 
		values (@HoTenNV, @LuongHienTai, @TrangThaiHD, @TenCViec, @MaCViec, @MaCNhanh)
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--Sửa nhân viên
go
create 
--alter
proc usp_SuaNhanVien
	@MaNV INT,
	@HoTenNV NVARCHAR(50),
	@LuongHienTai INT,
	@TrangThaiHD BIT,
	@TenCViec NVARCHAR(50),
	@MaCViec INT,
	@MaCNhanh INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		if not exists(select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)
		update NhanVien set HoTenNV = @HoTenNV, 
							LuongHienTai = @LuongHienTai, 
							TrangThaiHD = @TrangThaiHD,
							TenCViec = @TenCViec,
							MaCViec = @MaCViec,
							MaCNhanh = @MaCNhanh
						output inserted.*
						where MaNV = @MaNV
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--Xóa nhân viên
go 
create
--alter 
proc usp_XoaNhanVien
	@MaNV int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhanVien where MaNV = @MaNV)
		begin
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		end

		update NhanVien set TrangThaiHD = 0 
		output inserted.*
		where MaNV = @MaNV
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--Thêm nhà cung cấp
go
create 
--alter
proc usp_ThemNhaCungCap
	@TenNCC NVARCHAR(50),
	@DiaChiNCC NVARCHAR(255),
	@SDT_NCC VARCHAR(15),
	@EmailNCC VARCHAR(30),
	@error nvarchar(MAX) output
as
begin
	begin try
		insert NhaCungCap(TenNCC,DiaChiNCC,SDT_NCC,EmailNCC) 
		output inserted.* 
		values (@TenNCC,@DiaChiNCC,@SDT_NCC,@EmailNCC)
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--Sửa nhà cung cấp
go
create 
--alter
proc usp_SuaNhaCungCap
	@MaNCC INT,
	@TenNCC NVARCHAR(50),
	@DiaChiNCC NVARCHAR(255),
	@SDT_NCC VARCHAR(15),
	@EmailNCC VARCHAR(30),
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhaCungCap where MaNCC = @MaNCC)
			RAISERROR (N'Mã nhà cung cấp %d không tồn tại', 11, 1, @MaNCC)
		update NhaCungCap set TenNCC = @TenNCC, 
							DiaChiNCC = @DiaChiNCC, 
							SDT_NCC = @SDT_NCC,
							EmailNCC = @EmailNCC
						output inserted.*
						where MaNCC = @MaNCC
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--Tạo đơn nhập
go
create 
--alter
proc usp_ThemDonNhap 
	@NgayNhanHang DATE, 
	@MaNCC INT, 
	@MaCNhanh INT, 
	@MaDNhap INT output,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from NhaCungCap where MaNCC = @MaNCC)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaNCC)
		if not exists(select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã nhà cung cấp %d không tồn tại', 11, 1, @MaCNhanh)
		
		set @MaDNhap = 1
		insert DonNhap(TongTienNhap,NgayNhanHang,MaNCC,MaCNhanh) 
		output inserted.* 
		values(0,@NgayNhanHang,@MaNCC,@MaCNhanh)
		set @MaDNhap = @@IDENTITY
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--Tạo chi tiết đơn nhập
go
create 
--alter
proc usp_ThemChiTietDonNhap 
	@MaDNhap INT, 
	@MaSP INT, 
	@SoLuong INT, 
	@GiaNhap INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from DonNhap where MaDNhap = @MaDNhap)
			RAISERROR (N'Mã đơn nhập %d không tồn tại', 11, 1, @MaDNhap)
		if not exists(select * from SanPham where MaSP = @MaSP)
			RAISERROR (N'Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		--them chi tiet don nhap
		declare @ThanhTienNH int
		set @ThanhTienNH = @SoLuong * @GiaNhap
		insert ChiTietDNhap 
		output inserted.* 
		values(@MaDNhap,@MaSP,@SoLuong,@GiaNhap,@ThanhTienNH)
		--cap nhat lai don nhap
		declare @TongTienNhap int
		select @TongTienNhap = TongTienNhap from DonNhap where MaDNhap=@MaDNhap
		set @TongTienNhap = @TongTienNhap + @ThanhTienNH
		update DonNhap set TongTienNhap=@TongTienNhap 
		output inserted.* 
		where MaDNhap=@MaDNhap
		--cap nhat so luong ton
		declare @SoLuongTon int, @MaCNhanh int
		select @SoLuongTon=SPCN.SoLuongTon, @MaCNhanh=SPCN.MaCNhanh 
			from SP_CN SPCN join DonNhap DN on SPCN.MaCNhanh=DN.MaCNhanh where SPCN.MaSP=@MaSP
		set @SoLuongTon = @SoLuongTon + @SoLuong
		update SP_CN set SoLuongTon=@SoLuongTon 
		output inserted.* 
		where MaSP=@MaSP and MaCNhanh=@MaCNhanh
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--Thêm lịch sử thưởng nhân viên
go
create 
--alter
proc ThemLichSuThuong 
	@TienThuong INT, 
	@NgayThuong DATE,
	@MaNV INT, 
	@LyDo NVARCHAR(500),
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		if (@TienThuong < 0)
			RAISERROR (N'Tiền thưởng phải lớn hơn 0', 11, 1)

		insert LichSuThuong(TienThuong,NgayThuong,MaNV,LyDo) 
		output inserted.* 
		values(@TienThuong,@NgayThuong,@MaNV,@LyDo)
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end


--Thêm lịch sử lương nhân viên
go
create 
--alter
proc ThemLichSuLuong 
	@MaNV INT, 
	@NgayBD DATE,
	@Luong INT, 
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		if (@Luong < 0)
			RAISERROR (N'Lương phải lớn hơn 0', 11, 1)

		insert LichSuLuong(MaNV,NgayBD,Luong) 
		output inserted.* 
		values(@MaNV,@NgayBD,@Luong)
		
		update NhanVien set LuongHienTai=@Luong 
		output inserted.* 
		where MaNV=@MaNV
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--Xem sản phẩm bán chạy nhất
go
create 
--alter
proc usp_XemTop10SanPham
	@error nvarchar(MAX) output
as
begin
	begin try
		select top 10 SP.MaSP, SP.TenSP, SUM(CT.SoLuongSP) AS TongSL 
		from  SanPham SP join ChiTietDH CT on SP.MaSP = CT.MasP
		where SP.TrangThaiHD = 1
		group by SP.MaSP, SP.TenSP
		order by SUM(CT.SoLuongSP) DESC
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--Xem sản phẩm có hàng tồn kho < 10
go
create 
--alter
proc usp_XemSanPhamHetHang
	@error nvarchar(MAX) output
as
begin
	begin try
		select SP.MaSP, SP.TenSP, SP_CN.SoLuongTon
		from  SanPham SP join SP_CN on SP.MaSP = SP_CN.MaSP
		where SP.TrangThaiHD = 1 and SP_CN.SoLuongTon < 10
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--Thêm khuyến mãi
go
create
--alter
proc usp_ThemKhuyenMai
	@MaSP int,
	@GiaTruocGiam INT,
	@GiaSauGiam INT,
	@NgayApDung datetime,
	@error nvarchar(MAX) output
as
begin 
	begin try
		if not exists (select * from SanPham where MaSP = @MaSP)
			RAISERROR ('Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		
		declare @GTGcu int, @GSGcu int
		select @GTGcu = GiaTruocGiam, @GSGcu = GiaSauGiam from SanPham	where MaSP = @MaSP
		if ((@GSGcu != @GiaSauGiam or @GTGcu != @GiaTruocGiam) and (@GiaTruocGiam<@GiaSauGiam))
			begin
				declare @SqlCommand nvarchar(max)
				set @SqlCommand = 'usp_LuuVetGiaSanPham ' + cast(@MaSP as char)
													+ ',' + cast(@GiaTruocGiam as char)
													+ ',' +	cast(@GiaSauGiam as char)
													+ ','+ '' + cast(@NgayApDung as char) + ''
				exec (@SqlCommand)
				
				update SanPham set GiaTruocGiam = @GiaTruocGiam, GiaSauGiam = @GiaSauGiam
				output inserted.*
				where MaSP = @MaSP and TrangThaiHD = 1
			end
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--Xem nhà cung cấp có cung cấp sản phẩm này
go
create 
--alter
proc usp_XemNCCSanPham
	@MaSP int,
	@error nvarchar(MAX) output
as
begin
	begin try
		select NCC.MaNCC, NCC.TenNCC, count(*) as SoLuongDonNhap
		from DonNhap DN join ChiTietDNhap CT on CT.MaDNhap = DN.MaDNhap
						join NhaCungCap NCC on DN.MaNCC = NCC.MaNCC
		where CT.MaSP = @MaSP 
		group by NCC.MaNCC, NCC.TenNCC
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--Thống kê doanh thu và số lượng theo tháng
go
create 
--alter
proc usp_XemThongKeDoanhThu
	@error nvarchar(MAX) output
as
begin
	begin try
		select MONTH(DH.NgayLap) AS Thang, YEAR(DH.NgayLap) AS Nam, 
				SUM(DH.TongTienDH) AS DoanhThu, SUM(CT.SoLuongSP) AS SoLuong
		from DonHang DH join ChiTietDH CT on DH.MaDH = CT.MaDH
		where DH.TrangThaiDH = 1 
		group by MONTH(DH.NgayLap), YEAR(DH.NgayLap)
		order by MONTH(DH.NgayLap) ASC, YEAR(DH.NgayLap) ASC
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end
---------------------------------------------
--Khách hàng
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
go


--21. Tìm sản phẩm theo thuộc tính: 3 thuộc tính
go 
create
--alter
proc usp_TimSanPhamTheoThuocTinh
	@MaMau tinyint,
	@MaLoaiHoa smallint,
	@MaCDe int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from Mau where MaMau = @MaMau)
			RAISERROR (N'Mã màu %d không tồn tại', 11, 1, @MaMau)
		if not exists (select * from LoaiHoa where MaLoaiHoa = @MaLoaiHoa)
			RAISERROR (N'Mã loại hoa %d không tồn tại', 11, 1, @MaLoaiHoa)
		if not exists (select * from ChuDe where MaCDe = @MaCDe)
			RAISERROR (N'Mã chủ đề %d không tồn tại', 11, 1, @MaCDe)

		if (@MaMau = null)
		begin
			if (@MaLoaiHoa = null)
				select * from SanPham SP join SP_CD on SP.MaSP = SP_CD.MaSP where SP_CD.MaCDe = @MaCDe
			else
				select * from SanPham SP join SP_CD on SP.MaSP = SP_CD.MaSP where SP_CD.MaCDe = @MaCDe and MaLoaiHoa = @MaLoaiHoa
		end
		else if (@MaLoaiHoa = null)
		begin
			if (@MaCDe = null)
				select * from SanPham where MaMau = @MaMau
			else
				select * from SanPham SP join SP_CD on SP.MaSP = SP_CD.MaSP where SP_CD.MaCDe = @MaCDe and MaMau = @MaMau
		end
		else if (@MaCDe = null)
		begin
			if (@MaMau = null)
				select * from SanPham where MaLoaiHoa = @MaLoaiHoa
			else
				select * from SanPham where MaLoaiHoa = @MaLoaiHoa and MaMau = @MaMau
		end
		else
			select * from SanPham SP join SP_CD on SP.MaSP = SP_CD.MaSP where SP_CD.MaCDe = @MaCDe and MaLoaiHoa = @MaLoaiHoa and MaMau = @MaMau
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--22. Xem chi tiết sản phẩm + khu vực có giao hàng sản phẩm đó
go
create 
--alter
proc usp_XemSPVaKV
	@MaSP int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from SanPham where MaSP = @MaSP)
			RAISERROR (N'Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		
		select SP.*, KV.MaKV, KV.TenTinh from SanPham SP join SP_CN on SP_CN.MaSP = SP.MaSP 
			join KhuVuc KV on SP_CN.MaCNhanh = KV.MaCNhanh where SP.MaSP = @MaSP and SP.TrangThaiHD = 1
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

go
--23. Thêm đơn hàng online
create 
--alter
proc usp_ThemDonHang 
	@SDT_NgNhan char(10),
	@HinhThucTT tinyint, 
	@TrangThaiDH tinyint,
	@MaKH int, 
	@MaQTang int, 
	@MaCNhanh int ,
	@MaKV int, 
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from KhachHang where MaKH = @MaKH)
			RAISERROR (N'Mã khách hàng %d không tồn tại', 11, 1, @MaKH)
		if not exists(select * from QuaTangKem where MaQTang = @MaQTang)
			RAISERROR (N'Mã quà tặng kèm %d không tồn tại', 11, 1, @MaQTang)
		if not exists(select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)
		if not exists(select * from KhuVuc where MaKV = @MaKV)
			RAISERROR (N'Mã khu vực %d không tồn tại', 11, 1, @MaKV)
		--kiểm tra có quà tặng kèm hay không
		declare @GiaQuaTang int
		if (@MaQTang != null) 
			select @GiaQuaTang=Gia from QuaTangKem where MaQTang = @MaQTang
		else
			set @GiaQuaTang = 0

		declare @PhiGiaoHang int, @TongTienDH int
		select @PhiGiaoHang = PhiGiaoHang from KhuVuc where MaKV = @MaKV
		set @TongTienDH = @PhiGiaoHang + @GiaQuaTang

		insert DonHang(SDT_NgNhan,NgayLap,HinhThucTT,TrangThaiDH,TongTienSP,PhiGiaoHang,TongTienDH,MaKH,MaQTang,MaCNhanh,MaKV)
		output inserted.*
		values(@SDT_NgNhan,GETDATE(),@HinhThucTT,@TrangThaiDH,0,@PhiGiaoHang,@TongTienDH,@MaKH,@MaQTang,@MaCNhanh,@MaKV)
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

go
----Thêm chi tiết đơn hàng
create 
--alter
proc usp_ThemCTDonHang 
	@MaDH int, 
	@MaSP int, 
	@SoLuongDat int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from DonHang where MaDH = @MaDH)
			RAISERROR (N'Mã đơn hàng %d không tồn tại', 11, 1, @MaDH)
		if not exists(select * from SanPham where MaSP = @MaSP)
			RAISERROR (N'Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		--kiểm tra số lượng tồn
		declare @SoLuongTon int, @MaCNhanh int
		select @SoLuongTon = SP_CN.SoLuongTon, @MaCNhanh=SP_CN.MaCNhanh from SP_CN join DonHang DH 
			on SP_CN.MaCNhanh = DH.MaCNhanh where SP_CN.MaSP = @MaSP
		if(@SoLuongDat<=0 or @SoLuongDat>@SoLuongTon) 
			RAISERROR (N'Không đủ hàng để đáp ứng số lượng đặt', 11, 1)
		--thêm CTDH
		declare @GiaBan int, @TenSP nvarchar(50), @ThanhTien int
		select @GiaBan=GiaSauGiam, @TenSP=TenSP from SanPham WHERE MaSP=@MaSP
		set @ThanhTien = @SoLuongDat * @GiaBan
		insert ChiTietDH
		output inserted.*
		values(@MaSP,@MaDH,@SoLuongDat,@GiaBan,@TenSP,@ThanhTien)

		--cập nhật lại đơn hàng
		declare @TongTienSP int, @TongTienDH int
		select @TongTienSP=TongTienSP, @TongTienDH=TongTienDH from DonHang where MaDH=@MaDH
		set @TongTienSP = @TongTienSP + @ThanhTien
		set @TongTienDH = @TongTienDH + @ThanhTien
		update DonHang set TongTienSP=@TongTienSP,TongTienDH=@TongTienDH 
		where MaDH=@MaDH
		--cập nhật lại số lượng tồn sản phẩm
		set @SoLuongTon = @SoLuongTon - @SoLuongDat
		update SP_CN set SoLuongTon=@SoLuongTon 
		where MaSP=@MaSP and MaCNhanh=@MaCNhanh
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

go
----Xóa chi tiết đơn hàng
create 
--alter
proc usp_XoaCTDonHang 
	@MaDH int, 
	@MaSP int, 
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from DonHang where MaDH = @MaDH)
			RAISERROR (N'Mã đơn hàng %d không tồn tại', 11, 1, @MaDH)
		if not exists(select * from ChiTietDH where MaDH = @MaDH and MaSP = @MaSP)
			RAISERROR (N'Mã sản phẩm %d không nằm trong đơn hàng', 11, 1, @MaSP)
		--xóa CTDH
		declare @SoLuongSP int, @ThanhTien int
		select @SoLuongSP = CT.SoLuongSP, @ThanhTien=CT.ThanhTien from ChiTietDH CT
			where CT.MaDH = @MaDH and CT.MaSP = @MaSP
		delete ChiTietDH 
		output deleted.*
		where MaDH = @MaDH and MaSP = @MaSP
		--cập nhật lại đơn hàng
		declare @TongTienSP int, @TongTienDH int
		select @TongTienSP=TongTienSP, @TongTienDH=TongTienDH from DonHang where MaDH=@MaDH
		set @TongTienSP = @TongTienSP - @ThanhTien
		set @TongTienDH = @TongTienDH - @ThanhTien
		update DonHang set TongTienSP=@TongTienSP,TongTienDH=@TongTienDH 
		output inserted.*
		where MaDH=@MaDH
		--cập nhật lại số lượng tồn sản phẩm
		declare @SoLuongTon int, @MaCNhanh int
		select @SoLuongTon = SP_CN.SoLuongTon, @MaCNhanh=SP_CN.MaCNhanh from SP_CN join DonHang DH 
			on SP_CN.MaCNhanh = DH.MaCNhanh where SP_CN.MaSP = @MaSP
		set @SoLuongTon = @SoLuongTon + @SoLuongSP
		update SP_CN set SoLuongTon=@SoLuongTon 
		output inserted.*
		where MaSP=@MaSP and MaCNhanh=@MaCNhanh
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--24. Xem đơn hàng + CTDH
go
create
--alter 
proc usp_XemChiTietDonHang
	@MaDH int,
	@error nvarchar(MAX) output
as
begin
	begin try
		select * from ChiTietDH
			where MaDH = @MaDH
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end


--25. Xem danh sách quà tặng kèm
go
create
--alter 
proc usp_XemDanhSachQTK
	@error nvarchar(MAX) output
as
begin
	begin try
		select * from QuaTangKem
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--27. Xem danh sách đơn đặt hàng của khách hàng
go
create
--alter 
proc usp_XemDanhSachDHKH
	@MaKH int,
	@error nvarchar(MAX) output
as
begin
	begin try
		select * from DonHang where MaKH = @MaKH
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--39. Hiển thị danh sách loại hoa
go
create
--alter 
proc usp_XemDSLoaiHoa
	@error nvarchar(MAX) output
as
begin
	begin try
		select * from LoaiHoa
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end
-----------------------------------------
--Nhân viên bán và giao hàng

--28. Xem danh sách đơn hàng mà chưa được giao
go
create 
--alter
proc usp_XemDonHangChuaGiao
	@MaNV int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		
		declare @MaCNhanh int
		select @MaCNhanh=NV.MaCNhanh from NhanVien NV 
			where NV.MaNV = @MaNV and NV.TrangThaiHD = 1
		select * from DonHang where MaCNhanh = @MaCNhanh and TrangThaiDH = 0
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--29. Chọn đơn hàng để giao
go
create 
--alter
proc usp_ChonDonHang
	@MaNV int,
	@MaDH int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		if not exists (select * from DonHang where MaDH = @MaDH)
			RAISERROR (N'Mã đơn hàng %d không tồn tại', 11, 1, @MaDH)
		
		update DonHang set TrangThaiDH = 2 
		output inserted.* 
		where MaDH = @MaDH
		insert GiaoHang 
		output inserted.* 
		values(@MaDH,@MaNV,GETDATE())
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--30. Thêm đơn hàng offline
go
create 
--alter
proc usp_ThemDonHangOffline
	@MaNV int,
	@SDT_NgNhan char(10),
	@HinhThucTT tinyint, 
	@TrangThaiDH tinyint,
	@MaKH int, 
	@MaQTang int, 
	@MaKV int, 
	@MaDH int output,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists(select * from NhanVien where MaNV = @MaNV)
			RAISERROR ('Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		if not exists(select * from KhachHang where MaKH = @MaKH)
			RAISERROR ('Mã khách hàng %d không tồn tại', 11, 1, @MaKH)
		if not exists(select * from QuaTangKem where MaQTang = @MaQTang)
			RAISERROR ('Mã quà tặng kèm %d không tồn tại', 11, 1, @MaQTang)
		if not exists(select * from KhuVuc where MaKV = @MaKV)
			RAISERROR ('Mã khu vực %d không tồn tại', 11, 1, @MaKV)

		--kiểm tra có quà tặng kèm hay không
		declare @GiaQuaTang int
		if (@MaQTang != null) 
			select @GiaQuaTang=Gia from QuaTangKem where MaQTang = @MaQTang
		else
			set @GiaQuaTang = 0
	    
		set @MaDH = 1
		declare @PhiGiaoHang int, @TongTienDH int, @MaCNhanh int
		select @MaCNhanh=NV.MaCNhanh from NhanVien NV 
			where NV.MaNV = @MaNV and NV.TrangThaiHD = 1
		select @PhiGiaoHang = PhiGiaoHang from KhuVuc where MaKV = @MaKV
		set @TongTienDH = @PhiGiaoHang + @GiaQuaTang
		
		insert DonHang(SDT_NgNhan,NgayLap,HinhThucTT,TrangThaiDH,TongTienSP,PhiGiaoHang,TongTienDH,MaKH,MaQTang,MaCNhanh,MaKV)
		output inserted.*
		values(@SDT_NgNhan,GETDATE(),@HinhThucTT,@TrangThaiDH,0,@PhiGiaoHang,@TongTienDH,@MaKH,@MaQTang,@MaCNhanh,@MaKV)
		set @MaDH = @@IDENTITY
		insert BanHang values (@MaDH,@MaKV)
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--31. Xem lịch sử thưởng + lương
go
create 
--alter
proc usp_XemLuongLST
	@MaNV int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		
		select LST.*, NV.LuongHienTai from NhanVien NV join LichSuThuong LST on NV.MaNV = LST.MaNV
			where NV.MaNV = @MaNV
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--32. Xem danh sách nhân viên theo chi nhánh (có hiện công việc hiện tại)
go
create 
--alter
proc usp_XemDSNhanVien
	@MaCNhanh int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)
		
		select NV.* from NhanVien NV join ChiNhanh CN on NV.MaCNhanh = CN.MaCNhanh
			where NV.MaCNhanh = @MaCNhanh and NV.TrangThaiHD = 1
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--33. Xem thông tin nhân viên có hiện lịch sử lương và lịch sử thưởng
go
create 
--alter
proc usp_XemThongTinNV
	@MaNV int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		
		declare @SoLuongDH int
		set @SoLuongDH = 0
		if exists(select * from GiaoHang where MaNV = @MaNV)
			select @SoLuongDH = COUNT(*) from GiaoHang where MaNV = @MaNV
		else if exists(select * from BanHang where MaNV = @MaNV)
			select @SoLuongDH = COUNT(*) from BanHang where MaNV = @MaNV
		select NV.*,LSL.Luong,LSL.NgayBD,LST.TienThuong,LST.NgayThuong,LST.LyDo,@SoLuongDH as SLDH
		from NhanVien NV join LichSuLuong LSL on NV.MaNV = LSL.MaNV
						join LichSuTHuong LST on NV.MaNV = LST.MaNV	where NV.MaNV = @MaNV 
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--34. Thay đổi tình trạng đơn hàng
go
create 
--alter
proc usp_ThayDoiTrangThaiDH
	@MaDH int,
	@TrangThaiDH tinyint,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from DonHang where MaDH = @MaDH)
			RAISERROR (N'Mã đơn hàng %d không tồn tại', 11, 1, @MaDH)
		
		update DonHang set TrangThaiDH = @TrangThaiDH 
		output inserted.* 
		where MaDH = @MaDH
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

go
-----------------------
--Quản trị viên

go
-- 40. Thêm sản phẩm
create 
--alter
proc usp_ThemSanPham
	@TenSP NVARCHAR(50),
	@MaMau TINYINT,
	@MaLoaiHoa SMAllINT,
	@MoTa NVARCHAR(1500),
	@GiaTruocGiam INT,
	@GiaSauGiam INT,
	@LinkHinhAnh varchar(500),
	@error nvarchar(MAX) output
as	
	declare @TenLoaiHoa NVARCHAR(30)
begin
	set @TenLoaiHoa = (select TenLoaiHoa from LoaiHoa where MaLoaiHoa = @MaLoaiHoa)
	begin try
		insert into SanPham (TenSP, MaMau, MaLoaiHoa, TenLoaiHoa, MoTa, TrangThaiHD, GiaTruocGiam, GiaSauGiam, LinkHinhAnh) 
		output inserted.* 
		values (@TenSP, @MaMau, @MaLoaiHoa, @TenLoaiHoa, @MoTa, 1, @GiaTruocGiam, @GiaSauGiam, @LinkHinhAnh)

	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--40.2 Xoá sản phẩm
go 
create
--alter 
proc usp_XoaSanPham
	@MaSP int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from SanPham where MaSP = @MaSP)
		begin
			RAISERROR ('Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		end

		update SanPham set TrangThaiHD = 0 
		output inserted.* 
		where MaSP = @MaSP
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--41. Tìm sản phẩm
go
create
--alter
proc usp_TimMotSanPham
	@MaSP int,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from SanPham where MaSP = @MaSP)
		begin
			RAISERROR ('Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		end

		select * from SanPham where MaSP = @MaSP
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--40.3 Cập nhật sản phẩm
go
create
--alter
proc usp_CapNhatSanPham
	@MaSP int,
	@TenSP NVARCHAR(50),
	@MaMau TINYINT,
	@MaLoaiHoa SMAllINT,
	@TenLoaiHoa NVARCHAR(30),
	@MoTa NVARCHAR(1500),
	@GiaTruocGiam INT,
	@GiaSauGiam INT,
	@LinkHinhAnh varchar(500),
	@error nvarchar(MAX) output
as
begin 
	begin try
		if not exists (select * from SanPham where MaSP = @MaSP)
		begin 
			RAISERROR ('Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		end
		update SanPham set TenSP = @TenSP, 
							MaMau = @MaMau, 
							MaLoaiHoa = @MaLoaiHoa,
							TenLoaiHoa = @TenLoaiHoa,
							MoTa = @MoTa,
							GiaTruocGiam = @GiaTruocGiam,
							GiaSauGiam = @GiaSauGiam,
							LinkHinhAnh = @LinkHinhAnh
						output inserted.*
						where MaSP = @MaSP
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--42. Xem số lượng tồn
go
create
--alter 
proc usp_TheoDoiTonKho 
	@error nvarchar(MAX) output
as
begin
	begin try
		select sp.MaSP, sp.TenSP, cn.MaCNhanh, cn.TenCNhanh, spcn.SoLuongTon
		from SP_CN spcn, SanPham sp, ChiNhanh cn 
		where spcn.MaSP = sp.MaSP and cn.MaCNhanh = spcn.MaCNhanh
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--43. Xem đơn nhập
go
create
--alter 
proc usp_TheoDoiDonNhap
	@error nvarchar(MAX) output
as
begin
	begin try
		select * from DonNhap
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--44. Thêm lịch sử giá sản phẩm
go
create
--alter
proc usp_LuuVetGiaSanPham
	@MaSP int,
	@GiaTruocGiam int,
	@GiaSauGiam int,
	@NgayApDung datetime,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from SanPham where MaSP = @MaSP)
		begin 
			RAISERROR ('Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		end
		insert into LichSuGia (MaSP, GiaTruocGiam, GiaSauGiam, NgayApDung) 
		output inserted.*
		values (@MaSP, @GiaTruocGiam, @GiaSauGiam, @NgayApDung)

	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end
go

--35. Thêm chi nhánh
go
create 
--alter
proc usp_ThemChiNhanh
	@TenCNhanh NVARCHAR(50),
	@DiaChiCNhanh NVARCHAR(255),
	@SDT_CNhanh CHAR(15),
	@PasswordBH VARCHAR(20),
	@TrangThaiHD BIT,
	@MaTinh TINYINT,
	@TenTinh NVARCHAR(30),
	@error nvarchar(MAX) output
as
begin
	begin try
		insert ChiNhanh(TenCNhanh, DiaChiCNhanh, SDT_CNhanh, PasswordBH, TrangThaiHD, MaTinh, TenTinh) 
		output inserted.* 
		values (@TenCNhanh, @DiaChiCNhanh, @SDT_CNhanh, @PasswordBH, @TrangThaiHD, @MaTinh, @TenTinh)

	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end
go
--36. Sửa chi nhánh
go
create
--alter
proc usp_SuaChiNhanh
	@MaCNhanh INT,
	@TenCNhanh NVARCHAR(50),
	@DiaChiCNhanh NVARCHAR(255),
	@SDT_CNhanh CHAR(15),
	@PasswordBH VARCHAR(20),
	@TrangThaiHD BIT,
	@MaTinh TINYINT,
	@TenTinh NVARCHAR(30),
	@error nvarchar(MAX) output
as
begin 
	begin try
		if not exists (select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)
		
		update ChiNhanh set TenCNhanh = @TenCNhanh, 
							DiaChiCNhanh = @DiaChiCNhanh, 
							SDT_CNhanh = @SDT_CNhanh,
							PasswordBH = @PasswordBH,
							TrangThaiHD = @TrangThaiHD,
							MaTinh = @MaTinh,
							TenTinh = @TenTinh
						output inserted.*
						where MaCNhanh = @MaCNhanh
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end
go
--37. Xóa chi nhánh
go 
create
--alter 
proc usp_XoaChiNhanh
	@MaCNhanh INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)

		update ChiNhanh set TrangThaiHD = 0
		output inserted.* 
		where MaCNhanh = @MaCNhanh
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end
go
--35.2 Thêm khu vực
go
create 
--alter
proc usp_ThemKhuVuc
	@MaCNhanh INT,
	@Ten_QHuyen NVARCHAR(30),
	@PhiGiaoHang INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)
		if (@PhiGiaoHang < 0)
			RAISERROR (N'Phí giao hàng không được < 0', 11, 1)
		
		declare @MaTinh TINYINT, @TenTinh NVARCHAR(30)
		select @MaTinh=MaTinh, @TenTinh=TenTinh from ChiNhanh 
			where MaCNhanh = @MaCNhanh and TrangThaiHD = 1
		insert KhuVuc(MaTinh, TenTinh, Ten_QHuyen, PhiGiaoHang, MaCNhanh) 
		output inserted.* 
		values (@MaTinh, @TenTinh, @Ten_QHuyen, @PhiGiaoHang, @MaCNhanh)
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--36.2 Sửa khu vực
go
create
--alter
proc usp_SuaKhuVuc
	@MaKV INT,
	@MaCNhanh INT,
	@Ten_QHuyen NVARCHAR(30),
	@PhiGiaoHang INT,
	@error nvarchar(MAX) output
as
begin 
	begin try
		if not exists (select * from KhuVuc where MaKV = @MaKV)
			RAISERROR (N'Mã khu vực %d không tồn tại', 11, 1, @MaKV)
		if not exists (select * from ChiNhanh where MaCNhanh = @MaCNhanh)
			RAISERROR (N'Mã chi nhánh %d không tồn tại', 11, 1, @MaCNhanh)
		if (@PhiGiaoHang < 0)
			RAISERROR (N'Phí giao hàng không được < 0', 11, 1)
		
		declare @MaTinh TINYINT, @TenTinh NVARCHAR(30)
		select @MaTinh=MaTinh, @TenTinh=TenTinh from ChiNhanh 
			where MaCNhanh = @MaCNhanh and TrangThaiHD = 1
		update KhuVuc set	MaTinh = @MaTinh,
							TenTinh = @TenTinh,
							Ten_QHuyen = @Ten_QHuyen, 
							PhiGiaoHang = @PhiGiaoHang,
							MaCNhanh = @MaCNhanh
						output inserted.*
						where MaKV = @MaKV
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--35.3 Thêm nhân viên quản lí
go
create 
--alter
proc usp_ThemNVQL
	@MaNV INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NhanVien where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên %d không tồn tại', 11, 1, @MaNV)
		
		declare @MaCNhanh INT, @MatKhauQL VARCHAR(20)
		select @MaCNhanh = NV.MaCNhanh, @MatKhauQL = PasswordBH 
			from NhanVien NV join ChiNhanh CN on NV.MaCNhanh = CN.MaCNhanh
			where NV.MaNV = @MaNV and NV.TrangThaiHD = 1
		insert NVQuanLy	output inserted.* 
		values (@MaNV, @MatKhauQL)
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--36.3 Sửa nhân viên quản lí
go
create 
--alter
proc usp_SuaNVQL
	@MaNV INT,
	@MaNVmoi INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NVQuanLy where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên quản lí %d không tồn tại', 11, 1, @MaNV)
		if not exists (select * from NhanVien where MaNV = @MaNVmoi)
			RAISERROR (N'Mã nhân viên mới %d không tồn tại', 11, 1, @MaNVmoi)
		
		declare @MaCNhanh INT, @MatKhauQL VARCHAR(20)
		select @MaCNhanh = NV.MaCNhanh, @MatKhauQL = PasswordBH 
			from NhanVien NV join ChiNhanh CN on NV.MaCNhanh = CN.MaCNhanh
			where NV.MaNV = @MaNV and NV.TrangThaiHD = 1
		update NVQuanLy	set MaNV = @MaNVmoi, MatKhauQL = @MatKhauQL
						output inserted.* 
						where MaNV = @MaNV
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end

--37.2 Xóa nhân viên quản lí
go 
create
--alter 
proc usp_XoaNVQL
	@MaNV INT,
	@error nvarchar(MAX) output
as
begin
	begin try
		if not exists (select * from NVQuanLy where MaNV = @MaNV)
			RAISERROR (N'Mã nhân viên quản lí %d không tồn tại', 11, 1, @MaNV)

		update NhanVien set TrangThaiHD = 0 output inserted.* where MaNV = @MaNV
		--delete NVQuanLy output deleted.* where MaNV = @MaNV
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch 
end

--38. Xem danh sách chi nhánh hiện có + nhân viên quản lý
go
create 
--alter
proc usp_XemDSChiNhanh
	@error nvarchar(MAX) output
as
begin
	begin try
		select CN.*, NV.MaNV, NV.HoTenNV from NhanVien NV join ChiNhanh CN on NV.MaCNhanh = CN.MaCNhanh
										join NVQuanLy QL on NV.MaNV = QL.MaNV where CN.TrangThaiHD = 1
	end try
	begin catch
		set @error = ERROR_MESSAGE()
	end catch
end
