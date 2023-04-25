const { Router } = require('express')
const router = Router()

router.get('', (req, res, next) => {
    res.status(200)
    res.render('admin', {
        title: "Admin page",
        isHome: true
    })
})

module.exports = router
