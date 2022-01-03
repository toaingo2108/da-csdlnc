import React, { createContext, useState } from 'react'
import axios from 'axios'
import { apiUrl } from './contants'

const AuthContext = createContext()

const AuthContextProvider = ({ children }) => {
    const [authLoading, setAuthLoading] = useState(true)
    const [isAuthenticated, setIsAuthenticated] = useState(false)
    const [khachHang, setKhachHang] = useState({})
    const [gioHang, setGioHang] = useState([])

    // Login
    const login = async (loginForm) => {
        try {
            const response = await axios.post(`${apiUrl}/auth/login`, loginForm)
            if (response.data.success) {
                localStorage.setItem('token', response.data.message)
                setAuthLoading(false)
                setIsAuthenticated(true)
                setKhachHang(response.data.khachHang)
            }

            return response.data
        } catch (error) {
            if (error.response.data) {
                return error.response.data
            } else {
                return {
                    success: false,
                    message: error.message,
                }
            }
        }
    }

    // Logout
    const logout = () => {
        localStorage.removeItem('token')
        setAuthLoading(false)
        setIsAuthenticated(false)
        setKhachHang({})
        setGioHang([])
    }

    // Context data
    const authContextData = {
        login,
        logout,
        authLoading,
        isAuthenticated,
        khachHang,
        gioHang,
        setKhachHang,
        setIsAuthenticated,
        setAuthLoading,
        setGioHang,
    }

    // return provider
    return (
        <AuthContext.Provider value={authContextData}>
            {children}
        </AuthContext.Provider>
    )
}

export { AuthContext }
export default AuthContextProvider
