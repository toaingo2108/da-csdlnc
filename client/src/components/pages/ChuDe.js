import React, { useEffect, useState } from 'react'
import { ListGroup, Spinner } from 'react-bootstrap'
import axios from 'axios'
import { apiUrl } from '../../contexts/contants'
import { Link } from 'react-router-dom'

const ChuDe = () => {
    const [DsChuDe, setDsChuDe] = useState([])

    const [loading, setLoading] = useState(true)

    const getDsChuDe = async () => {
        try {
            const response = await axios.get(`${apiUrl}/chu-de`)
            if (response.data.success) {
                setDsChuDe(response.data.DsChuDe)
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

    useEffect(() => getDsChuDe(), [])

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else if (DsChuDe.length === 0) {
        body = (
            <>
                <h2>Danh sách chủ đề rỗng</h2>
            </>
        )
    } else {
        body = (
            <>
                <ListGroup>
                    {DsChuDe.map((chuDe) => (
                        <ListGroup.Item key={chuDe.MaCDe}>
                            <Link to={`/chu-de/${chuDe.MaCDe}`}>
                                {chuDe.ChuDe}
                            </Link>
                        </ListGroup.Item>
                    ))}
                </ListGroup>
            </>
        )
    }
    return <>{body}</>
}

export default ChuDe
