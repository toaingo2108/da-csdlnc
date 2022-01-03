const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

router.post('/', async (req, res) => {
    const { HoKH, TenKH, SDT_KH, EmailKH, MatKhauKH, DiaChiKH } = req.body
    try {
        let pool = await sql.connect(config)
        const { output, recordset } = await pool
            .request()
            .input('HoKH', sql.NVarChar(30), HoKH)
            .input('TenKH', sql.NVarChar(30), TenKH)
            .input('SDT_KH', sql.NVarChar(30), SDT_KH)
            .input('EmailKH', sql.NVarChar(30), EmailKH)
            .input('MatKhauKH', sql.NVarChar(30), MatKhauKH)
            .input('DiaChiKH', sql.NVarChar(30), DiaChiKH)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_THEMKHACHHANG')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            khachHang: recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.put('/sua-thong-tin', async (req, res) => {
    const { MaKH, HoKH, TenKH, SDT_KH, EmailKH, DiaChiKH } = req.body
    try {
        let pool = await sql.connect(config)
        const { output, recordset } = await pool
            .request()
            .input('MaKH', sql.Int, MaKH)
            .input('HoKH', sql.NVarChar(30), HoKH)
            .input('TenKH', sql.NVarChar(30), TenKH)
            .input('SDT_KH', sql.NVarChar(30), SDT_KH)
            .input('EmailKH', sql.NVarChar(30), EmailKH)
            .input('DiaChiKH', sql.NVarChar(30), DiaChiKH)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('uspSUAKHACHHANG')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            khachHang: recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.put('/doi-mat-khau', async (req, res) => {
    const { MaKH, MatKhauCu, MatKhauMoi } = req.body
    try {
        let pool = await sql.connect(config)
        const { output, recordset } = await pool
            .request()
            .input('MaKH', sql.Int, MaKH)
            .input('MatKhauCu', sql.NVarChar(20), MatKhauCu)
            .input('MatKhauMoi', sql.NVarChar(20), MatKhauMoi)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_DoiMatKhauKhachHang')
        console.log(recordset)
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            khachHang: recordset,
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
