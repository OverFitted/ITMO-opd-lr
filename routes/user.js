const User = require('../models/user');
const { Router } = require('express')
const CLIENT = require("../models/connector");
const router = Router()

router.get('/', (req, res, next) => {
    res.status(200)

    CLIENT.query('select * from pvk_lab1').then(pvk_lab1 => {
        CLIENT.query('select * from professions_lab1').then(profs => {
            CLIENT.query(`select * from expert_profession_quality_lab1 where expert_id = ${req.cookies.usr_id}`).then(result => {
                User.userById(req.cookies.usr_id).then((user) => {
                    let rows = result.rows;
                    let prof_rows = profs.rows;
                    for (let i = 0; i < prof_rows.length; i++) {
                        prof_rows[i]["pvks"] = rows.filter(x => x["profession_id"] === prof_rows[i]["id"]);
                        for (let j = 0; j < prof_rows[i]["pvks"].length; j++) {
                            prof_rows[i]["pvks"][j]["name"] = pvk_lab1.rows.find(x => x["id"] === prof_rows[i]["pvks"][j]["pvk_id"])["name"]
                        }
                    }

                    res.render('settings', {
                        title: "Вход | Без CHATGPT",
                        isLoggedIn: req.cookies.usr_id,
                        user: user,
                        rows: prof_rows
                    })
                })
            })
        })
    })
})

router.get('/logout/', (req, res, next) => {
    res.clearCookie("usr_id")
    res.status(200)
    res.redirect("/")
})

router.post("/change-data", (req, res, next) => {
    res.status(200)

    User.userById(req.cookies.usr_id).then((user) => {
        if (user) {
            user = new User(user)
            user.changeData(req.body).then((_) => {
                res.redirect("/user/")
            })
        }
    });
})

module.exports = router
