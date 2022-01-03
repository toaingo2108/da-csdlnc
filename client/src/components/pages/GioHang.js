import axios from 'axios'
import React, { useContext, useEffect, useState } from 'react'
import {
    Button,
    Card,
    Col,
    Container,
    Form,
    ListGroup,
    Row,
} from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'
import { AuthContext } from '../../contexts/AuthContext'
import { apiUrl } from '../../contexts/contants'
import SanPhamGioHang from '../sanPham/SanPhamGioHang'

const GioHang = () => {
    const { gioHang, isAuthenticated, khachHang, setGioHang } =
        useContext(AuthContext)

    const [DsTenTinh, setDsTenTinh] = useState([])
    const [DsTen_QHuyen, setDsTen_QHuyen] = useState([])
    const [formKhuVuc, setFormKhuVuc] = useState({
        tenTinh: '',
        ten_QHuyen: '',
    })
    const { tenTinh, ten_QHuyen } = formKhuVuc
    const [SDT_NgNhan, setSDT_NgNhan] = useState('')
    const [MaQTang, setMaQTang] = useState('')
    const [DsQuaTang, setDsQuaTang] = useState([])
    const [khuVuc, setKhuVuc] = useState({
        MaKV: '',
        MaTinh: '',
        TenTinh: '',
        Ten_QHuyen: '',
        PhiGiaoHang: '',
        MaCNhanh: '',
    })
    const { MaKV, PhiGiaoHang, MaCNhanh } = khuVuc

    const donHang = {
        SDT_NgNhan,
        HinhThucTT: 1,
        TrangThaiDH: 0,
        MaKH: khachHang.MaKH,
        MaQTang,
        MaCNhanh,
        MaKV,
    }

    const today = new Date()
    const ngayLap = `${today.getDate()} / ${
        today.getMonth() + 1
    } / ${today.getFullYear()} `

    let navigate = useNavigate()

    const getDsQuaTang = async () => {
        try {
            const response = await axios.get(`${apiUrl}/qua-tang`)
            if (response.data.success) {
                setDsQuaTang(response.data.DsQuaTang)
            }
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    const getDsTenTinh = async () => {
        try {
            const response = await axios.get(`${apiUrl}/khu-vuc/ten-tinh`)
            if (response.data.success) {
                setDsTenTinh(response.data.DsTenTinh)
            }
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    const getDsTen_QHuyen = async () => {
        try {
            const response = await axios.get(
                `${apiUrl}/khu-vuc/ten-quan-huyen/${tenTinh}`
            )
            if (response.data.success) {
                setDsTen_QHuyen(response.data.DsTen_QHuyen)
            }
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    const getKhuVuc = async (formKhuVuc) => {
        try {
            const response = await axios.post(
                `${apiUrl}/khu-vuc/xuat-khu-vuc`,
                formKhuVuc
            )
            if (response.data.success) {
                setKhuVuc({ ...response.data.khuVuc })
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
        getDsQuaTang()
        return () => {
            setDsQuaTang([])
        }
    }, [])

    useEffect(() => {
        getDsTenTinh()
        return () => {
            setDsTenTinh([])
        }
    }, [])

    useEffect(() => {
        if (tenTinh !== '') {
            getDsTen_QHuyen()
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [tenTinh])

    // eslint-disable-next-line react-hooks/exhaustive-deps
    useEffect(() => getKhuVuc(formKhuVuc), [ten_QHuyen])

    const onChangeKhuVuc = (event) => {
        setFormKhuVuc({
            ...formKhuVuc,
            [event.target.name]: event.target.value,
        })
    }

    const taoDonHang = async (donHang) => {
        try {
            const response = await axios.post(
                `${apiUrl}/don-hang/tao-don-hang`,
                donHang
            )
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    const themChiTietDonHang = async (chiTietDonHang) => {
        try {
            const response = await axios.post(
                `${apiUrl}/don-hang/them-chi-tiet`,
                chiTietDonHang
            )
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    const handleSubmit = async (event) => {
        event.preventDefault()
        const { success, DonHang } = await taoDonHang(donHang)
        if (success) {
            const { MaDH } = DonHang
            gioHang.map(async (sanPham) => {
                const chiTiet = {
                    MaDH,
                    MaSP: sanPham.MaSP,
                    SoLuongDat: sanPham.soLuong,
                }
                return await themChiTietDonHang(chiTiet)
            })
            setGioHang([])
            setFormKhuVuc({
                tenTinh: '',
                ten_QHuyen: '',
            })
            setSDT_NgNhan('')
            navigate('/')
        } else {
            alert('Thất bại')
        }
    }

    if (!isAuthenticated) {
        navigate('/')
    }

    return (
        <Container className="my-container">
            <Row>
                <Col xs={8}>
                    {gioHang.length !== 0 ? (
                        gioHang.map((sanPham) => (
                            <div key={sanPham.MaSP}>
                                <SanPhamGioHang sanPham={sanPham} />
                            </div>
                        ))
                    ) : (
                        <>
                            <h4>Chưa có sản phẩm nào trong giỏ hàng</h4>
                        </>
                    )}
                </Col>
                <Col xs={4}>
                    {' '}
                    <Form onSubmit={handleSubmit}>
                        <Card>
                            <ListGroup variant="flush">
                                <ListGroup.Item className="d-flex justify-content-between flex-column">
                                    <Form.Group className="mb-3">
                                        <Form.Label>
                                            Chọn Thành phố (Tỉnh)
                                        </Form.Label>
                                        <Form.Select
                                            value={tenTinh}
                                            name="tenTinh"
                                            required
                                            onChange={onChangeKhuVuc}>
                                            <option value="">
                                                --Chọn Tỉnh--
                                            </option>
                                            {DsTenTinh.map((tinh, index) => (
                                                <option key={index}>
                                                    {tinh.TenTinh}
                                                </option>
                                            ))}
                                        </Form.Select>
                                    </Form.Group>
                                    <Form.Group className="mb-3">
                                        <Form.Label>
                                            Chọn Quận (Huyện)
                                        </Form.Label>
                                        <Form.Select
                                            value={ten_QHuyen}
                                            name="ten_QHuyen"
                                            required
                                            onChange={onChangeKhuVuc}>
                                            <option value="">
                                                --Chọn Quận Huyện--
                                            </option>
                                            {DsTen_QHuyen.map((quan, index) => (
                                                <option key={index}>
                                                    {quan.Ten_QHuyen}
                                                </option>
                                            ))}
                                        </Form.Select>
                                    </Form.Group>
                                    <Form.Group className="mb-3">
                                        <Form.Label>Chọn quà tặng</Form.Label>
                                        <Form.Select
                                            // value={MaQTang}

                                            onChange={(e) =>
                                                setMaQTang(e.target.value)
                                            }>
                                            <option value="">
                                                --Chọn quà tặng --
                                            </option>
                                            {DsQuaTang.map((quaTang, index) => (
                                                <option
                                                    key={index}
                                                    value={quaTang.MaQTang}>
                                                    {quaTang.TenQT}
                                                </option>
                                            ))}
                                        </Form.Select>
                                    </Form.Group>
                                </ListGroup.Item>
                                <ListGroup.Item className="d-flex justify-content-between">
                                    <div>Ngày lập:</div>
                                    <div className="text-danger fw-bold fs-6">
                                        {ngayLap}
                                    </div>
                                </ListGroup.Item>
                                <ListGroup.Item className="">
                                    <Form.Group
                                        as={Row}
                                        className="mb-3 d-flex justify-content-between ">
                                        <Form.Label column sm="5">
                                            SĐT người nhận
                                        </Form.Label>
                                        <Col sm="7">
                                            <Form.Control
                                                type="tel"
                                                placeholder="09xxxxxxxx"
                                                name="SDT_NgNhan"
                                                value={SDT_NgNhan}
                                                onChange={(e) =>
                                                    setSDT_NgNhan(
                                                        e.target.value
                                                    )
                                                }
                                            />
                                        </Col>
                                    </Form.Group>
                                </ListGroup.Item>
                                {/* <ListGroup.Item className="d-flex justify-content-between">
                                    <div>Phí sản phẩm:</div>
                                    <div>{phiSP} đ</div>
                                </ListGroup.Item> */}
                                <ListGroup.Item className="d-flex justify-content-between">
                                    <div>Phí giao hàng:</div>
                                    <div className="text-danger fw-bold fs-6">
                                        {PhiGiaoHang} đ
                                    </div>
                                </ListGroup.Item>
                                {/* <ListGroup.Item className="d-flex justify-content-between text-danger fw-bold fs-5">
                                    <div>Tổng tiền:</div>
                                    <div>{TongTienDH} đ</div>
                                </ListGroup.Item> */}
                            </ListGroup>
                        </Card>
                        <div className="d-grid gap-2 mt-4">
                            <Button
                                type="submit"
                                variant="danger"
                                size="lg"
                                disabled={gioHang.length === 0 ? true : false}>
                                Đặt hàng
                            </Button>
                        </div>
                    </Form>
                </Col>
            </Row>
        </Container>
    )
}

export default GioHang
