go
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