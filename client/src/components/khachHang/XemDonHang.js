import React, { useContext } from 'react'
import { Col, Container, Row } from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'
import { AuthContext } from '../../contexts/AuthContext'
import DonHang from '../donHang/DonHang'

const XemDonHang = () => {
    const { isAuthenticated } = useContext(AuthContext)

    let navigate = useNavigate()

    if (!isAuthenticated) {
        navigate('/')
    }

    return (
        <Container className="my-container">
            <Row>
                <Col>
                    <DonHang />
                </Col>
            </Row>
        </Container>
    )
}

export default XemDonHang
