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

router.post('/pvk', (req, res, next) => {
    res.status(200)
    chosenPvks = Object.keys(req.body)
    chosenPvksIds = chosenPvks.map(obj => parseInt(obj));

    CLIENT.query(`select * from pvk where id in (${chosenPvksIds.toString()})`).then(result => {
        res.render('pvk2', {
            title: "ПВК | без CHATGPT",
            pvks: result.rows,
            chosenPvks: chosenPvks.join("-")
        })
    });
})


router.get('/lab1', (req, res, next) => {
    res.status(200)
    res.render('lab1', {
        title: "Первая лаба | без CHATGPT",
        experts: [
            { "name": "Ванька" },
            { "name": "Компас юзер" },
            { "name": "Кто-нибудь еще" }
        ]
    })
})

router.get('/lab1/res', (req, res, next) => {
    res.status(200)
    res.redirect("../lab1")
})

router.post('/lab1/res', (req, res, next) => {
    chosenPvks = req.query.pvks.split("-")
    chosenPvksIds = chosenPvks.map(obj => parseInt(obj));
    console.log(chosenPvksIds)

    res.status(200)
    res.render('lab1', {
        title: "Первая лаба | без CHATGPT",
        experts: [
            { "name": "Ванька" },
            { "name": "Компас юзер" },
            { "name": "Кто-нибудь еще" }
        ]
    })
})

router.get('/lab2', (req, res, next) => {
    res.status(200)
    res.render('lab2', {
        title: "Пока что плейсхолдер | без CHATGPT",
    })
})

module.exports = router
