import './App.css'
import { Routes, Route } from 'react-router-dom'
import Home from './components/pages/Home'
import Navbar from './components/navbar/Navbar'
import Header from './components/views/Header'
import TimSanPham from './components/sanPham/TimSanPham'
import Benefit from './components/views/Benefit'
import ChiTietSanPham from './components/sanPham/ChiTietSanPham'
import DangKyKhachHang from './components/khachHang/DangKyKhachHang'
import SanPhamChuDe from './components/sanPham/SanPhamChuDe'
import SanPhamMauSac from './components/sanPham/SanPhamMauSac'
import DangNhapKhachHang from './components/khachHang/DanhNhapKhachHang'
import ThongTinKhachHang from './components/khachHang/ThongTinKhachHang'
import XemDonHang from './components/khachHang/XemDonHang'
import DoiMatKhauKhachHang from './components/khachHang/DoiMatKhauKhachHang'
import QuaTangKem from './components/quaTangKem/QuaTangKem'
import ThemSanPham from './components/sanPham/ThemSanPham'
import GioHang from './components/pages/GioHang'

function App() {
    return (
        <>
            <Navbar />
            <Header />
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/gio-hang" element={<GioHang />} />
                <Route path="/tim-san-pham/:key" element={<TimSanPham />} />
                <Route path="/them-san-pham" element={<ThemSanPham />} />
                <Route path="/chi-tiet-sp/:MaSP" element={<ChiTietSanPham />} />
                <Route
                    path="/dang-nhap-khach-hang"
                    element={<DangNhapKhachHang />}
                />
                <Route
                    path="/dang-ky-khach-hang"
                    element={<DangKyKhachHang />}
                />
                <Route
                    path="/doi-mat-khau-khach-hang"
                    element={<DoiMatKhauKhachHang />}
                />
                <Route path="/chu-de/:MaCDe" element={<SanPhamChuDe />} />
                <Route path="/mau-sac/:MaMau" element={<SanPhamMauSac />} />
                <Route path="/khach-hang" element={<ThongTinKhachHang />} />
                <Route path="/khach-hang/don-hang" element={<XemDonHang />} />
                <Route path="/qua-tang-kem" element={<QuaTangKem />} />
            </Routes>
            <Benefit />
        </>
    )
}

export default App
