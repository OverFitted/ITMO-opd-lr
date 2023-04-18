const { Router } = require('express')
const router = Router()

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
