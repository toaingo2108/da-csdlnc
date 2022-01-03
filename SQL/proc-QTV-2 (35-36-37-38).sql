use QLDH
--Thêm chi nhánh
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
--Sửa chi nhánh
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
--Xóa chi nhánh
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
--Thêm khu vực
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

--Sửa khu vực
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

--Thêm nhân viên quản lí
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

--Sửa nhân viên quản lí
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

--Xóa nhân viên quản lí
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

--Xem danh sách chi nhánh hiện có + nhân viên quản lý
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