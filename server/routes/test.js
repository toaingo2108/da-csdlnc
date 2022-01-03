const express = require('express')
const router = express.Router()
const sql = require('mssql')
const config = require('../config')

// router.get('/:id', async (req, res) => {
//     const id = req.params.id
//     try {
//         let pool = await sql.connect(config)
//         const { recordset, output } = await pool
//             .request()
//             .input('ID', sql.Int, id)
//             .output('Error', sql.NVarChar(sql.MAX))
//             .execute('mtb_SampleExceptionHndling')

//         if (output.Error) {
//             return res.json({
//                 success: false,
//                 message: output.Error,
//             })
//         }
//         res.json({
//             success: true,
//             result: recordset,
//         })
//     } catch (err) {
//         console.log(err.message)
//     }
// })

router.delete('/xoa-san-pham/:MaSP', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaSP', sql.Int, req.params.MaSP)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_XoaSanPham')
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

router.get('/tim-san-pham/:MaSP', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaSP', sql.Int, req.params.MaSP)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_TimMotSanPham')
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

router.put('/sua-san-pham', async (req, res) => {
    const {
        MaSP,
        TenSP,
        MaMau,
        MaLoaiHoa,
        TenLoaiHoa,
        MoTa,
        TrangThaiHD,
        GiaTruocGiam,
        GiaSauGiam,
        LinkHinhAnh,
    } = req.body

    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaSP', sql.Int, MaSP)
            .input('TenSP', sql.NVarChar(50), TenSP)
            .input('MaMau', sql.TinyInt, MaMau)
            .input('MaLoaiHoa', sql.SmallInt, MaLoaiHoa)
            .input('TenLoaiHoa', sql.NVarChar(30), TenLoaiHoa)
            .input('MoTa', sql.NVarChar(1500), MoTa)
            .input('TrangThaiHD', sql.Bit, TrangThaiHD)
            .input('GiaTruocGiam', sql.Int, GiaTruocGiam)
            .input('GiaSauGiam', sql.Int, GiaSauGiam)
            .input('LinkHinhAnh', sql.VarChar(500), LinkHinhAnh)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_CapNhatSanPham')

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

router.get('/theo-doi-ton-kho', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_TheoDoiTonKho')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            DsSanPham: recordset,
        })
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.get('/theo-doi-don-nhap', async (req, res) => {
    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_TheoDoiDonNhap')
        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            DsDonNhap: recordset,
        })
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({
            success: false,
            message: 'Lỗi hệ thống',
        })
    }
})

router.post('/luu-vet-gia-san-pham', async (req, res) => {
    const { MaSP, GiaTruocGiam, GiaSauGiam, NgayApDung } = req.body

    try {
        let pool = await sql.connect(config)
        const { recordset, output } = await pool
            .request()
            .input('MaSP', sql.Int, MaSP)
            .input('GiaTruocGiam', sql.Int, GiaTruocGiam)
            .input('GiaSauGiam', sql.Int, GiaSauGiam)
            .input('NgayApDung', sql.DateTime, NgayApDung)
            .output('error', sql.NVarChar(sql.MAX))
            .execute('usp_LuuVetGiaSanPham')

        if (output.error) {
            return res.status(400).json({
                success: false,
                message: output.error,
            })
        }
        res.json({
            success: true,
            vetGiaSP: recordset,
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
