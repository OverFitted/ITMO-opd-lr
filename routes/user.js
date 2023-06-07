const ExcelJS = require('exceljs');
const User = require('../models/user');
const { Router } = require('express')
const CLIENT = require("../models/connector");
const router = Router()
const fs = require('fs');

const presetsConfigJson = fs.readFileSync('models/presets.json', 'utf8');
const presetsConfig = JSON.parse(presetsConfigJson);

const criteriaConfigJson = fs.readFileSync('models/criteria.json', 'utf8');
const criteriaConfig = JSON.parse(criteriaConfigJson);

String.prototype.format = function () {
    let args = arguments;
    return this.replace(/{(\d+)}/g, function (match, number) {
        return typeof args[number] != 'undefined' ? args[number] : match;
    });
};

async function getParams(lab_num, test_num) {
    lab_num = parseInt(lab_num)
    test_num = parseInt(test_num)
    let lab = criteriaConfig.find(lab => lab.lab_num === lab_num);
    let test = lab.tests.find(test => test.test_num === test_num);
    return test.params;
}

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
        const resp_res_lr3_raw = await CLIENT.query(`SELECT lr3_to_resp.respondent_id, lr3_to_resp.preset_id, results_list_lr3.result_list, results_list_lr3.timeofoper, test_name.test_name, presets.test_in_lab_id FROM lr3_to_resp JOIN results_list_lr3 ON lr3_to_resp.result_list_id_lr3 = results_list_lr3.id JOIN presets ON lr3_to_resp.preset_id = presets.preset_id JOIN test_name ON presets.test_in_lab_id = test_name.test_id AND test_name.lab_id = 3;`);
        const resp_res_lr4_raw = await CLIENT.query(`SELECT lr4_to_resp.respondent_id, lr4_to_resp.preset_id, results_list_lr4.result_list, results_list_lr4.timeofoper, test_name.test_name, presets.test_in_lab_id FROM lr4_to_resp JOIN results_list_lr4 ON lr4_to_resp.result_list_id_lr4 = results_list_lr4.id JOIN presets ON lr4_to_resp.preset_id = presets.preset_id JOIN test_name ON presets.test_in_lab_id = test_name.test_id AND test_name.lab_id = 4;`);
        const resp_res_lr5_raw = await CLIENT.query(`SELECT lr5_to_resp.respondent_id, lr5_to_resp.preset_id, results_list_lr5.result_list, results_list_lr5.timeofoper, test_name.test_name, presets.test_in_lab_id FROM lr5_to_resp JOIN results_list_lr5 ON lr5_to_resp.result_list_id_lr5 = results_list_lr5.id JOIN presets ON lr5_to_resp.preset_id = presets.preset_id JOIN test_name ON presets.test_in_lab_id = test_name.test_id AND test_name.lab_id = 5;`);
        const users = await CLIENT.query("select * from users");
        const result = await CLIENT.query(`select * from expert_profession_quality_lab1 where expert_id = ${req.cookies.usr_id}`);
        const criteria_presets = await CLIENT.query("select * from criteria_preset");
        const user = await User.userById(req.cookies.usr_id);
        const groupedPresets = await getPresets();

        let resp_res_lr2 = resp_res_lr2_raw.rows;
        let resp_res_lr3 = resp_res_lr3_raw.rows;
        let resp_res_lr4 = resp_res_lr4_raw.rows;
        let resp_res_lr5 = resp_res_lr5_raw.rows;

        resp_res_lr3.forEach(row => {
            const timestamp = new Date(row.timeofoper).toLocaleString();
            row.timeofoper = timestamp;
        });
        resp_res_lr4.forEach(row => {
            const timestamp = new Date(row.timeofoper).toLocaleString();
            row.timeofoper = timestamp;
        });
        resp_res_lr5.forEach(row => {
            const timestamp = new Date(row.timeofoper).toLocaleString();
            row.timeofoper = timestamp;
        });

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
                if (resp_res[i].test_in_lab_id < 3) {
                    visualArray.push(resp_res[i]);
                } else if (resp_res[i].test_in_lab_id < 5) {
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
            presets: groupedPresets,
            criteria_presets: criteria_presets.rows
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
            config: presetsConfig
        });
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

