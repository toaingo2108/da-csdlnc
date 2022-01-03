const SortGiaSauGiam = {
    thapCao: {
        class: 'sort-up',
        fn: (a, b) => a.GiaSauGiam - b.GiaSauGiam,
    },
    caoThap: {
        class: 'sort-down',
        fn: (a, b) => b.GiaSauGiam - a.GiaSauGiam,
    },
}

export default SortGiaSauGiam
