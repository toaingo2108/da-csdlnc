const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

router.get('/ten-tinh', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query('select distinct(TenTinh) from KhuVuc')
        res.json({
            success: true,
            DsTenTinh: response.recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/ten-quan-huyen/:TenTinh', async (req, res) => {
    const TenTinh = req.params.TenTinh
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query(
                `select Ten_QHuyen from KhuVuc where TenTinh = N'${TenTinh}'`
            )
        res.json({
            success: true,
            DsTen_QHuyen: response.recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.post('/xuat-khu-vuc', async (req, res) => {
    const { tenTinh, ten_QHuyen } = req.body
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query(
                `select * from KhuVuc where TenTinh = N'${tenTinh}' and Ten_QHuyen = N'${ten_QHuyen}'`
            )
        res.json({
            success: true,
            khuVuc: response.recordset[0],
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

module.exports = router
