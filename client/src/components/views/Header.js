import React, { useContext, useState } from 'react'
import {
    Button,
    Card,
    Col,
    Container,
    Form,
    Image,
    ListGroup,
    Ratio,
    Row,
} from 'react-bootstrap'
import * as AiIcons from 'react-icons/ai'
import { Link, useNavigate } from 'react-router-dom'
import logo from '../../assets/img/logo-hoa-yeu-thuong.png'
import { AuthContext } from '../../contexts/AuthContext'
import { SidebarData } from '../navbar/SidebarData'

const Header = () => {
    const { isAuthenticated, khachHang, logout, gioHang } =
        useContext(AuthContext)

    const [search, setSearch] = useState('')

    let navigate = useNavigate()

    const onSubmit = (event) => {
        event.preventDefault()
        navigate(`/tim-san-pham/${search}`)
        setSearch('')
    }

    const hanldeLogout = () => {
        logout()
        navigate('/')
    }

    return (
        <>
            <Container>
                <Row className="my-4">
                    <Col xs={2}>
                        <Image
                            src={logo}
                            alt=""
                            width="100%"
                            className="mt-3"
                            onClick={() => navigate('/')}
                            style={{ cursor: 'pointer' }}
                        />
                    </Col>
                    <Col className="d-flex align-items-center ms-2">
                        <Form onSubmit={onSubmit} className="input-group">
                            <input
                                type="search"
                                className="form-control rounded"
                                placeholder="Tìm sản phẩm"
                                aria-label="Search"
                                aria-describedby="search-addon"
                                required
                                value={search}
                                onChange={(e) => setSearch(e.target.value)}
                            />
                            <button
                                type="submit"
                                className="btn btn-outline-primary">
                                Tìm kiếm
                            </button>
                        </Form>
                    </Col>
                    <Col xs={3} className="d-flex justify-content-end">
                        <Link
                            to={isAuthenticated ? '/gio-hang' : '#'}
                            className="d-flex flex-column align-items-center">
                            <AiIcons.AiOutlineShoppingCart className="display-6" />
                            <div>Giỏ hàng ({gioHang.length})</div>
                        </Link>

                        <div className="d-flex flex-column align-items-center ms-5 sub-parent">
                            {isAuthenticated ? (
                                <>
                                    <Ratio aspectRatio="1x1" className="avatar">
                                        <div className="d-flex justify-content-center align-items-center">
                                            <span className="ms-0">
                                                <AiIcons.AiOutlineUser />
                                            </span>
                                        </div>
                                    </Ratio>
                                    <div>Xin chào, {khachHang.TenKH}</div>
                                </>
                            ) : (
                                <>
                                    <AiIcons.AiOutlineUser className="display-6" />
                                    <div>Tài khoản</div>
                                </>
                            )}
                            <Card className="sub-child">
                                {!isAuthenticated ? (
                                    <Card.Body className="d-flex flex-column">
                                        <Button
                                            className="fs-6"
                                            variant="warning"
                                            onClick={() =>
                                                navigate('/dang-ky-khach-hang')
                                            }>
                                            Đăng ký
                                        </Button>
                                        <Button
                                            className="fs-6 mt-4"
                                            variant="warning"
                                            onClick={() =>
                                                navigate(
                                                    '/dang-nhap-khach-hang'
                                                )
                                            }>
                                            Đăng nhập
                                        </Button>
                                    </Card.Body>
                                ) : (
                                    <ListGroup variant="flush">
                                        <ListGroup.Item>
                                            <Link to="/khach-hang">
                                                Thông tin tài khoản
                                            </Link>
                                        </ListGroup.Item>
                                        <ListGroup.Item>
                                            <Link to="/doi-mat-khau-khach-hang">
                                                Đổi mật khẩu
                                            </Link>
                                        </ListGroup.Item>
                                        <ListGroup.Item>
                                            <Link to="/khach-hang/don-hang">
                                                Xem lại đơn hàng
                                            </Link>
                                        </ListGroup.Item>
                                        <ListGroup.Item className="text-danger fw-bold">
                                            <Link
                                                to="#"
                                                onClick={hanldeLogout}
                                                className="hover-text-red ">
                                                Đăng xuất
                                            </Link>
                                        </ListGroup.Item>
                                    </ListGroup>
                                )}
                            </Card>
                        </div>
                    </Col>
                </Row>
            </Container>
            <div className="py-3 px-4 bg-light my-3">
                <Container>
                    <Row className="d-flex justify-content-between">
                        {SidebarData.map((item, index) => {
                            return (
                                <Col key={index}>
                                    <Link
                                        to={item.path}
                                        className="text-black text-uppercase fw-bold d-flex justify-content-center "
                                        style={{
                                            fontSize: '16px',
                                            textDecoration: 'none',
                                        }}>
                                        <span className="m-0 hover-text-red">
                                            {item.title}
                                        </span>
                                    </Link>
                                </Col>
                            )
                        })}
                    </Row>
                </Container>
            </div>
        </>
    )
}

export default Header
