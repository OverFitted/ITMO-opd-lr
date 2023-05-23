const User = require('../models/user');
const {
    Router
} = require('express')
const CLIENT = require('../models/connector');
const router = Router()

router.get('/lab1', (req, res, next) => {
    res.status(200)

    top_table_query = "WITH ranked_pvk AS (SELECT profession_id, pvk_id, ROW_NUMBER() OVER (PARTITION BY profession_id ORDER BY COUNT(*) DESC) AS rank FROM expert_profession_quality_lab1 GROUP BY profession_id, pvk_id) SELECT rp.profession_id, p.name, rp.pvk_id, pv.name FROM ranked_pvk AS rp JOIN professions_lab1 AS p ON rp.profession_id = p.id JOIN pvk_lab1 AS pv ON rp.pvk_id = pv.id WHERE rp.rank <= 5 ORDER BY rp.profession_id, rp.rank;"

    CLIENT.query(top_table_query).then((top_table) => {
        CLIENT.query('select * from professions_lab1').then((profs) => {
            CLIENT.query(`select * from users where is_expert='t'`).then((result) => {
                for (let i = 0; i < profs.rows.length; i++) {
                    profs.rows[i]["top_table"] = top_table.rows.filter(x => x.profession_id === profs.rows[i].id)
                }

                res.render('lab1', {
                    title: "Лаба 1 | без CHATGPT",
                    experts: result.rows,
                    isLoggedIn: req.cookies.usr_id,
                    profs: profs.rows,
                })
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
        test_num: row.params.test_num
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
        test_num: row.params.test_num
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
        test_num: row.params.test_num
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
        test_num: row.params.test_num
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
        test_num: row.params.test_num
    }));

    res.status(200)
    res.render('lab5_memory', {
        title: "Тесты на память | без CHATGPT",
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

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.params.test_num
    }));

    res.status(200)
    res.render('lab5_sustainability', {
        title: "Тест на устойчивость | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
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

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.params.test_num
    }));

    res.status(200)
    res.render('lab5_switchability', {
        title: "Тест на переключаемость | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab5/lab5_visual', async (req, res, next) => {
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

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.params.test_num
    }));

    res.status(200)
    res.render('lab5_visual', {
        title: "Тест на визуальную память | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

router.get('/lab5/lab5_low', async (req, res, next) => {
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

    const presets = result.rows.map(row => ({
        lab_num: row.lab_id,
        presets: {
            test_num: row.test_in_lab_id,
            ...row.params,
        },
        test_num: row.params.test_num
    }));

    res.status(200)
    res.render('lab5_low', {
        title: "Тест на краткосрочную память | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        presets: presets
    })
})

module.exports = router
