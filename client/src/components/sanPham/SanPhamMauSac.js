import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { Col, Container, ListGroup, Row, Spinner } from 'react-bootstrap'
import { Link, useParams } from 'react-router-dom'
import { apiUrl } from '../../contexts/contants'
import MauSac from '../pages/MauSac'
import SanPhamDon from './SanPhamDon'
import SortGiaSauGiam from './SortGiaSauGiam'

const SanPhamMauSac = () => {
    const [DsSanPhamMS, setDsSanPhamMS] = useState([])

    const [loading, setLoading] = useState(true)

    const [currentSort, setCurrentSort] = useState('thapCao')

    let { MaMau } = useParams()

    const getDsSanPhamMS = async () => {
        try {
            const response = await axios.get(
                `${apiUrl}/san-pham/mau-sac/${MaMau}`
            )
            if (response.data.success) {
                setDsSanPhamMS(response.data.DsSanPhamMS)
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
    useEffect(() => getDsSanPhamMS(), [MaMau])

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else if (DsSanPhamMS.length === 0) {
        body = (
            <>
                <h2>Danh sách rỗng</h2>
            </>
        )
    } else {
        body = (
            <>
                <Row>
                    {DsSanPhamMS.sort((a, b) =>
                        SortGiaSauGiam[currentSort].fn(a, b)
                    ).map((sanPham) => (
                        <Col key={sanPham.MaSP} xs={4} className="mb-3">
                            <SanPhamDon sanPham={sanPham} />
                        </Col>
                    ))}
                </Row>
            </>
        )
    }

    return (
        <Container className="my-container">
            <Row>
                <Col xs={3}>
                    <Row>
                        <MauSac />
                    </Row>
                    <Row className="my-4">
                        <ListGroup>
                            <ListGroup.Item>
                                <Link
                                    to="#"
                                    onClick={() => setCurrentSort('thapCao')}
                                    className="me-4">
                                    Giá từ thấp đến cao
                                </Link>
                            </ListGroup.Item>
                            <ListGroup.Item>
                                <Link
                                    to="#"
                                    onClick={() => setCurrentSort('caoThap')}>
                                    Giá từ cao đến thấp
                                </Link>
                            </ListGroup.Item>
                        </ListGroup>
                    </Row>
                </Col>
                <Col>{body}</Col>
            </Row>
        </Container>
    )
}

export default SanPhamMauSac
