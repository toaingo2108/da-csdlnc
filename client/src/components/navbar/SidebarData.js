import React from 'react'
import * as FaIcons from 'react-icons/fa'
import * as AiIcons from 'react-icons/ai'
import * as GiIcons from 'react-icons/gi'

export const SidebarData = [
    {
        title: 'Trang chủ',
        path: '/',
        icon: <AiIcons.AiOutlineHome />,
        cName: 'nav-text',
    },
    {
        title: 'Chủ đề',
        path: '/chu-de/1',
        icon: <FaIcons.FaAffiliatetheme />,
        cName: 'nav-text',
    },
    {
        title: 'Màu sắc',
        path: '/mau-sac/1',
        icon: <GiIcons.GiSpotedFlower />,
        cName: 'nav-text',
    },
    {
        title: 'Quà tặng kèm',
        path: '/qua-tang-kem',
        icon: <FaIcons.FaGifts />,
        cName: 'nav-text',
    },
    {
        title: 'Thêm sản phẩm',
        path: '/them-san-pham',
        icon: <GiIcons.GiCottonFlower />,
        cName: 'nav-text',
    },
    // {
    //     title: 'Kiểu dáng',
    //     path: '/kieu-dang',
    //     icon: <GiIcons.GiCottonFlower />,
    //     cName: 'nav-text',
    // },
    // {
    //     title: 'Hoa tươi',
    //     path: '/hoa-tuoi',
    //     icon: <GiIcons.GiFlowerPot />,
    //     cName: 'nav-text',
    // },

    // {
    //     title: 'Bộ sưu tập',
    //     path: '/bo-suu-tap',
    //     icon: <GiIcons.GiButterflyFlower />,
    //     cName: 'nav-text',
    // },

    // {
    //     title: 'Hoa cưới',
    //     path: '/hoa-cuoi',
    //     icon: <GiIcons.GiGraveFlowers />,
    //     cName: 'nav-text',
    // },
    // {
    //     title: 'Ý nghĩa hoa',
    //     path: '/y-nghia-hoa',
    //     icon: <GiIcons.GiFlowerEmblem />,
    //     cName: 'nav-text',
    // },
]
