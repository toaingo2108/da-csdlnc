use QLDH

--Xem danh sách đơn hàng mà chưa được giao
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

--Chọn đơn hàng để giao
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

--Thêm đơn hàng offline
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

--Xem lịch sử thưởng + lương
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

--Xem danh sách nhân viên theo chi nhánh (có hiện công việc hiện tại)
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

--Xem thông tin nhân viên có hiện lịch sử lương và lịch sử thưởng
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

--Thay đổi tình trạng đơn hàng
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