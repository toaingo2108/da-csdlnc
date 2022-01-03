use QLDH
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
