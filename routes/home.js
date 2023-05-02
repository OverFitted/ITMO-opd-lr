const User = require('../models/user');
const { Router } = require('express')
const router = Router()

router.get('', (req, res, next) => {
    res.status(200)
    res.render('index', {
        title: "Без CHATGPT",
        isLoggedIn: req.cookies.usr_id
    })
})

router.get('/login', (req, res, next) => {
    res.status(200)
    res.render('login', {
        title: "Вход | Без CHATGPT",
        isLoggedIn: req.cookies.usr_id
    })
})

router.post('/login/reg', (req, res, next) => {
    res.status(200)

    var user = new User(req.body);

    expDate = new Date('December 1, 2030 00:00:00');
    res.cookie('usr_id', user.usr_id, {
        expires: expDate,
        httpOnly: false,
        secure: true,
        overwrite: true
    });

    user.saveToSQL().then(() => {
        res.redirect('/', 200, {
            title: "Без CHATGPT",
            isLoggedIn: true
        })
    });
})

router.post('/login/login', (req, res, next) => {
    res.status(200)

    User.userByLogin(req.body.login, req.body.password).then((user) => {
        if (user){
            expDate = new Date('December 1, 2030 00:00:00');
            res.cookie('usr_id', user.usr_id, {
                expires: expDate,
                httpOnly: false,
                secure: true,
                overwrite: true
        });

        res.redirect('/', 200, {
            title: "Без CHATGPT",
            isLoggedIn: true
        })} else {
            res.redirect('/login/', 200, {
                title: "Без CHATGPT",
                isLoggedIn: false
            })
        }
    });
})

module.exports = router
