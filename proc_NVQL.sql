use QLDH

go
--Tao don nhap
create --alter
proc TaoDonNhap @ngaynhanhang date, @mancc int, @macnhanh int, @madn int output
as
begin
	if not exists(select * from NhaCungCap where MaNCC = @mancc)
	begin
		print 'Khong ton tai nha cung cap nay!'
		return 0
	end
	if not exists(select * from ChiNhanh where MaCNhanh = @macnhanh)
	begin
		print 'Khong ton tai chi nhanh nay!'
		return 0
	end
    --them don nhap
    set @madn = 1
    insert DonNhap(TongTienNhap,NgayNhanHang,MaNCC,MaCNhanh) 
		values(0,@ngaynhanhang,@mancc,@macnhanh)
	print 'Them don nhap thanh cong!'
	set @madn = @@IDENTITY
	return 1
end

go
--Tao chi tiet don nhap
create --alter
proc TaoChiTietDonNhap @madn int, @masp int, @soluongnhap int, @gianhap int
as
begin
	if not exists(select * from SanPham where MaSP = @masp)
	begin
		print 'Khong ton tai san pham nay!'
		return 0
	end
	if not exists(select * from DonNhap where MaDNhap = @madn)
	begin
		print 'Khong ton tai don nhap nay!'
		return 0
	end
	--them chi tiet don nhap
	declare @thanhtien int
	set @thanhtien = @soluongnhap * @gianhap
	insert ChiTietDNhap values(@madn,@masp,@soluongnhap,@gianhap,@thanhtien)
	print 'Them chi tiet don nhap thanh cong!'
	--cap nhat lai don nhap
	declare @tongtiennhap int
	select @tongtiennhap = TongTienNhap from DonNhap where MaDNhap=@madn
	set @tongtiennhap = @tongtiennhap + @thanhtien
	update DonNhap set TongTienNhap=@tongtiennhap where MaDNhap=@madn
	--cap nhat so luong ton
	declare @soluongton int, @macnhanh int
	select @soluongton=SPCN.SoLuongTon, @macnhanh=SPCN.MaCNhanh from SP_CN SPCN, DonNhap DN
		where SPCN.MaCNhanh=DN.MaCNhanh and SPCN.MaSP=@masp
	set @soluongton = @soluongton - @soluongnhap
	update SP_CN set SoLuongTon=@soluongton where MaSP=@masp and MaCNhanh=@macnhanh
end

go
--Them lich su thuong nhan vien
create --alter
proc ThemLichSuThuong @manv int, @tienthuong int, @lydo nvarchar(100)
as
begin
	if not exists(select * from NhanVien where MaNV = @manv)
	begin
		print 'Khong ton tai nhan vien nay!'
		return 0
	end
	if (@tienthuong < 0)
	begin
		print 'Tien thuong phai la mot so nguyen duong!'
		return 0
	end
	--them lich su thuong
	insert LichSuThuong(TienThuong,NgayThuong,MaNV,LyDo) values(@tienthuong,GETDATE(),@manv,@lydo)
	print 'Them lich su thuong thanh cong!'
end

go
--Them lich su luong nhan vien
create --alter
proc ThemLichSuLuong @manv int, @luong int
as
begin
	if not exists(select * from NhanVien where MaNV = @manv)
	begin
		print 'Khong ton tai nhan vien nay!'
		return 0
	end
	if (@luong <= 0)
	begin
		print 'Luong phai la mot so nguyen duong!'
		return 0
	end
	--them lich su luong + cap nhat luong
	insert LichSuLuong(MaNV,NgayBD,Luong) values(@manv,GETDATE(),@luong)
	print 'Them lich su luong thanh cong!'
	update NhanVien set LuongHienTai=@luong where MaNV=@manv
	print 'Cap nhat luong nhan vien thanh cong!'
end

go
--Them san pham
create --alter
proc ThemSanPham @tensp nvarchar(50), @chude tinyint, @mausac tinyint, @loaihoa smallint,
				@mota nvarchar(max), @trangthaihd bit, @giatruocgiam int, @giasaugiam int
as
begin
	if exists(select * from SanPham where TenSP like @tensp)
	begin
		print 'San pham da co san. Khong the them duoc!'
		return 0
	end
	--them lich su luong + cap nhat luong
	insert SanPham(TenSP,ChuDe,MauSac,LoaiHoa,MoTa,TrangThaiHD,GiaTruocGiam,GiaSauGiam) 
		values(@tensp,@chude,@mausac,@loaihoa,@mota,@trangthaihd,@giatruocgiam,@giasaugiam)
	print 'Them san pham thanh cong!'
end

go
--Sua san pham
create --alter
proc SuaSanPham @masp int, @tensp nvarchar(50), @chude tinyint, @mausac tinyint, @loaihoa smallint,
				@mota nvarchar(max), @trangthaihd bit, @giatruocgiam int, @giasaugiam int
