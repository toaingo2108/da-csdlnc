import axios from 'axios'
import React, { useState } from 'react'
import {
    Button,
    Card,
    Col,
    Container,
    Form,
    ListGroup,
    Row,
} from 'react-bootstrap'
import { apiUrl } from '../../contexts/contants'

const ThemSanPham = () => {
    const [sanPham, setSanPham] = useState({
        TenSP: '',
        MaMau: '',
        MaLoaiHoa: '',
        MoTa: '',
        GiaTruocGiam: '',
        GiaSauGiam: '',
        LinkHinhAnh: '',
    })
    const {
        TenSP,
        MaMau,
        MaLoaiHoa,
        MoTa,
        GiaTruocGiam,
        GiaSauGiam,
        LinkHinhAnh,
    } = sanPham

    const onChangeForm = (event) => {
        setSanPham({
            ...sanPham,
            [event.target.name]: event.target.value,
        })
    }

    const themSanPham = async (sanPham) => {
        try {
            const response = await axios.post(
                `${apiUrl}/san-pham/them-san-pham`,
                sanPham
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
        const { success } = await themSanPham(sanPham)
        if (success) alert('Thêm sản phẩm thành công')
        setSanPham({
            TenSP: '',
            MaMau: '',
            MaLoaiHoa: '',
            MoTa: '',
            GiaTruocGiam: '',
            GiaSauGiam: '',
            LinkHinhAnh: '',
        })
    }

    return (
        <Container>
            <Row className="justify-content-md-center">
                <Col md="8">
                    <Card>
                        <Card.Body>
                            <ListGroup variant="flush">
                                <ListGroup.Item>
                                    <Card.Title>THÊM SẢN PHẨM MỚI</Card.Title>
                                </ListGroup.Item>
                                <ListGroup.Item>
                                    <Form onSubmit={handleSubmit}>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Tên sản phẩm
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="TenSP"
                                                    name="TenSP"
                                                    value={TenSP}
                                                    onChange={onChangeForm}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                mã màu
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="MaMau"
                                                    name="MaMau"
                                                    value={MaMau}
                                                    onChange={onChangeForm}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Mã loài hoa
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="MaLoaiHoa"
                                                    name="MaLoaiHoa"
                                                    value={MaLoaiHoa}
                                                    onChange={onChangeForm}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Mô tả
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    as="textarea"
                                                    type="text"
                                                    placeholder="MoTa"
                                                    name="MoTa"
                                                    value={MoTa}
                                                    onChange={onChangeForm}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Giá Trước Giảm
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="GiaTruocGiam"
                                                    name="GiaTruocGiam"
                                                    value={GiaTruocGiam}
                                                    onChange={onChangeForm}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Giá sau giảm
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="GiaSauGiam"
                                                    name="GiaSauGiam"
                                                    value={GiaSauGiam}
                                                    onChange={onChangeForm}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Form.Group as={Row} className="mb-3">
                                            <Form.Label column sm="3">
                                                Link hình ảnh
                                            </Form.Label>
                                            <Col sm="9">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="LinkHinhAnh"
                                                    name="LinkHinhAnh"
                                                    value={LinkHinhAnh}
                                                    onChange={onChangeForm}
                                                />
                                            </Col>
                                        </Form.Group>
                                        <Button
                                            type="submit"
                                            variant="outline-info"
                                            className="fs-5 px-5">
                                            THÊM
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

export default ThemSanPham
