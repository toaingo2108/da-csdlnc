import axios from 'axios'
import React, { useContext, useEffect, useState } from 'react'
import { Row, Spinner } from 'react-bootstrap'
import { AuthContext } from '../../contexts/AuthContext'
import { apiUrl } from '../../contexts/contants'
import ChiTietDonHang from './ChiTietDonHang'
import DonHangDon from './DonHangDon'

const DonHang = () => {
    const {
        khachHang: { MaKH },
    } = useContext(AuthContext)

    const [DsDonHang, setDsDonHang] = useState([])

    const [loading, setLoading] = useState(true)

    const getDsDonHangCuaKhachHang = async (MaKH) => {
        try {
            const response = await axios.get(
                `${apiUrl}/don-hang/khach-hang/${MaKH}`
            )
            if (response.data.success) {
                setDsDonHang(response.data.DsDonHang)
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

    useEffect(() => {
        getDsDonHangCuaKhachHang(MaKH)
    }, [MaKH])

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else if (DsDonHang.length === 0) {
        body = (
            <>
                <h2>Chưa có đơn hàng nào</h2>
            </>
        )
    } else {
        body = (
            <>
                {DsDonHang.sort((a, b) => b.MaDH - a.MaDH).map((donHang) => (
                    <Row key={donHang.MaDH} className="my-4">
                        <ChiTietDonHang donHang={donHang} />
                        <DonHangDon donHang={donHang} />
                    </Row>
                ))}
            </>
        )
    }
    return <>{body}</>
}

export default DonHang
