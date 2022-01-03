import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { apiUrl } from '../../contexts/contants'
import { Card, Col, Container, Row, Spinner } from 'react-bootstrap'
import QuaTangKemDon from './QuaTangKemDon'

const QuaTangKem = () => {
    const [DsQuaTang, setDsQuaTang] = useState([])

    const [loading, setLoading] = useState(true)

    const getDsQuaTang = async () => {
        try {
            const response = await axios.get(`${apiUrl}/qua-tang`)
            if (response.data.success) {
                setDsQuaTang(response.data.DsQuaTang)
                setLoading(false)
            }
            return response.data
        } catch (error) {
            console.log(error.message)
            return error.response.data
                ? error.response.data
                : { success: false, message: 'Lỗi hệ thống' }
        }
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
    useEffect(() => getDsQuaTang(), [])

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else if (DsQuaTang.length === 0) {
        body = (
            <>
                <h2>Không có quà tặng kèm nào</h2>
            </>
        )
    } else {
        body = (
            <>
                <Row>
                    <h2>Có {DsQuaTang.length} quà tặng</h2>
                    {DsQuaTang.map((quaTang) => (
                        <Col key={quaTang.MaQTang} xs={3} className="my-2">
                            <Card className="hover-item-2">
                                <QuaTangKemDon quaTang={quaTang} />
                            </Card>
                        </Col>
                    ))}
                </Row>
            </>
        )
    }

    return <Container className="my-container">{body}</Container>
}

export default QuaTangKem
