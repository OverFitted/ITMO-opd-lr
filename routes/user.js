const User = require('../models/user');
const { Router } = require('express')
const CLIENT = require("../models/connector");
const router = Router()
const fs = require('fs');

const presetsConfigJson = fs.readFileSync('models/presets.json', 'utf8');
const presetsConfig = JSON.parse(presetsConfigJson);

const criteriaConfigJson = fs.readFileSync('models/criteria.json', 'utf8');
const criteriaConfig = JSON.parse(criteriaConfigJson);

async function getPresets() {
    try {
        const result = await CLIENT.query('SELECT * FROM presets');
        const presets = result.rows.map(row => {
            const labConfig = presetsConfig.find(c => c.lab_num === row.lab_id);
            const presetParams = Object.entries(row.params).map(([key, value]) => {
                const paramConfig = labConfig.params.find(p => p.name === key);
                return {
                    label: paramConfig ? paramConfig.label : key,
                    value: value
                };
            });
            return {
                lab_num: row.lab_id,
                presets: {
                    preset_id: row.preset_id,
                    test_num: row.test_in_lab_id,
                    preset_name: row.preset_name,
                    params: presetParams,
                },
            };
        });

        const groupedPresets = [];
        presets.forEach(preset => {
            const existingLab = groupedPresets.find(lab => lab.lab_num === preset.lab_num);
            if (existingLab) {
                existingLab.presets.push(preset.presets);
            } else {
                groupedPresets.push({
                    lab_num: preset.lab_num,
                    presets: [preset.presets],
                });
            }
        });

        return groupedPresets;
    } catch (err) {
        throw err;
    }
}

