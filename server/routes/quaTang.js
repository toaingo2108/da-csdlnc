const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

router.get('/', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const response = await pool.request().query('select * from QuaTangKem')
        res.json({
            success: true,
            DsQuaTang: response.recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/:MaQTang', async (req, res) => {
    const MaQTang = req.params.MaQTang
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query(`select * from QuaTangKem where MaQTang = ${MaQTang}`)
        res.json({
            success: true,
            quaTang: response.recordset[0],
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
