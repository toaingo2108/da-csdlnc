USE QLDH
GO

CREATE INDEX inx_LichSuThuong_MaNV 
    ON LichSuThuong (MaNV)
GO

CREATE INDEX inx_NhanVien_MaCN
    ON NhanVien (MaCNhanh)
GO

CREATE INDEX inx_SanPham_TenSP
    ON SanPham (TenSP)
GO

CREATE INDEX inx_SanPham_GiaSauGiam
    ON SanPham (GiaSauGiam)
GO

