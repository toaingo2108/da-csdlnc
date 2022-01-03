const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

router.get('/khach-hang/:MaKH', async (req, res) => {
    const MaKH = req.params.MaKH
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaKH', sql.Int, MaKH)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_XemDonHangCuaKhachHang')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            DsDonHang: recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/chi-tiet/:MaDH', async (req, res) => {
    const MaDH = req.params.MaDH
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaDH', sql.Int, MaDH)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_XemChiTietDonHang')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            DsSanPhamDonHang: recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.post('/tao-don-hang', async (req, res) => {
    const {
        SDT_NgNhan,
        HinhThucTT,
        TrangThaiDH,
        MaKH,
        MaQTang,
        MaCNhanh,
        MaKV,
    } = req.body
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('SDT_NgNhan', sql.Char(10), SDT_NgNhan)
            .input('HinhThucTT', sql.TinyInt, HinhThucTT)
            .input('TrangThaiDH', sql.TinyInt, TrangThaiDH)
            .input('MaKH', sql.Int, MaKH)
            .input('MaQTang', sql.Int, MaQTang)
            .input('MaCNhanh', sql.Int, MaCNhanh)
            .input('MaKV', sql.Int, MaKV)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_ThemDonHang')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            DonHang: recordset[0],
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.post('/them-chi-tiet', async (req, res) => {
    const { MaDH, MaSP, SoLuongDat } = req.body
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaDH', sql.Int, MaDH)
            .input('MaSP', sql.Int, MaSP)
            .input('SoLuongDat', sql.Int, SoLuongDat)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_ThemCTDonHang')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            chiTiet: recordset[0],
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.put('/cap-nhat-trang-thai', async (req, res) => {
    const { MaDH, TrangThaiDH } = req.body
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaDH', sql.Int, MaDH)
            .input('TrangThaiDH', sql.TinyInt, TrangThaiDH)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_ThayDoiTrangThaiDH')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            donHang: recordset[0],
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
