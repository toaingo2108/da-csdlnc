const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

// router.get('/:MaKH', async (req, res) => {
//     const MaKH = req.params.MaKH
//     try {
//         let pool = await sql.connect(config)
//         const { recordset } = await pool
//             .request()
//             .query(`select * from KhachHang where MaKH = ${MaKH}`)
//         const khachHang = recordset[0]
//         if (!khachHang) {
//             return res
//                 .status(400)
//                 .json({ success: false, message: 'Không tìm thấy khách hàng' })
//         }
//         res.json({
//             success: true,
//             khachHang,
//         })
//     } catch (error) {
//         console.log(error)
//         res.status(500).json({
//             success: false,
//             message: 'Lỗi hệ thống',
//         })
//     }
// })
// @route POST api/auth/login
// @desc Login khách hàng
// @access Public
router.post('/login', async (req, res) => {
    const { EmailKH, MatKhauKH } = req.body

    // Simple validation
    if (!EmailKH || !MatKhauKH) {
        return res.status(400).json({
            success: false,
            message: 'Chưa điền đầy đủ thông tin',
        })
    }

    try {
        let pool = await sql.connect(config)
        const { recordset } = await pool
            .request()
            .input('EmailKH', sql.VarChar(30), EmailKH)
            .execute('usp_TimKhachHang_email')
        const khachHang = recordset[0]

        if (!khachHang) {
            return res.status(400).json({
                success: false,
                message: 'Email hoặc mật khẩu không chính xác',
            })
        }

        // Email found
        const passwordValid = khachHang.MatKhauKH === MatKhauKH

        if (!passwordValid) {
            return res.status(400).json({
                success: false,
                message: 'Email hoặc mật khẩu không chính xác',
            })
        }

        res.json({
            success: true,
            message: 'Successfully logged!',
            khachHang,
        })
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false,
            message: 'Internal server error',
        })
    }
})

module.exports = router
