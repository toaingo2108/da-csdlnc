import React, { useContext, useEffect, useState } from 'react'
import { Card, CloseButton } from 'react-bootstrap'
import { Link } from 'react-router-dom'
import { AuthContext } from '../../contexts/AuthContext'
import * as FaIcons from 'react-icons/fa'

const SanPhamGioHang = ({
    sanPham: { MaSP, TenSP, GiaSauGiam, LinkHinhAnh, soLuong },
}) => {
    const { gioHang, setGioHang } = useContext(AuthContext)

    const [updatedSoLuong, setUpdatedSoluong] = useState(soLuong)

    const handleXoaKhoiGioHang = (MaSP) => {
        const newGioHang = gioHang.filter((sanPham) => sanPham.MaSP !== MaSP)
        setGioHang(newGioHang)
    }

    const indexSanPham = gioHang.findIndex((sp) => sp.MaSP === MaSP)

    const sanPhamUpdate = {
        MaSP,
        TenSP,
        GiaSauGiam,
        LinkHinhAnh,
        soLuong: updatedSoLuong,
    }

    const updateSoLuong = () => {
        gioHang.splice(indexSanPham, 1, sanPhamUpdate)
        setGioHang(gioHang)
    }

    useEffect(() => {
        updateSoLuong()
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [updatedSoLuong])

    return (
        <Card className="d-flex flex-row mb-4">
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
                    <div className="my-2">{GiaSauGiam} đ</div>
                    <div className="d-flex align-items-center">
                        Số lượng:
                        <Link
                            to="#"
                            className="mx-2 fs-3"
                            onClick={() =>
                                setUpdatedSoluong(updatedSoLuong - 1)
                            }>
                            <FaIcons.FaRegMinusSquare />
                        </Link>
                        <div>{updatedSoLuong}</div>
                        <Link
                            to="#"
                            className="mx-2 fs-3"
                            onClick={() =>
                                setUpdatedSoluong(updatedSoLuong + 1)
                            }>
                            <FaIcons.FaRegPlusSquare />
                        </Link>
                    </div>
                </div>
            </Card.Body>
            <CloseButton
                className="p-3"
                onClick={handleXoaKhoiGioHang.bind(this, MaSP)}
            />
        </Card>
    )
}

export default SanPhamGioHang
