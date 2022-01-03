const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

router.get('/', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const response = await pool.request().query('select * from ChuDe')
        res.json({
            success: true,
            DsChuDe: response.recordset,
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
