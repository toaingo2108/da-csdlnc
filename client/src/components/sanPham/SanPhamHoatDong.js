import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { Col, Row, Spinner } from 'react-bootstrap'
import { apiUrl } from '../../contexts/contants'
import SanPhamDon from './SanPhamDon'

const SanPhamHoatDong = () => {
    const [DsSanPham, setDsSanPham] = useState([])

    const [loading, setLoading] = useState(true)

    const getDsSanPham = async () => {
        try {
            const response = await axios.get(`${apiUrl}/san-pham/`)
            if (response.data.success) {
                setDsSanPham(response.data.DsSanPham)
                setLoading(false)
            }
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
    useEffect(() => getDsSanPham(), [])

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else if (DsSanPham.length === 0) {
        body = (
            <>
                <h2>Danh sách rỗng</h2>
            </>
        )
    } else {
        body = (
            <>
                <Row>
                    {DsSanPham.map((sanPham) => (
                        <Col key={sanPham.MaSP} xs={3} className="mb-3">
                            <SanPhamDon sanPham={sanPham} />
                        </Col>
                    ))}
                </Row>
            </>
        )
    }

    return <>{body}</>
}

export default SanPhamHoatDong
