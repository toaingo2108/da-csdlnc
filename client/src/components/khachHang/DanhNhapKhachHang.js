import React, { useContext, useEffect, useState } from 'react'
import { Button, Col, Container, Form, Row } from 'react-bootstrap'
import { AuthContext } from '../../contexts/AuthContext'
import { useNavigate } from 'react-router-dom'

const DangNhapKhachHang = () => {
    const { isAuthenticated, login } = useContext(AuthContext)

    const [validated, setValidated] = useState(false)

    const [formDangNhap, setFormDangNhap] = useState({
        EmailKH: '',
        MatKhauKH: '',
    })
    const { EmailKH, MatKhauKH } = formDangNhap

    let navigate = useNavigate()

    const onChangeForm = (event) =>
        setFormDangNhap({
            ...formDangNhap,
            [event.target.name]: event.target.value,
        })

    const handleSubmit = async (event) => {
        const form = event.currentTarget
        event.preventDefault()
        if (form.checkValidity() === false) {
            event.stopPropagation()
            setValidated(true)
        } else {
            const { message } = await login(formDangNhap)
            alert(message)
            setFormDangNhap({
                EmailKH: '',
                MatKhauKH: '',
            })
            setValidated(false)
        }
    }

    useEffect(() => {
        let isMounted = isAuthenticated
        if (isMounted) {
            navigate('/')
        }
        return () => {
            isMounted = false
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [isAuthenticated])

    return (
        <Container className="my-container my-5">
            <Form noValidate validated={validated} onSubmit={handleSubmit}>
                <Row className="d-flex flex-column align-items-md-center">
                    <Col md="4">
                        <Form.Group>
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
                            <Form.Control.Feedback>
                                Hợp lệ
                            </Form.Control.Feedback>
                        </Form.Group>
                    </Col>
                    <Col md="4" className="my-4">
                        <Form.Group>
                            <Form.Label>MatKhauKH</Form.Label>
                            <Form.Control
                                type="password"
                                placeholder="Nhập mật khẩu"
                                required
                                name="MatKhauKH"
                                value={MatKhauKH}
                                onChange={onChangeForm}
                            />
                            <Form.Control.Feedback>
                                Hợp lệ
                            </Form.Control.Feedback>
                        </Form.Group>
                    </Col>
                    <Col md="4">
                        <Button type="submit" className="fs-5">
                            Đăng nhập
                        </Button>
                    </Col>
                </Row>
            </Form>
        </Container>
    )
}

export default DangNhapKhachHang
