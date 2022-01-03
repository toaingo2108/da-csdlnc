import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { ListGroup, Spinner } from 'react-bootstrap'
import { Link } from 'react-router-dom'
import { apiUrl } from '../../contexts/contants'

const MauSac = () => {
    const [DsMauSac, setDsMauSac] = useState([])

    const [loading, setLoading] = useState(true)

    const getDsMauSac = async () => {
        try {
            const response = await axios.get(`${apiUrl}/mau-sac`)
            if (response.data.success) {
                setDsMauSac(response.data.DsMauSac)
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

    useEffect(() => getDsMauSac(), [])

    let body = null

    if (loading) {
        body = (
            <div className="spinner-container">
                <Spinner animation="border" variant="info" />
            </div>
        )
    } else if (DsMauSac.length === 0) {
        body = (
            <>
                <h2>Danh sách màu sắc rỗng</h2>
            </>
        )
    } else {
        body = (
            <>
                <ListGroup>
                    {DsMauSac.map((mauSac) => (
                        <ListGroup.Item key={mauSac.MaMau}>
                            <Link to={`/mau-sac/${mauSac.MaMau}`}>
                                {mauSac.TenMau}
                            </Link>
                        </ListGroup.Item>
                    ))}
                </ListGroup>
            </>
        )
    }
    return <>{body}</>
}

export default MauSac
