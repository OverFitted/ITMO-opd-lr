const { Router } = require('express')
const router = Router()

router.get('', (req, res, next) => {
    res.status(200)
    res.render('contact', {
        title: "Связь с нами | без CHATGPT",
        isLoggedIn: req.cookies.usr_id
    })
})

module.exports = router
