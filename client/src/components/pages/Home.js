import React from 'react'
import { Badge, Card, Col, Container, Image, Row } from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'
import SanPhamHoatDong from '../sanPham/SanPhamHoatDong'

const Home = () => {
    let navigate = useNavigate()
    return (
        <>
            <div className="py-3 bg-light">
                <Container>
                    <Row className="d-flex justify-content-between pb-1">
                        <Col xs={12} className="mb-3">
                            <h5 className="text-danger">
                                Mẫu hoa mới năm 2022
                            </h5>
                        </Col>
                        <Col
                            xs={2}
                            className="d-flex flex-column align-items-center justify-content-center hover-text-red">
                            <Image
                                src="https://hyt.r.worldssl.net/images/icon-hoa-tinh-yeu.png"
                                width="180"
                                height="180"
                                roundedCircle
                                className="hover-item"
                                onClick={() => navigate('/chu-de/1')}
                            />
                            <div className="text-uppercase mt-3 fw-bold ">
                                Hoa Tình Yêu
                            </div>
                        </Col>
                        <Col
                            xs={2}
                            className="d-flex flex-column align-items-center justify-content-center hover-text-red">
                            <Image
                                src="https://hyt.r.worldssl.net/images/icon-hoa-sinh-nhat.png"
                                width="180"
                                height="180"
                                roundedCircle
                                className="hover-item"
                                onClick={() => navigate('/chu-de/1')}
                            />
                            <div className="text-uppercase mt-3 fw-bold ">
                                Hoa sinh nhật
                            </div>
                        </Col>
                        <Col
                            xs={2}
                            className="d-flex flex-column align-items-center justify-content-center hover-text-red">
                            <Image
                                src="https://hyt.r.worldssl.net/images/icon-mau-hoa-moi.png"
                                width="180"
                                height="180"
                                roundedCircle
                                className="hover-item"
                                onClick={() => navigate('/chu-de/1')}
                            />
                            <div className="text-uppercase mt-3 fw-bold ">
                                Mẫu hoa mới
                            </div>
                        </Col>
                        <Col
                            xs={2}
                            className="d-flex flex-column align-items-center justify-content-center hover-text-red">
                            <Image
                                src="https://hyt.r.worldssl.net/images/icon-cay-vp.png"
                                width="180"
                                height="180"
                                roundedCircle
                                className="hover-item"
                                onClick={() => navigate('/chu-de/1')}
                            />
                            <div className="text-uppercase mt-3 fw-bold ">
                                Cây văn phòng
                            </div>
                        </Col>
                        <Col
                            xs={2}
                            className="d-flex flex-column align-items-center justify-content-center hover-text-red">
                            <Image
                                src="https://hyt.r.worldssl.net/images/icon-hoa-chuc-mung.png"
                                width="180"
                                height="180"
                                roundedCircle
                                className="hover-item"
                                onClick={() => navigate('/chu-de/1')}
                            />
                            <div className="text-uppercase mt-3 fw-bold ">
                                Hoa chúc mừng
                            </div>
                        </Col>
                        <Col
                            xs={2}
                            className="d-flex flex-column align-items-center justify-content-center hover-text-red">
                            <Image
                                src="https://hyt.r.worldssl.net/images/icon-hoa-tang-le.png"
                                width="180"
                                height="180"
                                roundedCircle
                                className="hover-item"
                                onClick={() => navigate('/chu-de/1')}
                            />
                            <div className="text-uppercase mt-3 fw-bold ">
                                Lẵng hoa chia buồn
                            </div>
                        </Col>
                    </Row>
                </Container>
            </div>

            <Container className="py-3 px-4 bg-light my-3">
                <h3 className="fw-bold text-danger">KHUYẾN MÃI</h3>
                <SanPhamHoatDong />
                {/* <Row>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2 position-relative">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                    <Col xs={3} className="my-2">
                        <Card className="text-center hover-item-2">
                            <Badge
                                className="fw-bold fs-5 py-2 m-0 position-absolute"
                                bg="primary"
                                style={{ top: '10px' }}>
                                SALE
                            </Badge>
                            <Card.Img
                                variant="top"
                                src="https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/hoa-khuyen-mai/10708_you-are-beautiful.jpg"
                            />
                            <Card.Body>
                                <Card.Text>You are beautiful</Card.Text>
                                <div className="d-flex justify-content-evenly">
                                    <div className="text-decoration-line-through">
                                        800.000 đ
                                    </div>
                                    <div className="text-danger fw-bold">
                                        700.000 đ
                                    </div>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                </Row> */}
            </Container>
        </>
    )
}

export default Home
