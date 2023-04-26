const {
    Router
} = require('express')
const CLIENT = require('../models/connector');
const router = Router()

router.get('/lab1', (req, res, next) => {
    res.status(200)

    CLIENT.query('select * from professions_lab1').then((profs) => {
        CLIENT.query(`select * from users where is_expert='t'`).then(result => {
            res.render('lab1', {
                title: "Первая лаба | без CHATGPT",
                experts: result.rows,
                profs: profs.rows,
                isLoggedIn: req.cookies.usr_id
            })
        })
    })
})

router.post('/lab1', (req, res, next) => {
    res.status(200)
    var selectedLanguage = req.body.selectedLanguage
    res.redirect(`/labs/pvk?selectedLanguage=${selectedLanguage}`)
})

router.get('/pvk', (req, res, next) => {
    res.status(200)

    var selectedLanguage = req.query.selectedLanguage

    CLIENT.query('select * from pvk_lab1').then(result => {
        res.render('pvk', {
            title: "ПВК | без CHATGPT",
            pvks: result.rows,
            isLoggedIn: req.cookies.usr_id,
            selectedLanguage: selectedLanguage
        })
    });
})

router.post('/pvk', (req, res, next) => {
    res.status(200)

    var selectedLanguage = req.body.selectedLanguage
    delete req.body.selectedLanguage;

    chosenPvks = Object.keys(req.body)
    chosenPvksIds = chosenPvks.map(obj => parseInt(obj));

    CLIENT.query(`select * from pvk_lab1 where id in (${chosenPvksIds.toString()})`).then(result => {
        res.redirect(`/labs/pvk2?chosenPvks=${chosenPvks.join("-")}&selectedLanguage=${selectedLanguage}`)
    });
})

router.get('/pvk2', (req, res, next) => {
    res.status(200)

    var chosenPvks = req.query.chosenPvks.split("-")
    var selectedLanguage = parseInt(req.query.selectedLanguage)
    chosenPvksIds = chosenPvks.map(obj => parseInt(obj));

    CLIENT.query(`select * from pvk_lab1 where id in (${chosenPvksIds.toString()})`).then(result => {
        res.render('pvk2', {
            title: "ПВК | без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            pvks: result.rows,
            selectedLanguage: selectedLanguage
        })
    });
})

router.post('/pvk2', (req, res, next) => {
    res.status(200)

    var expert_id = req.cookies.usr_id;
    var selectedLanguage = req.body.selectedLanguage
    delete req.body.selectedLanguage;

    chosenPvks = Object.keys(req.body)
    pvkValues = Object.values(req.body)
    chosenPvksIds = chosenPvks.map(obj => parseInt(obj));

    if (req.cookies.usr_id) {
        chosenPvksIds.forEach(pvk => {
            const query = {
                text: 'INSERT INTO expert_profession_quality_lab1 (expert_id, profession_id, pvk_id, importance) VALUES ($1, $2, $3, $4)',
                values: [expert_id, selectedLanguage, pvk, req.body[pvk.toString()]],
            }

            CLIENT.query(query).then((res) => {
                return res
            })
        });
    }

    res.redirect(`/labs/lab1/res?chosenPvksIds=${chosenPvksIds.join("-")}&selectedLanguage=${selectedLanguage}&pvkValues=${pvkValues.join("-")}`)
})

router.get('/lab1/res', (req, res, next) => {
    res.status(200)
    const pvkValues = req.query.pvkValues.split("-")
    const chosenPvksIds = req.query.chosenPvksIds.split("-")
    const selectedLanguage = req.query.selectedLanguage

    CLIENT.query('select * from professions_lab1').then((profs) => {
        CLIENT.query(`select * from pvk_lab1`).then((result) => {
            let pvks = []
            for (let i = 0; i < chosenPvksIds.length; i++) {
                const cur = result.rows.find(x => x.id === parseInt(chosenPvksIds[i]));

                pvks.push({
                    cur: cur,
                    value: pvkValues[i]
                })
            }

            if (!((!pvkValues) || (!chosenPvksIds) || (!selectedLanguage))) {
                res.render('lab1', {
                    title: "Лаба 1 | без CHATGPT",
                    isLoggedIn: req.cookies.usr_id,
                    pvks: pvks,
                    profs: profs.rows,
                    selectedLanguage: selectedLanguage
                })
            } else {
                res.redirect("/labs/lab1")
            }
        })
    })
})

router.get('/lab2', (req, res, next) => {
    res.status(200)
    res.render('lab2', {
        title: "Пока что плейсхолдер | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

module.exports = router