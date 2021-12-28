USE master
GO
IF DB_ID('QLDH') IS NOT NULL
	DROP DATABASE QLDH
GO
CREATE DATABASE QLDH
GO
USE QLDH
GO

--TẠO BẢNG VÀ RÀNG BUỘC KHÓA CHÍNH
CREATE TABLE CongViec
(
	MaCViec int not null IDENTITY,
	TenCViec nvarchar(50)
	CONSTRAINT PK_CongViec
	PRIMARY KEY(MaCViec)
)
CREATE TABLE LichSuThuong
(
	MaLSThuong int not null IDENTITY,
	TienThuong int,
	NgayThuong date,
	MaNV int,
	LyDo nvarchar(100)
	CONSTRAINT PK_LichSuThuong
	PRIMARY KEY(MaLSThuong)
)
CREATE TABLE NV_TTinKhac
(
	MaNV int not null IDENTITY,
	CMND_NV char(12),
	SDT_NV char(10),
	NgaySinhNV date,
	DiaChiNV nvarchar(100)
	CONSTRAINT PK_NV_TTinKhac
	PRIMARY KEY(MaNV)
)
CREATE TABLE LichSuLuong
(
	MaLSLuong int not null IDENTITY,
	MaNV int,
	NgayBD date,
	Luong int
	CONSTRAINT PK_LichSuLuong
	PRIMARY KEY(MaLSLuong)
)
CREATE TABLE YeuCauHoTro
(
	MaYC int not null IDENTITY,
	MaKH int,
	Noidung nvarchar(max),
	TrangThaiYCau tinyint
	CONSTRAINT PK_YeuCauHoTro
	PRIMARY KEY(MaYC)
)
CREATE TABLE NVQuanLy
(
	MaNV int not null IDENTITY,
	MatKhauQL varchar(20)
	CONSTRAINT PK_NVQuanLy
	PRIMARY KEY(MaNV)
)
CREATE TABLE NhanVien
(
	MaNV int not null IDENTITY,
	HoTenNV nvarchar(50),
	LuongHienTai int,
	TrangThaiHD bit,
	TenCViec nvarchar(50),
	MaCViec int,
	MaCNhanh int
	CONSTRAINT PK_NhanVien
	PRIMARY KEY(MaNV)
)
CREATE TABLE GiaoHang
(
	MaDH int not null IDENTITY,
	MaNV int,
	NgayGiao datetime
	CONSTRAINT PK_GiaoHang
	PRIMARY KEY(MaDH)
)
CREATE TABLE BanHang
(
	MaDH int not null IDENTITY,
	MaNV int,
	CONSTRAINT PK_BanHang
	PRIMARY KEY(MaDH)
)
CREATE TABLE KhachHang
(
	MaKH int not null IDENTITY,
	HoKH nvarchar(30),
	TenKH nvarchar(30),
	SDT_KH varchar(15),
	EmailKH varchar(30),
	MatKhauKH varchar(20),
	DiaChiKH nvarchar(100)
	CONSTRAINT PK_KhachHang
	PRIMARY KEY(MaKH)
)
CREATE TABLE ChiNhanh
(
	MaCNhanh int not null IDENTITY,
	TenCNhanh nvarchar(50),
	DiaChiCNhanh nvarchar(100),
	SDT_CNhanh char(15),
	PasswordBH varchar(20),
	TrangThaiHD bit,
	MaTinh tinyint
	CONSTRAINT PK_ChiNhanh
	PRIMARY KEY(MaCNhanh)
)
CREATE TABLE KhuVuc
(
	MaKV int not null IDENTITY,
	MaTinh tinyint,
	Quan_Huyen nvarchar(30),
	PhiGiaoHang int,
	MaCNhanh int
	CONSTRAINT PK_KhuVuc
	PRIMARY KEY(MaKV)
)
CREATE TABLE DonHang
(
	MaDH int not null IDENTITY,
	SDT_NgNhan char(10),
	NgayLap datetime,
	HinhThucTT tinyint,
	TrangThaiDH tinyint,
	TongTienSP int,
	PhiGiaoHang int,
	TongTienDH int,
	MaKH int,
	MaQTang int,
	MaCNhanh int,
	MaKV int
	CONSTRAINT PK_DonHang
	PRIMARY KEY(MaDH)
)
CREATE TABLE DH_TTinKhac
(
	MaDH int not null IDENTITY,
	Email_NgGui varchar(30),
	DiaChi_NgGui nvarchar(100),
	SDT_NgGui char(10),
	CONSTRAINT PK_DH_TTinKhac
	PRIMARY KEY(MaDH)
)
CREATE TABLE DonNhap
(
	MaDNhap int not null IDENTITY,
	TongTienNhap int,
	NgayNhanHang date,
	MaNCC int,
	MaCNhanh int
	CONSTRAINT PK_DonNhap
	PRIMARY KEY(MaDNhap)
)
CREATE TABLE SP_CN
(
	MaSP int not null,
	MaCNhanh int not null,
	SoLuongTon int,
	CONSTRAINT PK_SP_CN
	PRIMARY KEY(MaSP,MaCNhanh)
)
CREATE TABLE ChiTietDH
(
	MaSP int not null,
	MaDH int not null,
	SoLuongSP int,
	GiaBan int,
	TenSP nvarchar(50),
	ThanhTien int
	CONSTRAINT PK_ChiTietDH
	PRIMARY KEY(MaSP,MaDH)
)
CREATE TABLE QuaTangKem
(
	MaQTang int not null IDENTITY,
	TenQT nvarchar(50),
	Gia int
	CONSTRAINT PK_QuaTangKem
	PRIMARY KEY(MaQTang)
)
CREATE TABLE NhaCungCap
(
	MaNCC int not null IDENTITY,
	TenNCC nvarchar(50),
	DiaChiNCC nvarchar(100),
	SDT_NCC varchar(15),
	EmailNCC varchar(30)
	CONSTRAINT PK_NhaCungCap
	PRIMARY KEY(MaNCC)
)
CREATE TABLE ChiTietDNhap
(
	MaDNhap int not null,
	MaSP int not null,
	SoLuong int,
	GiaNhap int,
	ThanhTienNH int
	CONSTRAINT PK_ChiTietDNhap
	PRIMARY KEY(MaDNhap,MaSP)
)
CREATE TABLE SanPham
(
	MaSP int not null IDENTITY(1,1),
	TenSP nvarchar(50),
	ChuDe tinyint,
	MauSac tinyint,
	LoaiHoa smallint,
	MoTa nvarchar(max),
	TrangThaiHD bit,
	GiaTruocGiam int,
	GiaSauGiam int
	CONSTRAINT PK_SanPham
	PRIMARY KEY(MaSP)
)
CREATE TABLE LichSuGia
(
	MaLSGia int not null IDENTITY,
	MaSP int,
	GiaTruocGiam int,
	GiaSauGiam int,
	NgayApDung datetime
	CONSTRAINT PK_LichSuGia
	PRIMARY KEY(MaLSGia)
)

