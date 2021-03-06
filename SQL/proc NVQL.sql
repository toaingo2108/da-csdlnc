use QLDH
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
