import React from 'react'
import { Badge, Card } from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'

const SanPhamDon = ({ sanPham }) => {
    let navigate = useNavigate()

    return (
        <Card
            className="text-center hover-item-2"
            onClick={() => navigate(`/chi-tiet-sp/${sanPham.MaSP}`)}>
            <Badge
                className="fw-bold fs-5 py-2 m-0 position-absolute"
                bg="primary"
                style={{ top: '10px' }}>
                SALE
            </Badge>
            <Card.Img
                variant="top"
                src={
                    sanPham.LinkHinhAnh
                        ? sanPham.LinkHinhAnh
                        : 'https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg'
                }
            />
            <Card.Body>
                <span className="text-nowrap ms-0">{sanPham.TenSP}</span>
                <div className="d-flex justify-content-evenly">
                    <div className="text-decoration-line-through">
                        {sanPham.GiaTruocGiam} đ
                    </div>
                    <div className="text-danger fw-bold">
                        {sanPham.GiaSauGiam} đ
                    </div>
                </div>
            </Card.Body>
        </Card>
    )
}

export default SanPhamDon
