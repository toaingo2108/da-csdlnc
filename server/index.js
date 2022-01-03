const express = require('express')
const cors = require('cors')
const app = express()

const testRouter = require('./routes/test')
const authRouter = require('./routes/auth')
const sanPhamRouter = require('./routes/sanPham')
const chuDeRouter = require('./routes/chuDe')
const khachHangRouter = require('./routes/khachHang')
const mauSacRouter = require('./routes/mauSac')
const donHangRouter = require('./routes/donHang')
const quaTangRouter = require('./routes/quaTang')
const khuVucRouter = require('./routes/khuVuc')

app.use(express.json())
app.use(cors())

app.use('/api', testRouter)
app.use('/api/auth', authRouter)
app.use('/api/san-pham', sanPhamRouter)
app.use('/api/chu-de', chuDeRouter)
app.use('/api/khach-hang', khachHangRouter)
app.use('/api/mau-sac', mauSacRouter)
app.use('/api/don-hang', donHangRouter)
app.use('/api/qua-tang', quaTangRouter)
app.use('/api/khu-vuc', khuVucRouter)

const PORT = process.env.PORT || 5000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
