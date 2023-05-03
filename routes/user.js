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
                    var resp_res;
                    var resp_res_simple = [];
                    var resp_res_hard = [];
                    CLIENT.query(`SELECT lr2_to_resp.respondent_id,lr2_to_resp.expert_id,lr2_to_resp.test_id,results_list_lr2.result_list,test_name_lr2.test_name FROM lr2_to_resp JOIN results_list_lr2 ON lr2_to_resp.result_id_lr2 = results_list_lr2.id join test_name_lr2 ON lr2_to_resp.test_id = test_name_lr2.test_id;`).then((resp_res_raw) => {
                        let rows = result.rows;
                        let prof_rows = profs.rows;
                        for (let i = 0; i < prof_rows.length; i++) {
                            prof_rows[i]["pvks"] = rows.filter(x => x["profession_id"] === prof_rows[i]["id"]);
                            for (let j = 0; j < prof_rows[i]["pvks"].length; j++) {
                                prof_rows[i]["pvks"][j]["name"] = pvk_lab1.rows.find(x => x["id"] === prof_rows[i]["pvks"][j]["pvk_id"])["name"]
                            }
                        }

                        resp_res = resp_res_raw.rows;
                        for (let i = 0; i < resp_res.length; i++){
                            if (resp_res[i].result_list.length === 2){
                                resp_res[i].result_list = resp_res[i].result_list.join("; ")
                                resp_res_simple.push(resp_res[i])
                            } else {
                                resp_res[i].result_list = resp_res[i].result_list.join("; ")
                                resp_res_hard.push(resp_res[i])
                            }
                        }

                        res.render('settings', {
                            title: "Вход | Без CHATGPT",
                            isLoggedIn: req.cookies.usr_id,
                            user: user,
                            rows: prof_rows,
                            resp_res: resp_res,
                            resp_res_simple: resp_res_simple,
                            resp_res_hard: resp_res_hard
                        })
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
