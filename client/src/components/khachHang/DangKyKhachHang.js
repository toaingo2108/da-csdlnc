import React, { useState } from 'react'
import { Button, Col, Container, Form, InputGroup, Row } from 'react-bootstrap'
import axios from 'axios'
import { apiUrl } from '../../contexts/contants'

const DangKyKhachHang = () => {
    const [validated, setValidated] = useState(false)

    const [formDangKy, setFormDangKy] = useState({
        HoKH: '',
        TenKH: '',
        SDT_KH: '',
        EmailKH: '',
        MatKhauKH: '',
        DiaChiKH: '',
    })
    const { HoKH, TenKH, SDT_KH, EmailKH, MatKhauKH, DiaChiKH } = formDangKy

    const dangKyKhachHang = async (formDangKy) => {
        try {
            const response = await axios.post(
                `${apiUrl}/khach-hang`,
                formDangKy
            )
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    const onChangeForm = (event) =>
        setFormDangKy({
            ...formDangKy,
            [event.target.name]: event.target.value,
        })

    const handleSubmit = async (event) => {
        const form = event.currentTarget
        event.preventDefault()
        if (form.checkValidity() === false) {
            event.stopPropagation()
            setValidated(true)
        } else {
            const { success } = await dangKyKhachHang(formDangKy)
            if (success) alert('Đăng ký thành công')
            setFormDangKy({
                HoKH: '',
                TenKH: '',
                SDT_KH: '',
                EmailKH: '',
                MatKhauKH: '',
                DiaChiKH: '',
            })
            setValidated(false)
        }
    }

    return (
        <Container className="my-5">
            <Form noValidate validated={validated} onSubmit={handleSubmit}>
                <Row className="mb-3">
                    <Form.Group as={Col} md="4">
                        <Form.Label>Họ</Form.Label>
                        <Form.Control
                            required
                            type="text"
                            name="HoKH"
                            placeholder="Nhập họ"
                            value={HoKH}
                            onChange={onChangeForm}
                        />
                        <Form.Control.Feedback>Hợp lệ</Form.Control.Feedback>
                    </Form.Group>
                    <Form.Group as={Col} md="4">
                        <Form.Label>Tên</Form.Label>
                        <Form.Control
                            required
                            type="text"
                            placeholder="Nhập tên"
                            name="TenKH"
                            value={TenKH}
                            onChange={onChangeForm}
                        />
                        <Form.Control.Feedback>Hợp lệ</Form.Control.Feedback>
                    </Form.Group>
                    <Form.Group as={Col} md="4">
                        <Form.Label>Số điện thoại</Form.Label>
                        <InputGroup hasValidation>
                            <Form.Control
                                type="text"
                                placeholder="Nhập số điện thoại"
                                required
                                name="SDT_KH"
                                value={SDT_KH}
                                onChange={onChangeForm}
                            />

                            <Form.Control.Feedback>
                                Hợp lệ
                            </Form.Control.Feedback>
                        </InputGroup>
                    </Form.Group>
                </Row>
                <Row className="mb-3">
                    <Form.Group as={Col} md="6">
                        <Form.Label>Email</Form.Label>
                        <Form.Control
                            type="email"
                            placeholder="Nhập email"
                            required
                            name="EmailKH"
                            value={EmailKH}
                            onChange={onChangeForm}
                        />
                        <Form.Control.Feedback type="invalid">
                            Email không hợp lệ
                        </Form.Control.Feedback>
                        <Form.Control.Feedback>Hợp lệ</Form.Control.Feedback>
                    </Form.Group>
                    <Form.Group as={Col} md="3">
                        <Form.Label>MatKhauKH</Form.Label>
                        <Form.Control
                            type="password"
                            placeholder="Nhập mật khẩu"
                            required
                            name="MatKhauKH"
                            value={MatKhauKH}
                            onChange={onChangeForm}
                        />
                        <Form.Control.Feedback>Hợp lệ</Form.Control.Feedback>
                    </Form.Group>
                    <Form.Group as={Col} md="3">
                        <Form.Label>DiaChiKH</Form.Label>
                        <Form.Control
                            type="text"
                            placeholder="Nhập địa chỉ"
                            required
                            name="DiaChiKH"
                            value={DiaChiKH}
                            onChange={onChangeForm}
                        />
                        <Form.Control.Feedback>Hợp lệ</Form.Control.Feedback>
                    </Form.Group>
                </Row>
                <Form.Group className="mb-3">
                    <Form.Check
                        required
                        label="Đồng ý với điều khoản và điều kiện."
                        // feedback=""
                        feedbackType="invalid"
                    />
                </Form.Group>
                <Button type="submit" className="fs-4 px-5">
                    Đăng ký
                </Button>
            </Form>
        </Container>
    )
}

export default DangKyKhachHang
