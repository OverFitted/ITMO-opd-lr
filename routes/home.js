const { Router } = require('express')
const router = Router()

router.get('', (req, res, next) => {
    res.status(200)
    res.render('index', {
        title: "Без CHATGPT",
        isHome: true
    })
})

module.exports = router
