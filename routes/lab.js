const { Router } = require('express')
const router = Router()

router.get('lab1', (req, res, next) => {
    res.status(200)
    res.render('lab', {
        title: "Lab page",
        isHome: true
    })
})

module.exports = router
