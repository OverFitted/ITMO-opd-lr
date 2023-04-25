const { Router } = require('express')
const router = Router()

router.get('', (req, res, next) => {
    res.status(200)
    res.render('admin', {
        title: "Admin page",
        isLoggedIn: req.cookies.usr_id
    })
})

module.exports = router
