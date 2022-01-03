import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { Card, Col, Spinner } from 'react-bootstrap'
import { apiUrl } from '../../contexts/contants'
import QuaTangKemDon from '../quaTangKem/QuaTangKemDon'
import SanPhamDonHang from '../sanPham/SanPhamDonHang'

const ChiTietDonHang = ({ donHang: { MaDH, MaQTang } }) => {
    const [DsSanPhamDonHang, setDsSanPhamDonHang] = useState([])
    const [quaTang, setQuaTang] = useState({})
    const [loading, setLoading] = useState(true)
    const [loadingQT, setLoadingQT] = useState(true)

    const getDsSanPhamDonHang = async (MaDH) => {
        try {
            const response = await axios.get(
                `${apiUrl}/don-hang/chi-tiet/${MaDH}`
            )
            if (response.data.success) {
                setDsSanPhamDonHang(response.data.DsSanPhamDonHang)
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

    const getQuaTangDonHang = async (MaQTang) => {
        try {
            const response = await axios.get(`${apiUrl}/qua-tang/${MaQTang}`)
            if (response.data.success) {
                setQuaTang(response.data.quaTang)
                setLoadingQT(false)
            }
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    useEffect(() => {
        getDsSanPhamDonHang(MaDH)
    }, [MaDH])

    useEffect(() => {
        getQuaTangDonHang(MaQTang)
    }, [MaQTang])

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else if (loadingQT) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else {
        body = (
            <>
                <Col xs={8}>
                    <Card>
                        <Card.Body>
                            <Card.Title>Đơn hàng {MaDH}</Card.Title>
                            <div>
                                {DsSanPhamDonHang.map((sanPham) => (
                                    <Col
                                        xs={12}
                                        key={sanPham.MaSP}
                                        className="my-2 hover-item-2">
                                        <SanPhamDonHang sanPham={sanPham} />
                                    </Col>
                                ))}
                            </div>
                            <div className="d-flex justify-content-between align-items-end">
                                <div style={{ width: '100px' }}>
                                    {MaQTang ? (
                                        <div className="text-nowrap">
                                            Quà tặng kèm
                                            <Card className="hover-item-2 d-flex flex-row">
                                                <QuaTangKemDon
                                                    quaTang={quaTang}
                                                />
                                            </Card>
                                        </div>
                                    ) : (
                                        ''
                                    )}
                                </div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
            </>
        )
    }

    return <>{body}</>
}

export default ChiTietDonHang
