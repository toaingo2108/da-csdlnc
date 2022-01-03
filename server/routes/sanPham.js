const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

router.get('/', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query('select * from SanPham where TrangThaiHD = 1')
        res.json({
            success: true,
            DsSanPham: response.recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/chi-tiet/:MaSP', async (req, res) => {
    const MaSP = req.params.MaSP
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query(`select * from SanPham where MaSP = ${MaSP}`)
        res.json({
            success: true,
            sanPham: response.recordset[0],
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/tim-san-pham/:CHUOICANTIM', async (req, res) => {
    const CHUOICANTIM = req.params.CHUOICANTIM
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .input('CHUOICANTIM', sql.NVarChar(50), CHUOICANTIM)
            .execute('usp_TIMSANPHAM')
        res.json({
            success: true,
            DsSanPham: response.recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/chu-de/:MaCDe', async (req, res) => {
    const MaCDe = req.params.MaCDe
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query(
                `select sp.* from SP_CD spcd, SanPham sp where spcd.MaCDE = ${MaCDe} and spcd.MaSP = sp.MaSP and sp.TrangThaiHD = 1`
            )
        res.json({
            success: true,
            DsSanPhamCD: response.recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/mau-sac/:MaMau', async (req, res) => {
    const MaMau = req.params.MaMau
    try {
        let pool = await sql.connect(config)
        const response = await pool
            .request()
            .query(
                ` select * from SanPham where MaMau = ${MaMau} and TrangThaiHD = 1`
            )
        res.json({
            success: true,
            DsSanPhamMS: response.recordset,
        })
    } catch (error) {
        console.log(error.message)
        res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.post('/them-san-pham', async (req, res) => {
    const {
        TenSP,
        MaMau,
        MaLoaiHoa,
        MoTa,
        GiaTruocGiam,
        GiaSauGiam,
        LinkHinhAnh,
    } = req.body

    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('TenSP', sql.NVarChar(50), TenSP)
            .input('MaMau', sql.TinyInt, MaMau)
            .input('MaLoaiHoa', sql.SmallInt, MaLoaiHoa)
            .input('MoTa', sql.NVarChar(1500), MoTa)
            .input('GiaTruocGiam', sql.Int, GiaTruocGiam)
            .input('GiaSauGiam', sql.Int, GiaSauGiam)
            .input('LinkHinhAnh', sql.VarChar(500), LinkHinhAnh)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_ThemSanPham')

        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            sanPham: recordset,
        })
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

module.exports = router
