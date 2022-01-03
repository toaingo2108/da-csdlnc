import React from 'react'
import { Card } from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'

const SanPhamDonHang = ({
    sanPham: { MaSP, TenSP, GiaBan, SoLuongSP, ThanhTien, LinkHinhAnh },
}) => {
    let navigate = useNavigate()

    return (
        <Card
            className="d-flex flex-row"
            onClick={() => navigate(`/chi-tiet-sp/${MaSP}`)}>
            <Card.Img
                variant="top"
                src={
                    LinkHinhAnh
                        ? LinkHinhAnh
                        : 'https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg'
                }
                style={{ width: '100px' }}
                className="mx-4"
            />
            <Card.Body className="d-flex justify-content-between align-items-center">
                <div>
                    <div className="fw-bold text-danger">{TenSP}</div>
                    <div className="my-2">{GiaBan} đ</div>
                    <div>Số lượng: {SoLuongSP}</div>
                </div>
                <div className="fs-4 text-success">Thành tiền: {ThanhTien}</div>
            </Card.Body>
        </Card>
    )
}

export default SanPhamDonHang
