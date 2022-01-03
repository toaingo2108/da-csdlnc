import axios from 'axios'
import React, { useContext, useState } from 'react'
import { Button, Col, Container, Form, Row } from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'
import { AuthContext } from '../../contexts/AuthContext'
import { apiUrl } from '../../contexts/contants'

const DoiMatKhauKhachHang = () => {
    const { khachHang, setKhachHang, isAuthenticated, logout } =
        useContext(AuthContext)

    let navigate = useNavigate()

    const [updatedKhachHang, setUpdatedKhachHang] = useState({
        MaKH: khachHang.MaKH,
        MatKhauCu: '',
        MatKhauMoi: '',
    })
    const { MatKhauCu, MatKhauMoi } = updatedKhachHang

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
                `${apiUrl}/khach-hang/doi-mat-khau`,
                updatedKhachHang
            )
            if (response.data.success) {
                setKhachHang(response.data.khachHang)
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
        if (success) {
            alert('Đổi mật khẩu thành công')
            await logout()
        }
    }

    return (
        <Container>
            <Form onSubmit={handleSubmit}>
                <Row className="d-flex flex-column align-items-md-center">
                    <Col md="4" className="my-4">
                        <Form.Group>
                            <Form.Label>Mật khẩu cũ</Form.Label>
                            <Form.Control
                                type="password"
                                placeholder="Nhập mật khẩu cũ"
                                required
                                name="MatKhauCu"
                                value={MatKhauCu}
                                onChange={onChangeUpdate}
                            />
                            <Form.Control.Feedback>
                                Hợp lệ
                            </Form.Control.Feedback>
                        </Form.Group>
                    </Col>
                    <Col md="4">
                        <Form.Group>
                            <Form.Label>Mật khẩu mới</Form.Label>
                            <Form.Control
                                type="password"
                                placeholder="Nhập mật khẩu mới"
                                required
                                name="MatKhauMoi"
                                value={MatKhauMoi}
                                onChange={onChangeUpdate}
                            />
                            <Form.Control.Feedback>
                                Hợp lệ
                            </Form.Control.Feedback>
                        </Form.Group>
                    </Col>
                    <Col md="4">
                        <Button type="submit" className="fs-5 my-4">
                            Cập nhật
                        </Button>
                    </Col>
                </Row>
            </Form>
        </Container>
    )
}

export default DoiMatKhauKhachHang
