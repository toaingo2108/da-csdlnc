﻿go
create 
--alter
proc usp_ThemSanPham
	@TenSP nvarchar(50),
	@ChuDe tinyint,
	@MauSac tinyint,
	@LoaiHoa smallint,
	@MoTa nvarchar(max),
	@TrangThaiHD bit,
	@GiaTruocGiam int,
	@GiaSauGiam int,
	@error nvarchar(MAX) output
as
begin
	begin try
		insert into SanPham (TenSP, ChuDe, MauSac, LoaiHoa, MoTa, TrangThaiHD, GiaTruocGiam, GiaSauGiam) 
		output inserted.* 
		values (@TenSP, @ChuDe, @MauSac, @LoaiHoa, @MoTa, @TrangThaiHD, @GiaTruocGiam, @GiaSauGiam)

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

		delete SanPham 
		output deleted.* 
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
	@TenSP nvarchar(50),
	@ChuDe tinyint,
	@MauSac tinyint,
	@LoaiHoa smallint,
	@MoTa nvarchar(max),
	@TrangThaiHD bit,
	@GiaTruocGiam int,
	@GiaSauGiam int,
	@error nvarchar(MAX) output
as
begin 
	begin try
		if not exists (select * from SanPham where MaSP = @MaSP)
		begin 
			RAISERROR ('Mã sản phẩm %d không tồn tại', 11, 1, @MaSP)
		end
		update SanPham set TenSP = @TenSP, 
							ChuDe = @ChuDe, 
							MauSac = @MauSac,
							LoaiHoa = @LoaiHoa,
							MoTa = @MoTa,
							TrangThaiHD = @TrangThaiHD,
							GiaTruocGiam = @GiaTruocGiam,
							GiaSauGiam = @GiaSauGiam
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