--TẠO RÀNG BUỘC KHÓA NGOẠI
ALTER TABLE LichSuThuong
ADD
	CONSTRAINT FK_LichSuThuong_NhanVien
	FOREIGN KEY(MaNV)
	REFERENCES NhanVien(MaNV)

ALTER TABLE NV_TTinKhac
ADD
	CONSTRAINT FK_NV_TTinKhac_NhanVien
	FOREIGN KEY(MaNV)
	REFERENCES NhanVien(MaNV)

ALTER TABLE LichSuLuong
ADD
	CONSTRAINT FK_LichSuLuong_NhanVien
	FOREIGN KEY(MaNV)
	REFERENCES NhanVien(MaNV)

ALTER TABLE YeuCauHoTro
ADD
	CONSTRAINT FK_YeuCauHoTro_KhachHang
	FOREIGN KEY(MaKH)
	REFERENCES KhachHang(MaKH)

ALTER TABLE NVQuanLy
ADD
	CONSTRAINT FK_NVQuanLy_NhanVien
	FOREIGN KEY(MaNV)
	REFERENCES NhanVien(MaNV)

ALTER TABLE NhanVien
ADD
	CONSTRAINT FK_NhanVien_CongViec
	FOREIGN KEY(MaCViec)
	REFERENCES CongViec(MaCViec),
	CONSTRAINT FK_NhanVien_ChiNhanh
	FOREIGN KEY(MaCNhanh)
	REFERENCES ChiNhanh(MaCNhanh)

