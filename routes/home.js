const { Router } = require('express')
const router = Router()

router.get('', (req, res, next) => {
    res.status(200)
    res.render('index', {
        title: "Без CHATGPT",
        isHome: true
    })
})

router.get('/login', (req, res, next) => {
    res.status(200)
    res.render('login', {
        title: "Вход | Без CHATGPT",
        isHome: true
    })
})

router.post('/login', (req, res, next) => {
    res.status(200)

    console.log(req.body);

    res.render('login', {
        title: "Вход | Без CHATGPT",
        isHome: true
    })
})

module.exports = router