as
begin
	if not exists(select * from SanPham where MaSP = @masp)
	begin
		print 'Khong ton tai san pham nay!'
		return 0
	end
	if exists(select * from SanPham where TenSP like @tensp)
	begin
		print 'San pham da co san. Khong the sua duoc!'
		return 0
	end
	--sua thong tin san pham 
	update SanPham set TenSP = @tensp where MaSP = @masp
	update SanPham set ChuDe = @chude where MaSP = @masp
	update SanPham set MauSac = @mausac where MaSP = @masp
	update SanPham set LoaiHoa = @loaihoa where MaSP = @masp
	update SanPham set MoTa = @mota where MaSP = @masp
	update SanPham set TrangThaiHD = @trangthaihd where MaSP = @masp
	--them lich su gia
	declare @giacu int, @giamoi int
	select @giacu = GiaTruocGiam, @giamoi = GiaSauGiam from SanPham	where MaSP = @masp
	if (@giacu != @giatruocgiam or @giamoi != @giasaugiam)
		insert LichSuGia(MaSP,GiaTruocGiam,GiaSauGiam,NgayApDung)
		values (@masp,@giacu,@giamoi,GETDATE())
	update SanPham set GiaTruocGiam = @giatruocgiam where MaSP = @masp
	update SanPham set GiaSauGiam = @giasaugiam where MaSP = @masp
	print 'Sua san pham thanh cong!'
end

go
--Xoa san pham
create --alter
proc XoaSanPham @masp int
as
begin
	if not exists(select * from SanPham where MaSP = @masp)
	begin
		print 'Khong ton tai san pham nay!'
		return 0
	end
	--sua trang thai hoat dong
	update SanPham set TrangThaiHD = 0 where MaSP = @masp
	print 'Xoa san pham thanh cong!'
end

go
--Tao don hang
create --alter
proc TaoDonHang 
@sdt_ngnhan char(10), @hinhthuctt tinyint, @trangthaidh tinyint, 
@phigiaohang int, @makh int, @maqtang int, @macnhanh int ,@makv int, @madh int output
as
begin
	if not exists(select * from KhachHang where MaKH = @makh)
	begin
		print 'Khong ton tai khach hang nay!'
		return 0
	end
	if not exists(select * from QuaTangKem where MaQTang = @maqtang)
	begin
		print 'Khong ton tai qua tang nay!'
		return 0
	end
	if not exists(select * from ChiNhanh where MaCNhanh = @macnhanh)
	begin
		print 'Khong ton tai chi nhanh nay!'
		return 0
	end
    --them don hang
    declare @giaquatang int
    if (@maqtang != null)
		select @giaquatang=Gia from QuaTangKem where MaQTang = @maqtang
	else
		set @giaquatang = 0
    set @madh = 1
	insert DONHANG(SDT_NgNhan,NgayLap,HinhThucTT,TrangThaiDH,TongTienSP,PhiGiaoHang,TongTienDH,MaKH,MaQTang,MaCNhanh,MaKV) 
		values(@sdt_ngnhan,GETDATE(),@hinhthuctt,@trangthaidh,@giaquatang,@phigiaohang,0,@makh,@maqtang,@macnhanh,@makv)
	set @madh = @@IDENTITY
	return 1
end

go
--Tao chi tiet don hang
create --alter
proc TaoChiTietDonHang @madh int, @masp int, @soluongdat int
as
begin
	if not exists(select * from SanPham where MaSP = @masp)
	begin
		print 'Khong ton tai san pham nay!'
		return 0
	end
	if not exists(select * from DonHang where MaDH = @madh)
	begin
		print 'Khong ton tai don hang nay!'
		return 0
	end
	declare @soluongton int, @macnhanh int
	select @soluongton = SPCN.SoLuongTon, @macnhanh=SPCN.MaCNhanh from SP_CN SPCN, DonHang DH 
		where SPCN.MaCNhanh = DH.MaCNhanh and SPCN.MaSP = @masp
	if(@soluongdat<=0 or @soluongdat>@soluongton) 
	begin
		print 'So luong khong du de dat hang!'
		return 0
	end
	--them chi tiet don hang
	declare @giaban int, @tensp nvarchar(50), @thanhtien int
	select @giaban=GiaSauGiam, @tensp=TenSP from SanPham WHERE MaSP=@masp
	set @thanhtien = @soluongdat * @giaban
	insert ChiTietDH values(@masp,@madh,@soluongdat,@giaban,@tensp,@thanhtien)
	print 'Them chi tiet don hang thanh cong!'
	--cap nhat lai don hang
	declare @tongtiensp int, @phigh int, @tongtiendh int
	select @tongtiensp=TongTienSP, @phigh=PhiGiaoHang from DonHang where MaDH=@madh
	set @tongtiensp = @tongtiensp + @thanhtien
	set @tongtiendh = @tongtiensp + @phigh
	update DonHang set TongTienSP=@tongtiensp,TongTienDH=@tongtiendh where MaDH=@madh
	--cap nhat lai so luong ton san pham
	set @soluongton = @soluongton - @soluongdat
	update SP_CN set SoLuongTon=@soluongton where MaSP=@masp and MaCNhanh=@macnhanh
end