router.get('/', async (req, res, next) => {
    try {
        const pvk_lab1 = await CLIENT.query('select * from pvk_lab1');
        const profs = await CLIENT.query('select * from professions_lab1');
        const resp_res_lr2_raw = await CLIENT.query(`SELECT lr2_to_resp.respondent_id, lr2_to_resp.expert_id, lr2_to_resp.test_id, results_list_lr2.result_list, test_name.test_name FROM lr2_to_resp JOIN results_list_lr2 ON lr2_to_resp.result_id_lr2 = results_list_lr2.id JOIN test_name ON lr2_to_resp.test_id = test_name.test_id AND test_name.lab_id = 2;`);
        const resp_res_lr3_raw = await CLIENT.query(`SELECT lr3_to_resp.respondent_id, lr3_to_resp.preset_id, results_list_lr3.result_list, test_name.test_name, presets.test_in_lab_id FROM lr3_to_resp JOIN results_list_lr3 ON lr3_to_resp.result_list_id_lr3 = results_list_lr3.id JOIN presets ON lr3_to_resp.preset_id = presets.preset_id JOIN test_name ON presets.test_in_lab_id = test_name.test_id AND test_name.lab_id = 3;`);
        const resp_res_lr4_raw = await CLIENT.query(`SELECT lr4_to_resp.respondent_id, lr4_to_resp.preset_id, results_list_lr4.result_list, test_name.test_name, presets.test_in_lab_id FROM lr4_to_resp JOIN results_list_lr4 ON lr4_to_resp.result_list_id_lr4 = results_list_lr4.id JOIN presets ON lr4_to_resp.preset_id = presets.preset_id JOIN test_name ON presets.test_in_lab_id = test_name.test_id AND test_name.lab_id = 4;`);
        const resp_res_lr5_raw = await CLIENT.query(`SELECT lr5_to_resp.respondent_id, lr5_to_resp.preset_id, results_list_lr5.result_list, test_name.test_name, presets.test_in_lab_id FROM lr5_to_resp JOIN results_list_lr5 ON lr5_to_resp.result_list_id_lr5 = results_list_lr5.id JOIN presets ON lr5_to_resp.preset_id = presets.preset_id JOIN test_name ON presets.test_in_lab_id = test_name.test_id AND test_name.lab_id = 5;`);
        const users = await CLIENT.query("select * from users");
        const result = await CLIENT.query(`select * from expert_profession_quality_lab1 where expert_id = ${req.cookies.usr_id}`);
        const user = await User.userById(req.cookies.usr_id);
        const groupedPresets = await getPresets();

        let resp_res_lr2 = resp_res_lr2_raw.rows;
        let resp_res_lr3 = resp_res_lr3_raw.rows;
        let resp_res_lr4 = resp_res_lr4_raw.rows;
        let resp_res_lr5 = resp_res_lr5_raw.rows;

        let resp_res_lr2_simple = [];
        let resp_res_lr2_hard = [];
        let resp_res_lr3_simple = [];
        let resp_res_lr3_hard = [];
        let resp_res_lr4_simple = [];
        let resp_res_lr4_hard = [];
        let resp_res_lr5_visual = [];
        let resp_res_lr5_memory = [];
        let resp_res_lr5_brain = [];

        let rows = result.rows;
        let prof_rows = profs.rows;

        for (let i = 0; i < prof_rows.length; i++) {
            prof_rows[i]["pvks"] = rows.filter(x => x["profession_id"] === prof_rows[i]["id"]);
            for (let j = 0; j < prof_rows[i]["pvks"].length; j++) {
                prof_rows[i]["pvks"][j]["name"] = pvk_lab1.rows.find(x => x["id"] === prof_rows[i]["pvks"][j]["pvk_id"])["name"]
            }
        }

        const sortResponsesByDifficulty = (resp_res, simpleArray, hardArray) => {
            for (let i = 0; i < resp_res.length; i++) {
                resp_res[i].result_list = resp_res[i].result_list.join("; ");
                if (resp_res[i].test_in_lab_id === 1) {
                    simpleArray.push(resp_res[i]);
                } else {
                    hardArray.push(resp_res[i]);
                }
            }
        };

        const sortResponsesByDifficultyLR2 = (resp_res, simpleArray, hardArray) => {
            for (let i = 0; i < resp_res.length; i++) {
                resp_res[i].result_list = resp_res[i].result_list.join("; ");
                if (resp_res[i].test_id === 1) {
                    simpleArray.push(resp_res[i]);
                } else {
                    hardArray.push(resp_res[i]);
                }
            }
        };

        const sortResponsesByDifficultyLR5 = (resp_res, visualArray, memoryArray, brainArray) => {
            for (let i = 0; i < resp_res.length; i++) {
                resp_res[i].result_list = resp_res[i].result_list.join("; ");
                if (resp_res[i].test_id < 3) {
                    visualArray.push(resp_res[i]);
                } else if (resp_res[i].test_id < 5) {
                    memoryArray.push(resp_res[i]);
                } else {
                    brainArray.push(resp_res[i]);
                }
            }
        };

        sortResponsesByDifficultyLR2(resp_res_lr2, resp_res_lr2_simple, resp_res_lr2_hard);
        sortResponsesByDifficulty(resp_res_lr3, resp_res_lr3_simple, resp_res_lr3_hard);
        sortResponsesByDifficulty(resp_res_lr4, resp_res_lr4_simple, resp_res_lr4_hard);
        sortResponsesByDifficultyLR5(resp_res_lr5, resp_res_lr5_visual, resp_res_lr5_memory, resp_res_lr5_brain)

        res.status(200).render('settings', {
            title: "Настройки | Без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            user: user,
            rows: prof_rows,
            resp_res_lr2,
            resp_res_lr2_simple,
            resp_res_lr2_hard,
            resp_res_lr3,
            resp_res_lr3_simple,
            resp_res_lr3_hard,
            resp_res_lr4,
            resp_res_lr4_simple,
            resp_res_lr4_hard,
            resp_res_lr5_visual,
            resp_res_lr5_memory,
            resp_res_lr5_brain,
            users: users.rows,
            presets: groupedPresets
        })
    } catch (err) {
        next(err);
    }
});

router.get("/config/:lab_num", (req, res, next) => {
    const labNum = parseInt(req.params.lab_num, 10);
    const labConfig = presetsConfig.find(item => item.lab_num === labNum);
    res.json(labConfig);
});

router.get("/presets", async (req, res, next) => {
    try {
        const groupedPresets = await getPresets();

        res.status(200).render('presets', {
            title: "Пресеты | Без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            presets: groupedPresets,
            config: config
        });
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

router.post("/assign-test", async (req, res) => {
    const { usr_id, preset } = req.body;
    try {
        await CLIENT.query('INSERT INTO preset_to_resp(user_id, preset_id) VALUES($1, $2)', [usr_id, preset]);
        res.status(200).end();
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

router.post("/add-preset", async (req, res) => {
    const preset = req.body;
    const params = {...preset};
    delete params["lab_num"]
    delete params["test_num"]

    const query = {
        text: 'INSERT INTO presets(lab_id, test_in_lab_id, preset_name, params) VALUES($1, $2, $3, $4)',
        values: [preset.lab_num, preset.test_num, preset.preset_name, params],
    };

    try {
        await CLIENT.query(query);
        res.redirect('/user/presets');
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
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

router.get("/criteria_list", (req, res, next) => {
    res.status(200)
    res.render('criteria_list', {
        title: "Список критериев | без CHATGPT",
        isLoggedIn: req.cookies.usr_id
    })
})

router.post('/choose-criteria', (req, res) => {
    let option = req.body.option;
    let newTestOptions = [];

    res.json({ testOptions: newTestOptions });
});

module.exports = router
