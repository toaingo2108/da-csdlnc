import React from 'react'
import { Card, ListGroup } from 'react-bootstrap'

const QuaTangKemDon = ({ quaTang: { TenQT, Gia, LinkHinhAnh } }) => {
    return (
        <>
            <Card.Img
                variant="top"
                src={
                    LinkHinhAnh
                        ? LinkHinhAnh
                        : 'https://hyt.r.worldssl.net/hinh-hoa-tuoi/thumb/gau-bong/12522_teddy-ca-tinh-size-47.jpg'
                }
            />
            <ListGroup>
                <ListGroup.Item>
                    <Card.Body className="fs-5">
                        <span className="text-nowrap ms-0">{TenQT}</span>
                        <div className="text-danger fw-bold">{Gia} đ</div>
                    </Card.Body>
                </ListGroup.Item>
            </ListGroup>
        </>
    )
}

export default QuaTangKemDon