router.post("/assign-test", async (req, res) => {
    const { usr_id, preset_id } = req.body;
    try {
        await CLIENT.query('INSERT INTO preset_to_resp(user_id, preset_id) VALUES($1, $2)', [usr_id, preset_id]);
        res.status(200).end();
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

router.post("/assign-criteria", async (req, res) => {
    const { usr_id, preset_id } = req.body;
    try {
        await CLIENT.query(`DELETE FROM preset_to_resp WHERE user_id=${usr_id}`);
        await CLIENT.query('DELETE FROM resp_to_crit_list where id_respond = $1', [usr_id]);
        await CLIENT.query('INSERT INTO resp_to_crit_list(id_respond, id_criteria) VALUES($1, $2)', [usr_id, preset_id]);
        const preset = (await CLIENT.query(`SELECT id, preset_params FROM criteria_preset WHERE id = ${preset_id}`)).rows[0];

        for (let index = 0; index < preset["preset_params"].length; index++) {
            const param = preset["preset_params"][index];
            const criteria = (await CLIENT.query(`SELECT * FROM criteria WHERE criteria_id = ${param["field_id"]}`)).rows[0];
            const preset_num = criteria["criteria_fields"]["preset_num"];
            await CLIENT.query('INSERT INTO preset_to_resp(user_id, preset_id) VALUES($1, $2)', [usr_id, preset_num]);
        }

        res.status(200).end();
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

router.post("/add-preset", async (req, res) => {
    const preset = req.body;
    const params = { ...preset };
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

router.get("/criteria_list", async (req, res, next) => {
    res.status(200)

    let criteria_raw = await CLIENT.query('select * from criteria;');
    let criteria = criteria_raw.rows;

    res.render('criteria_list', {
        title: "Список критериев | без CHATGPT",
        isLoggedIn: req.cookies.usr_id,
        criteria: criteria
    })
})

router.get("/choose-criteria/:lab_num", (req, res, next) => {
    const labNum = parseInt(req.params.lab_num, 10);
    const labConfig = criteriaConfig.find(item => item.lab_num === labNum);
    res.json(labConfig);
});

router.get("/choose-criteria/:lab_num/:test_num", async (req, res, next) => {
    const labNum = parseInt(req.params.lab_num, 10);
    const testNum = parseInt(req.params.test_num, 10);
    const labConfig = criteriaConfig.find(item => item.lab_num === labNum);
    const testConfig = labConfig.tests.find(item => item.test_num === testNum);
    const presets = await CLIENT.query(`select * from presets where lab_id=${labNum} and test_in_lab_id=${testNum}`)
    testConfig["presets"] = presets.rows

    res.json(testConfig);
});

router.post("/del-criteria/", async (req, res, next) => {
    if (!req.body || Object.keys(req.body).length === 0) {
        return res.status(400).send('Request body is empty');
    }

    const query = {
        text: 'DELETE FROM criteria WHERE criteria_id = $1',
        values: [req.body.criteria_id],
    }

    await CLIENT.query(query)
    res.status(200).redirect("/user/criteria_list");
})

router.get("/get-criteria/:criteria_id", async (req, res, next) => {
    if (!req.params || Object.keys(req.params).length === 0) {
        return res.status(400).send('Request params is empty');
    }

    const criteria_id = req.params.criteria_id;
    const criteria = (await CLIENT.query(`SELECT * FROM criteria WHERE criteria_id = ${criteria_id}`)).rows[0];
    const labNum = criteria.criteria_fields.lab_num;
    const testNum = criteria.criteria_fields.test_num;
    const labConfig = criteriaConfig.find(item => item.lab_num === parseInt(labNum));
    const testConfig = labConfig.tests.find(item => item.test_num === parseInt(testNum));

    for (let index = 0; index < Math.min(testConfig.params.length, criteria.criteria_fields.params.length); index++) {
        const element = testConfig.params[index];
        criteria.criteria_fields.params[index]["slice_range"] = element["slice_range"]
    }

    res.status(200).json(criteria);
})

router.post("/add-criteria/", async (req, res, next) => {
    try {
        const preset_num = (await CLIENT.query("select * from presets;")).rows.find((item => item.params.preset_name === req.body.presetSelection)).preset_id
        let criteria = {
            name_criteria: req.body.name_criteria,
            lab_num: req.body.labSelection,
            test_num: req.body.testSelection,
            preset_num: preset_num,
            params: []
        };

        for (let i = 1; i <= Object.keys(req.body).length; i++) {
            if (req.body[`parameter${i}_criteria`] && req.body[`weight_param${i}_criteria`] && req.body[`direction${i}DropdownHidden`] && req.body[`slice${i}_criteria`]) {
                let param = {
                    param_name: req.body[`parameter${i}_criteria`],
                    param_weight: parseFloat(req.body[`weight_param${i}_criteria`]),
                    param_slice: parseFloat(req.body[`slice${i}_criteria`]),
                    param_direction: req.body[`direction${i}DropdownHidden`].toLowerCase().includes('больше')
                };
                criteria.params.push(param);
            } else {
                break;
            }
        }

        const insertText = `INSERT INTO criteria(criteria_fields) VALUES ($1)`;
        const insertValue = [JSON.stringify(criteria)];
        await CLIENT.query(insertText, insertValue);
        res.status(200).redirect("/user/criteria_list");

    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
});

router.post("/edit-criteria/:criteria_id", async (req, res, next) => {
    try {
        if (!req.params || Object.keys(req.params).length === 0) {
            return res.status(400).send('Request params is empty');
        }

        const criteria_id = req.params.criteria_id;

        const preset_num = (await CLIENT.query("select * from presets;")).rows.find((item => item.params.preset_name === req.body.presetSelection)).preset_id
        let criteria = {
            name_criteria: req.body.name_criteria,
            lab_num: req.body.labSelection,
            test_num: req.body.testSelection,
            preset_num: preset_num,
            params: []
        };

        for (let i = 1; i <= Object.keys(req.body).length; i++) {
            if (req.body[`parameter${i}_criteria`] && req.body[`weight_param${i}_criteria`] && req.body[`direction${i}DropdownHidden`] && req.body[`slice${i}_criteria`]) {
                let param = {
                    param_name: req.body[`parameter${i}_criteria`],
                    param_weight: parseFloat(req.body[`weight_param${i}_criteria`]),
                    param_slice: parseFloat(req.body[`slice${i}_criteria`]),
                    param_direction: req.body[`direction${i}DropdownHidden`].toLowerCase().includes('больше')
                };
                criteria.params.push(param);
            } else {
                break;
            }
        }

        await CLIENT.query(`DELETE FROM criteria WHERE criteria_id = ${criteria_id}`);
        const insertText = `INSERT INTO criteria(criteria_id, criteria_fields) VALUES ($1, $2)`;
        const insertValue = [criteria_id, JSON.stringify(criteria)];
        await CLIENT.query(insertText, insertValue);
        res.status(200).redirect("/user/criteria_list");

    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
})

router.get("/check_profs", async (req, res, next) => {
    const usr_id = req.cookies.usr_id;
    try {
        const pvk_importance_table = (await CLIENT.query(`select * from expert_profession_quality_lab1`)).rows;
        const preset_id = (await CLIENT.query('SELECT * FROM resp_to_crit_list WHERE id_respond = $1', [usr_id])).rows[0]["id_criteria"];
        const preset = (await CLIENT.query(`SELECT id, preset_params FROM criteria_preset WHERE id = ${preset_id}`)).rows[0];
        const professionNames = (await CLIENT.query(`SELECT * FROM professions_lab1`)).rows.reduce((obj, row) => {
            obj[row.id] = row.name;
            return obj;
        }, {});

        let preset_data = new Set();
        for (let index = 0; index < preset["preset_params"].length; index++) {
            const param = preset["preset_params"][index];
            const criteria_id = param["field_id"];
            const criteria = (await CLIENT.query(`SELECT * FROM criteria WHERE criteria_id = ${criteria_id}`)).rows[0];
            const preset_num = criteria["criteria_fields"]["preset_num"];
            const lab_num = criteria["criteria_fields"]["lab_num"];
            const test_num = criteria["criteria_fields"]["test_num"];
            const params = criteria["criteria_fields"]["params"];
            const configParams = await getParams(lab_num, test_num);

            params.forEach((param, index) => {
                param["db_index"] = configParams[index]["db_index"];
                param["formula"] = configParams[index]["formula"];
            });

            preset_data.add(JSON.stringify({ criteria_id, preset_num, lab_num, params }));
        }

        preset_data = Array.from(preset_data).map(JSON.parse);

        let all_results = {};
        for (let index = 0; index < preset_data.length; index++) {
            const query = `select * from lr${preset_data[index].lab_num}_to_resp where respondent_id=${usr_id} and preset_id=${preset_data[index].preset_num}`;
            const lr_result_connections = (await CLIENT.query(query)).rows;

            let results_for_preset = [];
            for (let j = 0; j < lr_result_connections.length; j++) {
                const result_list_id = lr_result_connections[j]['result_list_id_lr' + preset_data[index].lab_num];
                const query = `select * from results_list_lr${preset_data[index].lab_num} where id=${result_list_id}`;
                const results_list = (await CLIENT.query(query)).rows[0];
                if (!results_list) {
                    res.end();
                    return;
                }

                let calculated_results = preset_data[index].params.map(param => {
                    const criteria_id = preset_data[index]["criteria_id"];
                    const values = param.db_index.map(index => results_list.result_list[index]);
                    const result = eval(param.formula.format(...values));
                    const inRange = param.param_direction ? result >= param.param_slice : result <= param.param_slice;
                    const score = inRange ? param.param_weight : 0;
                    const maxScore = param.param_weight;
                    return { [param.param_name]: { maxScore, criteria_id, result, inRange, score } };
                });
                let totalScore = calculated_results.reduce((total, param) => total + Object.values(param)[0].score, 0);
                let maxScore = calculated_results.reduce((max, param) => max + Object.values(param)[0].maxScore, 0);

                results_for_preset.push({ maxScore, score: totalScore, criteria_id: preset_data[index]["criteria_id"], results: calculated_results });
            }

            results_for_preset.sort((a, b) => b.score - a.score);
            let best_result_for_preset = results_for_preset[0];
            all_results[preset_data[index]["criteria_id"]] = best_result_for_preset;
        }

        let professionScores = Object.keys(professionNames).reduce((obj, id) => ({ ...obj, [professionNames[id]]: 0 }), {});
        let professionMaxScores = Object.keys(professionNames).reduce((obj, id) => ({ ...obj, [professionNames[id]]: 0 }), {});
        for (let index = 0; index < preset["preset_params"].length; index++) {
            const param = preset["preset_params"][index];
            const criteria_id = param["field_id"];
            const profession_id = param["profession_id"];
            const criteria_score = all_results[criteria_id];
            const pvk_importance = pvk_importance_table.find(x => x["pvk_id"] === param["pvk_id"])["importance"]

            if (!(professionNames[profession_id] in professionScores)) {
                professionScores[professionNames[profession_id]] = 0;
                professionMaxScores[professionNames[profession_id]] = 0;
            }

            professionScores[professionNames[profession_id]] += criteria_score.score * pvk_importance;
            professionMaxScores[professionNames[profession_id]] += criteria_score.maxScore * pvk_importance;
        }

        let professionScoresPercentage = {}
        for (let profession_name in professionScores) {
            professionScoresPercentage[profession_name] = (professionScores[profession_name] / professionMaxScores[profession_name]) * 100;
        }

        let totalScore = Object.values(professionScores).reduce((a, b) => a + b, 0);
        for (let profession_name in professionScores) {
            professionScores[profession_name] = (professionScores[profession_name] / totalScore) * 100;
        }

        res.status(200).json([professionScores, professionScoresPercentage]);
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

router.get("/check_all_profs", async (req, res, next) => {
    try {
        const pvk_importance_table = (await CLIENT.query(`select * from expert_profession_quality_lab1`)).rows;
        const professionNames = (await CLIENT.query(`SELECT * FROM professions_lab1`)).rows.reduce((obj, row) => {
            obj[row.id] = row.name;
            return obj;
        }, {});
        const usersData = {};
        const users = (await CLIENT.query('select * from users')).rows;
        for (let user of users) {
            try {
                const usr_id = user.usr_id;
                const preset_id = (await CLIENT.query('SELECT * FROM resp_to_crit_list WHERE id_respond = $1', [usr_id])).rows[0]["id_criteria"];
                const preset = (await CLIENT.query(`SELECT id, preset_params FROM criteria_preset WHERE id = ${preset_id}`)).rows[0];

                let preset_data = new Set();
                for (let index = 0; index < preset["preset_params"].length; index++) {
                    const param = preset["preset_params"][index];
                    const criteria_id = param["field_id"];
                    const criteria = (await CLIENT.query(`SELECT * FROM criteria WHERE criteria_id = ${criteria_id}`)).rows[0];
                    const preset_num = criteria["criteria_fields"]["preset_num"];
                    const lab_num = criteria["criteria_fields"]["lab_num"];
                    const test_num = criteria["criteria_fields"]["test_num"];
                    const params = criteria["criteria_fields"]["params"];
                    const configParams = await getParams(lab_num, test_num);

                    params.forEach((param, index) => {
                        param["db_index"] = configParams[index]["db_index"];
                        param["formula"] = configParams[index]["formula"];
                    });

                    preset_data.add(JSON.stringify({ criteria_id, preset_num, lab_num, params }));
                }

                preset_data = Array.from(preset_data).map(JSON.parse);

                let all_results = {};
                for (let index = 0; index < preset_data.length; index++) {
                    const query = `select * from lr${preset_data[index].lab_num}_to_resp where respondent_id=${usr_id} and preset_id=${preset_data[index].preset_num}`;
                    const lr_result_connections = (await CLIENT.query(query)).rows;

                    let results_for_preset = [];
                    for (let j = 0; j < lr_result_connections.length; j++) {
                        const result_list_id = lr_result_connections[j]['result_list_id_lr' + preset_data[index].lab_num];
                        const query = `select * from results_list_lr${preset_data[index].lab_num} where id=${result_list_id}`;
                        const results_list = (await CLIENT.query(query)).rows[0];
                        if (!results_list) {
                            res.end();
                            return;
                        }

                        let calculated_results = preset_data[index].params.map(param => {
                            const criteria_id = preset_data[index]["criteria_id"];
                            const values = param.db_index.map(index => results_list.result_list[index]);
                            const result = eval(param.formula.format(...values));
                            const inRange = param.param_direction ? result >= param.param_slice : result <= param.param_slice;
                            const score = inRange ? param.param_weight : 0;
                            const maxScore = param.param_weight;
                            return { [param.param_name]: { maxScore, criteria_id, result, inRange, score } };
                        });
                        let totalScore = calculated_results.reduce((total, param) => total + Object.values(param)[0].score, 0);
                        let maxScore = calculated_results.reduce((max, param) => max + Object.values(param)[0].maxScore, 0);

                        results_for_preset.push({ maxScore, score: totalScore, criteria_id: preset_data[index]["criteria_id"], results: calculated_results });
                    }

                    results_for_preset.sort((a, b) => b.score - a.score);
                    let best_result_for_preset = results_for_preset[0];
                    all_results[preset_data[index]["criteria_id"]] = best_result_for_preset;
                }

                let professionScores = Object.keys(professionNames).reduce((obj, id) => ({ ...obj, [professionNames[id]]: 0 }), {});
                let professionMaxScores = Object.keys(professionNames).reduce((obj, id) => ({ ...obj, [professionNames[id]]: 0 }), {});
                for (let index = 0; index < preset["preset_params"].length; index++) {
                    const param = preset["preset_params"][index];
                    const criteria_id = param["field_id"];
                    const profession_id = param["profession_id"];
                    const criteria_score = all_results[criteria_id];
                    const pvk_importance = pvk_importance_table.find(x => x["pvk_id"] === param["pvk_id"])["importance"]

                    if (!(professionNames[profession_id] in professionScores)) {
                        professionScores[professionNames[profession_id]] = 0;
                        professionMaxScores[professionNames[profession_id]] = 0;
                    }

                    professionScores[professionNames[profession_id]] += criteria_score.score * pvk_importance;
                    professionMaxScores[professionNames[profession_id]] += criteria_score.maxScore * pvk_importance;
                }

                let professionScoresPercentage = {}
                for (let profession_name in professionScores) {
                    professionScoresPercentage[profession_name] = (professionScores[profession_name] / professionMaxScores[profession_name]) * 100;
                }

                let totalScore = Object.values(professionScores).reduce((a, b) => a + b, 0);
                for (let profession_name in professionScores) {
                    professionScores[profession_name] = (professionScores[profession_name] / totalScore) * 100;
                }

                usersData[usr_id] = [professionScores, professionScoresPercentage];
            } catch (err) {
                continue;
            }
        }

        let professionCount = {};

        Object.keys(usersData).forEach(userID => {
            let professions = Object.keys(usersData[userID][0]);
            professions.forEach(profession => {
                if (professionCount[profession]) {
                    professionCount[profession].count += 1;
                    professionCount[profession].total += usersData[userID][0][profession];
                } else {
                    professionCount[profession] = { count: 1, total: usersData[userID][0][profession] };
                }
            });
        });

        Object.keys(professionCount).forEach(profession => {
            professionCount[profession].popularity = professionCount[profession].total / professionCount[profession].count;
        });

        let professionsArray = Object.keys(professionCount).map(profession => ({
            profession,
            popularity: professionCount[profession].popularity
        }));

        professionsArray.sort((a, b) => b.popularity - a.popularity);
        let mostPopular = professionsArray[0].profession;
        let leastPopular = professionsArray[professionsArray.length - 1].profession;

        let workbook = new ExcelJS.Workbook();
        let worksheet = workbook.addWorksheet('Профессии');

        worksheet.columns = [
            { header: 'Название профессии', key: 'profession', width: 25 },
            { header: 'User ID', key: 'user_id', width: 10 },
            { header: 'Процент совместимости с профессией', key: 'intercompatibility', width: 35 },
            { header: 'Процент совместимости между профессиями', key: 'compatibility', width: 35 }
        ];

        Object.keys(usersData).forEach(userID => {
            let professions = Object.keys(usersData[userID][0]);
            professions.forEach(profession => {
                worksheet.addRow({
                    'profession': profession,
                    'user_id': userID,
                    'compatibility': usersData[userID][0][profession],
                    'intercompatibility': usersData[userID][1] ? usersData[userID][1][profession] : 'N/A'
                });
            });
        });

        worksheet.getCell('F1').value = 'Самая популярная профессия';
        worksheet.getCell('G1').value = mostPopular;

        worksheet.getCell('F2').value = 'Самая непопулярная профессия';
        worksheet.getCell('G2').value = leastPopular;

        await workbook.xlsx.writeFile('temp/Без ChatGPT Профессии.xlsx');

        res.download('temp/Без ChatGPT Профессии.xlsx', (err) => {
            if (err) throw err;
            fs.unlinkSync('temp/Без ChatGPT Профессии.xlsx');
        });
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

router.get("/check_all_pvks", async (req, res, next) => {
    try {
        const pvk_importance_table = (await CLIENT.query(`select * from expert_profession_quality_lab1`)).rows;
        const pvkNames = (await CLIENT.query(`SELECT * FROM pvk_lab1`)).rows.reduce((obj, row) => {
            obj[row.id] = row.name;
            return obj;
        }, {});
        const usersData = {};
        const users = (await CLIENT.query('select * from users')).rows;
        for (let user of users) {
            try {
                const usr_id = user.usr_id;
                const preset_id = (await CLIENT.query('SELECT * FROM resp_to_crit_list WHERE id_respond = $1', [usr_id])).rows[0]["id_criteria"];
                const preset = (await CLIENT.query(`SELECT id, preset_params FROM criteria_preset WHERE id = ${preset_id}`)).rows[0];

                let preset_data = new Set();
                for (let index = 0; index < preset["preset_params"].length; index++) {
                    const param = preset["preset_params"][index];
                    const criteria_id = param["field_id"];
                    const criteria = (await CLIENT.query(`SELECT * FROM criteria WHERE criteria_id = ${criteria_id}`)).rows[0];
                    const preset_num = criteria["criteria_fields"]["preset_num"];
                    const lab_num = criteria["criteria_fields"]["lab_num"];
                    const test_num = criteria["criteria_fields"]["test_num"];
                    const params = criteria["criteria_fields"]["params"];
                    const configParams = await getParams(lab_num, test_num);

                    params.forEach((param, index) => {
                        param["db_index"] = configParams[index]["db_index"];
                        param["formula"] = configParams[index]["formula"];
                    });

                    preset_data.add(JSON.stringify({ criteria_id, preset_num, lab_num, params }));
                }

                preset_data = Array.from(preset_data).map(JSON.parse);

                let all_results = {};
                for (let index = 0; index < preset_data.length; index++) {
                    const query = `select * from lr${preset_data[index].lab_num}_to_resp where respondent_id=${usr_id} and preset_id=${preset_data[index].preset_num}`;
                    const lr_result_connections = (await CLIENT.query(query)).rows;

                    let results_for_preset = [];
                    for (let j = 0; j < lr_result_connections.length; j++) {
                        const result_list_id = lr_result_connections[j]['result_list_id_lr' + preset_data[index].lab_num];
                        const query = `select * from results_list_lr${preset_data[index].lab_num} where id=${result_list_id}`;
                        const results_list = (await CLIENT.query(query)).rows[0];
                        if (!results_list) {
                            res.end();
                            return;
                        }

                        let calculated_results = preset_data[index].params.map(param => {
                            const criteria_id = preset_data[index]["criteria_id"];
                            const values = param.db_index.map(index => results_list.result_list[index]);
                            const result = eval(param.formula.format(...values));
                            const inRange = param.param_direction ? result >= param.param_slice : result <= param.param_slice;
                            const score = inRange ? param.param_weight : 0;
                            const maxScore = param.param_weight;
                            return { [param.param_name]: { maxScore, criteria_id, result, inRange, score } };
                        });
                        let totalScore = calculated_results.reduce((total, param) => total + Object.values(param)[0].score, 0);
                        let maxScore = calculated_results.reduce((max, param) => max + Object.values(param)[0].maxScore, 0);

                        results_for_preset.push({ maxScore, score: totalScore, criteria_id: preset_data[index]["criteria_id"], results: calculated_results });
                    }

                    results_for_preset.sort((a, b) => b.score - a.score);
                    let best_result_for_preset = results_for_preset[0];
                    all_results[preset_data[index]["criteria_id"]] = best_result_for_preset;
                }

                let pvkScores = Object.keys(pvkNames).reduce((obj, id) => ({ ...obj, [pvkNames[id]]: 0 }), {});
                let pvkMaxScores = Object.keys(pvkNames).reduce((obj, id) => ({ ...obj, [pvkNames[id]]: 0 }), {});
                for (let index = 0; index < preset["preset_params"].length; index++) {
                    const param = preset["preset_params"][index];
                    const pvk_id = param["pvk_id"];
                    const criteria_id = param["field_id"];
                    const criteria_score = all_results[criteria_id];
                    const pvk_importance = pvk_importance_table.find(x => x["pvk_id"] === param["pvk_id"])["importance"]

                    if (!(pvkNames[pvk_id] in pvkScores)) {
                        pvkScores[pvkNames[pvk_id]] = 0;
                        pvkMaxScores[pvkNames[pvk_id]] = 0;
                    }

                    pvkScores[pvkNames[pvk_id]] += criteria_score.score * pvk_importance;
                    pvkMaxScores[pvkNames[pvk_id]] += criteria_score.maxScore * pvk_importance;
                }

                let pvkScoresPercentage = {}
                for (let pvk_name in pvkScores) {
                    pvkScoresPercentage[pvk_name] = (pvkScores[pvk_name] / pvkMaxScores[pvk_name]) * 100;
                }

                let totalScore = Object.values(pvkScores).reduce((a, b) => a + b, 0);
                for (let pvk_name in pvkScores) {
                    pvkScores[pvk_name] = (pvkScores[pvk_name] / totalScore) * 100;
                }

                for (let pvk_name in pvkScores) {
                    if (pvkScoresPercentage[pvk_name] === null || isNaN(pvkScoresPercentage[pvk_name]) || !isFinite(pvkScoresPercentage[pvk_name])) {
                        delete pvkScores[pvk_name];
                        delete pvkScoresPercentage[pvk_name];
                    }
                }

                usersData[usr_id] = [pvkScores, pvkScoresPercentage];
            } catch (err) {
                continue;
            }
        }

        const workbook = new ExcelJS.Workbook();
        Object.keys(usersData).forEach((userId) => {
            const worksheet = workbook.addWorksheet(`ПВК-${userId}`);

            worksheet.columns = [
                { header: 'Название ПВК', key: 'pvk', width: 10 },
                { header: 'user_id', key: 'user_id', width: 10 },
                { header: 'Процент совместимости с ПВК', key: 'intercompatibility', width: 10 },
                { header: 'Процент совместимости между ПВК', key: 'compatibility', width: 10 }
            ];

            let pvks = Object.keys(usersData[userId][0]);
            pvks.forEach(profession => {
                worksheet.addRow({
                    'pvk': profession,
                    'user_id': userId,
                    'compatibility': usersData[userId][0][profession],
                    'intercompatibility': usersData[userId][1] ? usersData[userId][1][profession] : 'N/A'
                });
            });
        });

        await workbook.xlsx.writeFile('temp/Без ChatGPT ПВК.xlsx');

        res.download('temp/Без ChatGPT ПВК.xlsx', (err) => {
            if (err) throw err;
            fs.unlinkSync('temp/Без ChatGPT ПВК.xlsx');
        });
    } catch (err) {
        console.error('Error querying database:', err);
        res.status(500).send('Server error');
    }
});

module.exports = router
