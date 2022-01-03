import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { apiUrl } from '../../contexts/contants'
import { Link, useParams } from 'react-router-dom'
import { Col, Container, Row, Spinner } from 'react-bootstrap'
import SortGiaSauGiam from './SortGiaSauGiam'
import SanPhamDon from './SanPhamDon'

const TimSanPham = () => {
    const [DsSanPham, setDsSanPham] = useState([])

    const [loading, setLoading] = useState(true)

    const [currentSort, setCurrentSort] = useState('thapCao')

    let { key } = useParams()

    const getDsSanPhamTimkiem = async () => {
        try {
            const response = await axios.get(
                `${apiUrl}/san-pham/tim-san-pham/${key}`
            )
            if (response.data.success) {
                setDsSanPham(response.data.DsSanPham)
                setLoading(false)
            }
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
    useEffect(() => getDsSanPhamTimkiem(), [key])

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
                <h2>Không có kết quả tìm kiếm cho "{key}"</h2>
            </>
        )
    } else {
        body = (
            <>
                <Row>
                    <Col className="d-flex my-3 fs-5 p-0">
                        <Link
                            to="#"
                            onClick={() => setCurrentSort('thapCao')}
                            className="me-4">
                            Giá từ thấp đến cao
                        </Link>
                        <Link to="#" onClick={() => setCurrentSort('caoThap')}>
                            Giá từ cao đến thấp
                        </Link>
                    </Col>
                </Row>
                <Row>
                    <>
                        <h2>
                            Có {DsSanPham.length} kết quả tìm kiếm cho "{key}"
                        </h2>
                        {DsSanPham.sort((a, b) =>
                            SortGiaSauGiam[currentSort].fn(a, b)
                        ).map((sanPham) => (
                            <Col key={sanPham.MaSP} xs={3} className="my-2">
                                <SanPhamDon sanPham={sanPham} />
                            </Col>
                        ))}
                    </>
                </Row>
            </>
        )
    }
    return <Container className="my-container">{body}</Container>
}

export default TimSanPham
