import React from 'react'
import { Card, Col, Container, Row } from 'react-bootstrap'
import * as FaIcons from 'react-icons/fa'
import * as RiIcons from 'react-icons/ri'

const Benefit = () => {
    return (
        <Container>
            <Row className="my-4">
                <Col>
                    <div className="fw-bold fs-4 text-center">
                        TẠI SAO BẠN NÊN DÙNG DỊCH VỤ CỦA CHÚNG TÔI?
                    </div>
                </Col>
            </Row>
            <Row className="my-4">
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <FaIcons.FaShippingFast className="display-5" />
                            <div>
                                <div className="fw-bold">
                                    Miễn phí giao hàng
                                </div>
                                <div>Free shipping (nội thành)</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <RiIcons.RiCustomerService2Line className="display-5" />
                            <div>
                                <div className="fw-bold">Phục vụ 24/24</div>
                                <div>24-7 service</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <RiIcons.RiFilePaper2Line className="display-5" />
                            <div>
                                <div className="fw-bold">
                                    Giá đã gồm 10% VAT
                                </div>
                                <div>Price include VAT</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <FaIcons.FaRegClock className="display-5" />
                            <div>
                                <div className="fw-bold">
                                    Giao nhanh trong 1h
                                </div>
                                <div>1h quick delivery</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <FaIcons.FaMedal className="display-5" />
                            <div>
                                <div className="fw-bold">
                                    Cam kết hài lòng 100%
                                </div>
                                <div>100% guarantee smile</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <FaIcons.FaCrown className="display-5" />
                            <div>
                                <div className="fw-bold">Hoa tươi 3+ ngày</div>
                                <div>3+ days fresh warranty</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <FaIcons.FaIdCardAlt className="display-5" />
                            <div>
                                <div className="fw-bold">
                                    Tặng thiệp cao cấp
                                </div>
                                <div>Free greeting cards</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
                <Col xs={3} className="my-2">
                    <Card
                        style={{ borderRadius: '40px' }}
                        className="hover-item">
                        <Card.Body className="d-flex justify-content-around align-items-center">
                            <FaIcons.FaTag className="display-5" />
                            <div>
                                <div className="fw-bold">Giảm giá đến 10%</div>
                                <div>Receive 3-10% discount</div>
                            </div>
                        </Card.Body>
                    </Card>
                </Col>
            </Row>
        </Container>
    )
}

export default Benefit