ALTER TABLE GiaoHang
ADD
	CONSTRAINT FK_GiaoHang_DonHang
	FOREIGN KEY(MaDH)
	REFERENCES DonHang(MaDH),
	CONSTRAINT FK_GiaoHang_NhanVien
	FOREIGN KEY(MaNV)
	REFERENCES NhanVien(MaNV)

ALTER TABLE BanHang
ADD
	CONSTRAINT FK_BanHang_DonHang
	FOREIGN KEY(MaDH)
	REFERENCES DonHang(MaDH),
	CONSTRAINT FK_BanHang_NhanVien
	FOREIGN KEY(MaNV)
	REFERENCES NhanVien(MaNV)

ALTER TABLE KhuVuc
ADD
	CONSTRAINT FK_KhuVuc_ChiNhanh
	FOREIGN KEY(MaCNhanh)
	REFERENCES ChiNhanh(MaCNhanh)

ALTER TABLE DonHang
ADD
	CONSTRAINT FK_DonHang_KhachHang
	FOREIGN KEY(MaKH)
	REFERENCES KhachHang(MaKH),
	CONSTRAINT FK_DonHang_QuaTangKem
	FOREIGN KEY(MaQTang)
	REFERENCES QuaTangKem(MaQTang),
	CONSTRAINT FK_DonHang_ChiNhanh
	FOREIGN KEY(MaCNhanh)
	REFERENCES ChiNhanh(MaCNhanh),
	CONSTRAINT FK_DonHang_KhuVuc
	FOREIGN KEY(MaKV)
	REFERENCES KhuVuc(MaKV)

ALTER TABLE DH_TTinKhac
ADD
	CONSTRAINT FK_DH_TTinKhac_DonHang
	FOREIGN KEY(MaDH)
	REFERENCES DonHang(MaDH)

ALTER TABLE DonNhap
ADD
	CONSTRAINT FK_DonNhap_NhaCungCap
	FOREIGN KEY(MaNCC)
	REFERENCES NhaCungCap(MaNCC),
	CONSTRAINT FK_DonNhap_ChiNhanh
	FOREIGN KEY(MaCNhanh)
	REFERENCES ChiNhanh(MaCNhanh)

ALTER TABLE SP_CN
ADD
	CONSTRAINT FK_SP_CN_SanPham
	FOREIGN KEY(MaSP)
	REFERENCES SanPham(MaSP),
	CONSTRAINT FK_SP_CN_ChiNhanh
	FOREIGN KEY(MaCNhanh)
	REFERENCES ChiNhanh(MaCNhanh)

ALTER TABLE ChiTietDH
ADD
	CONSTRAINT FK_ChiTietDH_SanPham
	FOREIGN KEY(MaSP)
	REFERENCES SanPham(MaSP),
	CONSTRAINT FK_ChiTietDH_DonHang
	FOREIGN KEY(MaDH)
	REFERENCES DonHang(MaDH)

ALTER TABLE ChiTietDNhap
ADD
	CONSTRAINT FK_ChiTietDNhap_DonNhap
	FOREIGN KEY(MaDNhap)
	REFERENCES DonNhap(MaDNhap),
	CONSTRAINT FK_ChiTietDNhap_SanPham
	FOREIGN KEY(MaSP)
	REFERENCES SanPham(MaSP)

ALTER TABLE LichSuGia
ADD
	CONSTRAINT FK_LichSuGia_SanPham
	FOREIGN KEY(MaSP)
	REFERENCES SanPham(MaSP)