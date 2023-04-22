const {
    Router
} = require('express')
const CLIENT = require('../models/connector');
const router = Router()

router.get('/pvk', (req, res, next) => {
    res.status(200)

    CLIENT.query('select * from pvk').then(result => {
        res.render('pvk', {
            title: "ПВК | без CHATGPT",
            pvks: result.rows
        })
    });
})

router.get('/pvk2', (req, res, next) => {
    res.status(200)
    console.log(req)

    CLIENT.query('select * from pvk').then(result => {
        res.render('pvk2', {
            title: "ПВК | без CHATGPT",
            pvks: result.rows
        })
    });
})


router.get('/lab1', (req, res, next) => {
    res.status(200)
    res.render('lab1', {
        title: "Первая лаба | без CHATGPT",
    })
})

router.get('/lab2', (req, res, next) => {
    res.status(200)
    res.render('lab2', {
        title: "Пока что плейсхолдер | без CHATGPT",
    })
})

module.exports = router