import axios from 'axios'
import React, { useContext, useEffect, useState } from 'react'
import {
    Badge,
    Button,
    Card,
    Col,
    Container,
    ListGroup,
    Row,
    Spinner,
} from 'react-bootstrap'
import { useNavigate, useParams } from 'react-router-dom'
import { AuthContext } from '../../contexts/AuthContext'
import { apiUrl } from '../../contexts/contants'

const ChiTietSanPham = () => {
    const { gioHang, setGioHang } = useContext(AuthContext)

    let { MaSP } = useParams()

    let navigate = useNavigate()

    const [sanPham, setSanPham] = useState({})

    const [loading, setLoading] = useState(true)

    const {
        GiaSauGiam,
        GiaTruocGiam,
        // MaLoaiHoa,
        // MaMau,
        MoTa,
        // TrangThaiHD,
        TenLoaiHoa,
        TenSP,
        LinkHinhAnh,
    } = sanPham

    const getSanPham = async () => {
        try {
            const response = await axios.get(
                `${apiUrl}/san-pham/chi-tiet/${MaSP}`
            )
            if (response.data.success) {
                setSanPham(response.data.sanPham)
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
        getSanPham()
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [])

    const handleThemVaoGioHang = (sanPham) => {
        const checkGioHang = gioHang.find((sp) => sp.MaSP === sanPham.MaSP)
        if (checkGioHang) {
            // alert('Sản phẩm đã có trong giỏ hàng')
        } else {
            setGioHang([
                ...gioHang,
                { ...sanPham, soLuong: 1, phiSanPham: GiaSauGiam },
            ])
            // alert('Đã thêm sản phẩm vào giỏ hàng')
        }
    }

    const handleMuaNgay = (sanPham) => {
        const checkGioHang = gioHang.find((sp) => sp.MaSP === sanPham.MaSP)
        if (checkGioHang) {
            navigate('/gio-hang')
            // alert('Sản phẩm đã có trong giỏ hàng')
        } else {
            setGioHang([
                ...gioHang,
                { ...sanPham, soLuong: 1, phiSanPham: GiaSauGiam },
            ])
            navigate('/gio-hang')
            // alert('Đã thêm sản phẩm vào giỏ hàng')
        }
    }

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else {
        body = (
            <>
                <Row className="my-5">
                    <Col xs={3}>
                        <Card>
                            <Card.Img
                                variant="top"
                                src={
                                    LinkHinhAnh
                                        ? LinkHinhAnh
                                        : 'https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg'
                                }
                            />
                        </Card>
                    </Col>
                    <Col xs={8}>
                        <div className="fs-4">
                            {TenLoaiHoa} - {TenSP} - {MaSP}
                        </div>
                        <div className="d-flex fs-2 my-3">
                            <div className="text-decoration-line-through">
                                {GiaTruocGiam} đ
                            </div>
                            <div className="text-danger fw-bold ms-4">
                                {GiaSauGiam} đ
                            </div>
                        </div>
                        <div>(Giá đã bao gồm 10% VAT)</div>
                        <div className="my-4">
                            Mẫu hoa xinh xắn được lấy ý tưởng từ dáng hình của
                            những cây kem mát lạnh. Tuy không thể thưởng thức
                            được bằng vị giác, nhưng mẫu kem hoa này cũng đủ sức
                            làm tan chảy những ánh nhìn của những người yêu
                            thích hoa, đặc biệt là hoa hồng. Không chỉ đơn điệu
                            bằng một màu hoa duy nhất, bạn còn có thể yêu thay
                            đổi sang các màu hoa mà bạn yêu thích nhé. Sản phẩm
                            bao gồm: <br />
                            Hoa thạch thảo trắng: 2 <br />
                            Hồng đỏ ớt : 10 <br />
                            Đinh lăng : 7<br />
                            {MoTa}
                        </div>
                        <Col xs={6} className="my-4 d-flex flex-column">
                            <div className="d-flex justify-content-between">
                                <Button
                                    variant="outline-warning"
                                    size="lg"
                                    className="px-5"
                                    onClick={handleThemVaoGioHang.bind(
                                        this,
                                        sanPham
                                    )}>
                                    Thêm vào giỏ
                                </Button>
                                <Button
                                    variant="danger"
                                    size="lg"
                                    className="px-4"
                                    onClick={handleMuaNgay.bind(this, sanPham)}>
                                    Mua ngay
                                </Button>
                            </div>
                            <Button
                                variant="outline-success"
                                size="lg"
                                className="mt-2">
                                Gọi ngay: 1800 6353
                            </Button>
                        </Col>
                        <div>
                            <h4>Ưu đãi đặc biệt</h4>
                            <ListGroup>
                                <ListGroup.Item className="d-flex align-items-center">
                                    <Badge className="ms-0 me-3">1</Badge>
                                    <div>
                                        Tặng Banner, Thiệp (Trị Giá 20.000đ)
                                        Miễn Phí
                                    </div>
                                </ListGroup.Item>
                                <ListGroup.Item className="d-flex align-items-center">
                                    <Badge className="ms-0 me-3">2</Badge>
                                    <div>
                                        Giảm ngay 20.000đ Khi Bạn Tạo Đơn Hàng
                                        Online
                                    </div>
                                </ListGroup.Item>
                                <ListGroup.Item className="d-flex align-items-center">
                                    <Badge className="ms-0 me-3">3</Badge>
                                    <div>
                                        Giảm Tiếp 3% Cho Đơn Hàng Bạn Tạo ONLINE
                                        Lần Thứ 2, 5% Cho Đơn Hàng Bạn Tạo
                                        ONLINE Lần Thứ 6 Và 10% Cho Đơn Hàng Bạn
                                        Tạo ONLINE Lần Thứ 12 (Chỉ Áp Dụng Tại
                                        Tp. HCM Và Hà Nội) Giao Miễn Phí Trong
                                        Nội Thành 63/63 Tỉnh
                                    </div>
                                </ListGroup.Item>
                                <ListGroup.Item className="d-flex align-items-center">
                                    <Badge className="ms-0 me-3">4</Badge>
                                    <div>Giao Gấp Trong Vòng 2 Giờ</div>
                                </ListGroup.Item>
                                <ListGroup.Item className="d-flex align-items-center">
                                    <Badge className="ms-0 me-3">5</Badge>
                                    <div>
                                        Cam Kết 100% Hoàn Lại Tiền Nếu Bạn Không
                                        Hài Lòng
                                    </div>
                                </ListGroup.Item>
                                <ListGroup.Item className="d-flex align-items-center">
                                    <Badge className="ms-0 me-3">6</Badge>
                                    <div>Cam Kết Hoa Tươi Trên 3 Ngày</div>
                                </ListGroup.Item>
                            </ListGroup>
                        </div>
                    </Col>
                </Row>
            </>
        )
    }
    return <Container className="my-container">{body}</Container>
}

export default ChiTietSanPham
