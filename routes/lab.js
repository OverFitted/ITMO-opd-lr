const User = require('../models/user');
const {
    Router
} = require('express')
const CLIENT = require('../models/connector');
const router = Router()
const fs = require('fs');

const raven_answers = fs.readFileSync('./public/raven_answers.json', 'utf8');

router.get('/lab1', async (req, res, next) => {
    res.status(200)

    top_table_query = "WITH ranked_pvk AS (SELECT profession_id, pvk_id, ROW_NUMBER() OVER (PARTITION BY profession_id ORDER BY COUNT(*) DESC) AS rank FROM expert_profession_quality_lab1 GROUP BY profession_id, pvk_id) SELECT rp.profession_id, p.name, rp.pvk_id, pv.name FROM ranked_pvk AS rp JOIN professions_lab1 AS p ON rp.profession_id = p.id JOIN pvk_lab1 AS pv ON rp.pvk_id = pv.id WHERE rp.rank <= 5 ORDER BY rp.profession_id, rp.rank;"

    top_table = await CLIENT.query(top_table_query)
    profs = await CLIENT.query('select * from professions_lab1')
    experts = await CLIENT.query(`select * from users where is_expert='t'`)

    for (let i = 0; i < profs.rows.length; i++) {
        profs.rows[i]["top_table"] = top_table.rows.filter(x => x.profession_id === profs.rows[i].id)
    }

    res.render('lab1', {
        title: "Лаба 1 | без CHATGPT",
        experts: experts.rows,
        isLoggedIn: req.cookies.usr_id,
        profs: profs.rows,
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

router.get('/lab1/res', async (req, res, next) => {
    try {
        const { pvkValues, chosenPvksIds, selectedLanguage } = req.query;
        if (!pvkValues || !chosenPvksIds || !selectedLanguage) {
            return res.redirect("/labs/lab1");
        }

        const pvkValueArray = pvkValues.split("-");
        const chosenPvksIdArray = chosenPvksIds.split("-");

        const topTableQuery = `
            WITH ranked_pvk AS (
                SELECT profession_id, pvk_id, ROW_NUMBER() OVER (PARTITION BY profession_id ORDER BY COUNT(*) DESC) AS rank 
                FROM expert_profession_quality_lab1
                GROUP BY profession_id, pvk_id
            )
            SELECT rp.profession_id, p.name, rp.pvk_id, pv.name
            FROM ranked_pvk AS rp
            JOIN professions_lab1 AS p ON rp.profession_id = p.id
            JOIN pvk_lab1 AS pv ON rp.pvk_id = pv.id
            WHERE rp.rank <= 5
            ORDER BY rp.profession_id, rp.rank;
        `;

        const [topTable, profs, result, experts] = await Promise.all([
            CLIENT.query(topTableQuery),
            CLIENT.query('SELECT * FROM professions_lab1'),
            CLIENT.query('SELECT * FROM pvk_lab1'),
            CLIENT.query(`SELECT * FROM users WHERE is_expert='t'`)
        ]);

        const pvks = chosenPvksIdArray.map((id, i) => {
            const cur = result.rows.find(x => x.id === parseInt(id));
            return { cur, value: pvkValueArray[i] };
        });

        profs.rows.forEach(prof => {
            prof.top_table = topTable.rows.filter(x => x.profession_id === prof.id);
        });

        res.render('lab1', {
            title: "Лаба 1 | без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            pvks,
            profs: profs.rows,
            selectedLanguage,
            experts: experts.rows,
        });
    } catch (error) {
        next(error);
    }
});

router.get('/lab2', (req, res, next) => {
    res.status(200)
    res.render('lab2', {
        title: "Лаба 2 | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.get('/lab2/simple', (req, res, next) => {
    res.status(200)
    res.render('simple_tests', {
        title: "Простые тесты | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.get('/lab2/simple/light', (req, res, next) => {
    res.status(200)
    res.render('lighttest_simple', {
        title: "Простой тест на свет | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.get('/lab2/simple/sound', (req, res, next) => {
    res.status(200)
    res.render('soundtest_simple', {
        title: "Простой тест на звук | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.get('/lab2/hard', (req, res, next) => {
    res.status(200)
    res.render('hard_tests', {
        title: "Сложные тесты | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.get('/lab2/hard/maths_hard', (req, res, next) => {
    res.status(200)
    res.render('mathtest_hard', {
        title: "Сложный математический тест | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.get('/lab2/hard/sound_hard', (req, res, next) => {
    res.status(200)
    res.render('soundtest_hard', {
        title: "Сложный тест на звук | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.get('/lab2/hard/colors_hard', (req, res, next) => {
    res.status(200)
    res.render('lighttest_hard', {
        title: "Сложный тест на свет | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
    })
})

router.post('/lab2/', (req, res, next) => {
    res.status(200)
    results = req.body
    User.userById(req.cookies.usr_id).then((user) => {
        if (user) {
            user = new User(user)
            user.sendResultSecond(results)
        }
    });
})

router.get('/lab3', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.lab_id = 3
        `, [req.cookies.usr_id]);

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.test_in_lab_id
    }));

    res.status(200)
    res.render('lab3', {
        title: "Лаба 3 | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab3/lab3_simple', async (req, res, next) => {
    try {
        const result = await CLIENT.query(`
        SELECT preset_to_resp.*, presets.*
        FROM preset_to_resp
        JOIN presets ON preset_to_resp.preset_id = presets.preset_id
        WHERE preset_to_resp.user_id = $1
        AND presets.test_in_lab_id = 1
        AND presets.lab_id = 3
        ORDER BY preset_to_resp.id DESC
        LIMIT 1
        `, [req.cookies.usr_id]);

        res.status(200).render('lab3_simple', {
            title: "Простые тесты | без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            preset: result.rows[0].params,
            preset_id: result.rows[0].preset_id
        })
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
})

router.get('/lab3/lab3_hard', async (req, res, next) => {
    try {
        const result = await CLIENT.query(`
        SELECT preset_to_resp.*, presets.*
        FROM preset_to_resp
        JOIN presets ON preset_to_resp.preset_id = presets.preset_id
        WHERE preset_to_resp.user_id = $1
        AND presets.test_in_lab_id = 2
        AND presets.lab_id = 3
        ORDER BY preset_to_resp.id DESC
        LIMIT 1
        `, [req.cookies.usr_id]);

        res.status(200).render('lab3_hard', {
            title: "Сложные тесты | без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            preset: result.rows[0].params,
            preset_id: result.rows[0].preset_id
        })
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
})

router.post('/lab3/', (req, res, next) => {
    res.status(200)
    results = req.body
    User.userById(req.cookies.usr_id).then((user) => {
        if (user) {
            user = new User(user)
            user.sendResultThird(results)
        }
    });
})

router.get('/lab4', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.lab_id = 4
        `, [req.cookies.usr_id]);

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.test_in_lab_id
    }));

    res.status(200)
    res.render('lab4', {
        title: "Лаба 4 | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab4/lab4_simple', async (req, res, next) => {
    try {
        const result = await CLIENT.query(`
            SELECT preset_to_resp.*, presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.test_in_lab_id = 1
            AND presets.lab_id = 4
            ORDER BY preset_to_resp.id DESC
            LIMIT 1
        `, [req.cookies.usr_id]);

        res.status(200).render('lab4_simple', {
            title: "Аналоговое слежение | без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            preset: result.rows[0].params,
            preset_id: result.rows[0].preset_id
        })
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
})

router.get('/lab4/lab4_hard', async (req, res, next) => {
    try {
        const result = await CLIENT.query(`
        SELECT preset_to_resp.*, presets.*
        FROM preset_to_resp
        JOIN presets ON preset_to_resp.preset_id = presets.preset_id
        WHERE preset_to_resp.user_id = $1
        AND presets.test_in_lab_id = 2
        AND presets.lab_id = 4
        ORDER BY preset_to_resp.id DESC
        LIMIT 1
        `, [req.cookies.usr_id]);

        res.status(200).render('lab4_hard', {
            title: "Слежение с преследованием | без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            preset: result.rows[0].params,
            preset_id: result.rows[0].preset_id
        })
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
})

router.post('/lab4/', (req, res, next) => {
    res.status(200)
    results = req.body
    User.userById(req.cookies.usr_id).then((user) => {
        if (user) {
            user = new User(user)
            user.sendResultFourth(results)
        }
    });
})

router.get('/lab5', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.lab_id = 5
        `, [req.cookies.usr_id]);

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.test_in_lab_id
    }));

    res.status(200)
    res.render('lab5', {
        title: "Лаба 5 | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab5/lab5_consciousness', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.lab_id = 5
        `, [req.cookies.usr_id]);

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.test_in_lab_id
    }));

    res.status(200)
    res.render('lab5_consciousness', {
        title: "Тесты на внимание | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab5/lab5_memory', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.lab_id = 5
        `, [req.cookies.usr_id]);

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.test_in_lab_id
    }));

    res.status(200)
    res.render('lab5_memory', {
        title: "Тесты на память | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab5/lab5_brain', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.lab_id = 5
        `, [req.cookies.usr_id]);

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.test_in_lab_id
    }));

    res.status(200)
    res.render('lab5_brain', {
        title: "Тесты на мышление | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab5/lab5_sustainability', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT preset_to_resp.*, presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.test_in_lab_id = 1
            AND presets.lab_id = 5
            ORDER BY preset_to_resp.id DESC
            LIMIT 1
        `, [req.cookies.usr_id]);

    res.status(200)
    res.render('lab5_sustainability', {
        title: "Тест на устойчивость | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        preset: result.rows[0].params,
        preset_id: result.rows[0].preset_id
    })
})

router.get('/lab5/lab5_switchability', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT preset_to_resp.*, presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.test_in_lab_id = 2
            AND presets.lab_id = 5
            ORDER BY preset_to_resp.id DESC
            LIMIT 1
        `, [req.cookies.usr_id]);

    res.status(200)
    res.render('lab5_switchability', {
        title: "Тест на переключаемость | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        preset: result.rows[0].params,
        preset_id: result.rows[0].preset_id
    })
})

router.get('/lab5/lab5_visual', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT preset_to_resp.*, presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.test_in_lab_id = 3
            AND presets.lab_id = 5
            ORDER BY preset_to_resp.id DESC
            LIMIT 1
        `, [req.cookies.usr_id]);

    res.status(200)
    res.render('lab5_visual', {
        title: "Тест на зрительную память | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        preset: result.rows[0].params,
        preset_id: result.rows[0].preset_id
    })
})

router.get('/lab5/lab5_low', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT preset_to_resp.*, presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.test_in_lab_id = 4
            AND presets.lab_id = 5
            ORDER BY preset_to_resp.id DESC
            LIMIT 1
        `, [req.cookies.usr_id]);

    res.status(200)
    res.render('lab5_low', {
        title: "Тест на звуковую память | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        preset: result.rows[0].params,
        preset_id: result.rows[0].preset_id
    })
})

router.get('/lab5/lab5_analytical', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT preset_to_resp.*, presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.test_in_lab_id = 5
            AND presets.lab_id = 5
            ORDER BY preset_to_resp.id DESC
            LIMIT 1
        `, [req.cookies.usr_id]);

    res.status(200)
    res.render('lab5_analytical', {
        title: "Тест на аналитичекое мышление | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        preset: result.rows[0].params,
        preset_id: result.rows[0].preset_id,
        raven_answers: raven_answers
    })
})

router.get('/lab5/lab5_abstract', async (req, res, next) => {
    const result = await CLIENT.query(`
            SELECT preset_to_resp.*, presets.*
            FROM preset_to_resp
            JOIN presets ON preset_to_resp.preset_id = presets.preset_id
            WHERE preset_to_resp.user_id = $1
            AND presets.test_in_lab_id = 6
            AND presets.lab_id = 5
            ORDER BY preset_to_resp.id DESC
            LIMIT 1
        `, [req.cookies.usr_id]);

    res.status(200)
    res.render('lab5_abstract', {
        title: "Тест на абстрактное мышление | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        preset: result.rows[0].params,
        preset_id: result.rows[0].preset_id
    })
})

router.post('/lab5', (req, res, next) => {
    res.status(200)
    results = req.body
    User.userById(req.cookies.usr_id).then((user) => {
        if (user) {
            user = new User(user)
            user.sendResultFifth(results)
        }
    });
})

router.get('/lab6', async (req, res, next) => {
    res.status(200)

    top_table_query = "WITH ranked_pvk AS (SELECT profession_id, pvk_id, ROW_NUMBER() OVER (PARTITION BY profession_id ORDER BY COUNT(*) DESC) AS rank FROM expert_profession_quality_lab1 GROUP BY profession_id, pvk_id) SELECT rp.profession_id, p.name, rp.pvk_id, pv.name FROM ranked_pvk AS rp JOIN professions_lab1 AS p ON rp.profession_id = p.id JOIN pvk_lab1 AS pv ON rp.pvk_id = pv.id ORDER BY rp.profession_id, rp.rank;"

    top_table = await CLIENT.query(top_table_query)
    profs = await CLIENT.query('select * from professions_lab1')
    experts = await CLIENT.query(`select * from users where is_expert='t'`)

    for (let i = 0; i < profs.rows.length; i++) {
        profs.rows[i]["top_table"] = top_table.rows.filter(x => x.profession_id === profs.rows[i].id)
    }

    res.render('lab6', {
        title: "Лаба 6 | без CHATGPT",
        experts: experts.rows,
        isLoggedIn: req.cookies.usr_id,
        profs: profs.rows,
    })
})

router.post('/lab6', (req, res, next) => {
    res.status(200)
    res.redirect(`/labs/lab6/criteria`)
})

router.get("/lab6/criteria", async (req, res, next) => {
    res.status(200)

    const result = await CLIENT.query(`select * from expert_profession_quality_lab1`);
    const pvk_lab1 = await CLIENT.query('select * from pvk_lab1');
    const profs = await CLIENT.query('select * from professions_lab1');
    const criteria = await CLIENT.query('select * from criteria');

    const criteria_rows = criteria.rows;
    const pvk_lab1_rows = pvk_lab1.rows;
    const rows = result.rows;
    let prof_rows = profs.rows;

    for (let i = 0; i < prof_rows.length; i++) {
        prof_rows[i]["pvks"] = rows.filter(x => x["profession_id"] === prof_rows[i]["id"]);
        for (let j = 0; j < prof_rows[i]["pvks"].length; j++) {
            prof_rows[i]["pvks"][j]["name"] = pvk_lab1_rows.find(x => x["id"] === prof_rows[i]["pvks"][j]["pvk_id"])["name"]
        }
    }
    res.render('criteria_pvk', {
        title: "Выбор критериев | без CHATGPT",
        profs: prof_rows,
        isLoggedIn: req.cookies.usr_id,
        selectedLanguage: req.query.selectedLanguage,
        criteria: criteria_rows
    });
})

router.post("/lab6/assign-criteria", async (req, res, next) => {
    if (!req.body || Object.keys(req.body).length === 0) {
        return res.status(400).send('Request body is empty');
    }

    let output = {
        preset_name: req.body.name,
        preset_params: []
    };

    for (const key in req.body) {
        if (key !== 'name') {
            let parts = key.split('_');
            let profession_id = parseInt(parts[1]);
            let pvk_id = parseInt(parts[2]);
            let field_id = parseInt(req.body[key][0].split('_')[2]);

            output.preset_params.push({
                profession_id: profession_id,
                pvk_id: pvk_id,
                field_id: field_id
            });
        }
    }

    const query = {
        text: 'INSERT INTO criteria_preset(id_expert, preset_name, preset_params) VALUES($1, $2, $3)',
        values: [req.cookies.usr_id, output.preset_name, JSON.stringify(output.preset_params)],
    }

    await CLIENT.query(query)

    res.status(200).redirect("/");
})

module.exports = router
