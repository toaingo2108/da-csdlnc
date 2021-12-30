go
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
	@GiaSauGiam int
as
begin
	insert into SanPham (TenSP, ChuDe, MauSac, LoaiHoa, MoTa, TrangThaiHD, GiaTruocGiam, GiaSauGiam) 
	values (@TenSP, @ChuDe, @MauSac, @LoaiHoa, @MoTa, @TrangThaiHD, @GiaTruocGiam, @GiaSauGiam)
end

go 
create
--alter 
proc usp_XoaSanPham
	@MaSP int
as
begin
	if not exists (select * from SanPham where MaSP = @MaSP)
	begin
		print N'Mã sản phẩm không tồn tại'
		return 1
	end
	delete SanPham where MaSP = @MaSP
end

go
create
--alter
proc usp_TimMotSanPham
	@MaSP int
as
begin
	select * from SanPham where MaSP = @MaSP
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
	@GiaSauGiam int
as
begin 
	if not exists (select * from SanPham where MaSP = @MaSP)
	begin 
		print N'Mã sản phẩm không tồn tại'
		return 1
	end
	update SanPham set TenSP = @TenSP, 
						ChuDe = @ChuDe, 
						MauSac = @MauSac,
						LoaiHoa = @LoaiHoa,
						MoTa = @MoTa,
						TrangThaiHD = @TrangThaiHD,
						GiaTruocGiam = @GiaTruocGiam,
						GiaSauGiam = @GiaSauGiam
					where MaSP = @MaSP
end

go
create
--alter 
proc usp_TheoDoiTonKho 
as
begin
	select sp.MaSP, sp.TenSP, cn.MaCNhanh, cn.TenCNhanh, spcn.SoLuongTon
	from SP_CN spcn, SanPham sp, ChiNhanh cn 
	where spcn.MaSP = sp.MaSP and cn.MaCNhanh = spcn.MaCNhanh
end

go
create
--alter 
proc usp_TheoDoiDonNhap
as
begin
	select * from DonNhap
end

go
create
--alter
proc usp_LuuVetGiaSanPham
	@MaSP int,
	@GiaTruocGiam int,
	@GiaSauGiam int,
	@NgayApDung datetime
as
begin
	if not exists (select * from SanPham where MaSP = @MaSP)
	begin 
		print N'Mã sản phẩm không tồn tại'
		return 1
	end
	insert into LichSuGia (MaSP, GiaTruocGiam, GiaSauGiam, NgayApDung) 
	values (@MaSP, @GiaTruocGiam, @GiaSauGiam, @NgayApDung)
end