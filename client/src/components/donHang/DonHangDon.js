import React from 'react'
import { Badge, Card, Col, ListGroup } from 'react-bootstrap'

const DonHangDon = ({
    donHang: {
        // MaDH,
        // MaKH
        TongTienSP,
        PhiGiaoHang,
        NgayLap,
        SDT_NgNhan,
        TongTienDH,
        // MaQTang,
        // HinhThucTT,
        // MaCNhanh,
        // MaKV,
        TrangThaiDH,
    },
}) => {
    NgayLap = new Date(NgayLap)
    const day = NgayLap.getDate()
    const month = NgayLap.getMonth() + 1
    const year = NgayLap.getFullYear()

    return (
        <>
            <Col xs={4}>
                <Card>
                    <ListGroup variant="flush">
                        <ListGroup.Item className="d-flex justify-content-between">
                            <div>Trạng thái:</div>
                            <Badge
                                className="fw-bold"
                                bg={
                                    TrangThaiDH === 0
                                        ? 'warning'
                                        : TrangThaiDH === 1
                                        ? 'success'
                                        : TrangThaiDH === 2
                                        ? 'secondary'
                                        : 'danger'
                                }>
                                {TrangThaiDH === 0
                                    ? 'Chưa Giao'
                                    : TrangThaiDH === 1
                                    ? 'Đã Giao'
                                    : TrangThaiDH === 2
                                    ? 'Chưa hoàn thành'
                                    : 'Đã Hủy'}
                            </Badge>
                        </ListGroup.Item>
                        <ListGroup.Item className="d-flex justify-content-between">
                            <div>Ngày lập:</div>
                            <div>{`${day} / ${month} / ${year}`}</div>
                        </ListGroup.Item>
                        <ListGroup.Item className="d-flex justify-content-between">
                            <div>Liên lạc:</div>
                            <div>{SDT_NgNhan}</div>
                        </ListGroup.Item>
                        <ListGroup.Item className="d-flex justify-content-between">
                            <div>Phí sản phẩm:</div>
                            <div>{TongTienSP} đ</div>
                        </ListGroup.Item>
                        <ListGroup.Item className="d-flex justify-content-between">
                            <div>Phí giao hàng:</div>
                            <div>{PhiGiaoHang} đ</div>
                        </ListGroup.Item>
                        <ListGroup.Item className="d-flex justify-content-between text-danger fw-bold fs-5">
                            <div>Tổng tiền:</div>
                            <div>{TongTienDH} đ</div>
                        </ListGroup.Item>
                    </ListGroup>
                </Card>
            </Col>
        </>
    )
}

export default DonHangDon
