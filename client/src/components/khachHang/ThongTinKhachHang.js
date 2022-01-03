import axios from 'axios'
import React, { useContext, useState } from 'react'
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

const ThongTinKhachHang = () => {
    const { khachHang, setKhachHang, isAuthenticated } = useContext(AuthContext)

    let navigate = useNavigate()

    const [updatedKhachHang, setUpdatedKhachHang] = useState(khachHang)
    const { HoKH, TenKH, SDT_KH, EmailKH, DiaChiKH } = updatedKhachHang

    if (!isAuthenticated) {
        navigate('/')
    }

    const onChangeUpdate = (event) => {
        setUpdatedKhachHang({
            ...updatedKhachHang,
            [event.target.name]: event.target.value,
        })
    }

    const updateKhachHang = async (updatedKhachHang) => {
        try {
            const response = await axios.put(
                `${apiUrl}/khach-hang/sua-thong-tin`,
                updatedKhachHang
            )
            if (response.data.success) {
                setKhachHang(updatedKhachHang)
            }
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
        const { success } = await updateKhachHang(updatedKhachHang)
        if (success) alert('Cập nhật thông tin thành công')
    }

    return (
        <Container className="my-container">
            <Row className="justify-content-md-center">
                <Col md="8">
                    <Card>
                        <Card.Body>
                            <ListGroup variant="flush">
                                <ListGroup.Item>
                                    <Card.Title>
                                        CẬP NHẬT THÔNG TIN TÀI KHOẢN
                                    </Card.Title>
                                </ListGroup.Item>
                                <ListGroup.Item>
                                    <Form onSubmit={handleSubmit}>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Email
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    plaintext
                                                    readOnly
                                                    value={EmailKH}
                                                />
                                            </Col>
                                        </Form.Group>

                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Tên
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="Tên"
                                                    name="TenKH"
                                                    value={TenKH}
                                                    onChange={onChangeUpdate}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Họ
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="Họ"
                                                    name="HoKH"
                                                    value={HoKH}
                                                    onChange={onChangeUpdate}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Số điện thoại
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="SDT"
                                                    name="SDT_KH"
                                                    value={SDT_KH}
                                                    onChange={onChangeUpdate}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Địa chỉ
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="Địa chỉ"
                                                    name="DiaChiKH"
                                                    value={DiaChiKH}
                                                    onChange={onChangeUpdate}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Button
                                            type="submit"
                                            variant="outline-success"
                                            className="fs-5 px-5">
                                            Lưu
                                        </Button>
                                    </Form>
                                </ListGroup.Item>
                            </ListGroup>
                        </Card.Body>
                    </Card>
                </Col>
            </Row>
        </Container>
    )
}

export default ThongTinKhachHang
