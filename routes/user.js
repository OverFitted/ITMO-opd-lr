const User = require('../models/user');
const { Router } = require('express')
const CLIENT = require("../models/connector");
const router = Router()

async function getPresets() {
    try {
        const result = await CLIENT.query('SELECT * FROM presets');
        const presets = result.rows.map(row => ({
            lab_num: row.lab_id,
            presets: {
                preset_id: row.preset_id,
                test_num: row.test_in_lab_id,
                ...row.params,
            },
        }));

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
        const resp_res_raw = await CLIENT.query(`SELECT lr2_to_resp.respondent_id, lr2_to_resp.expert_id, lr2_to_resp.test_id, results_list_lr2.result_list, test_name_lr2.test_name FROM lr2_to_resp JOIN results_list_lr2 ON lr2_to_resp.result_id_lr2 = results_list_lr2.id join test_name_lr2 ON lr2_to_resp.test_id = test_name_lr2.test_id;`);
        const users = await CLIENT.query("select * from users");
        const result = await CLIENT.query(`select * from expert_profession_quality_lab1 where expert_id = ${req.cookies.usr_id}`);

        const user = await User.userById(req.cookies.usr_id);
        const groupedPresets = await getPresets();

        let resp_res;
        let resp_res_simple = [];
        let resp_res_hard = [];

        let rows = result.rows;
        let prof_rows = profs.rows;

        for (let i = 0; i < prof_rows.length; i++) {
            prof_rows[i]["pvks"] = rows.filter(x => x["profession_id"] === prof_rows[i]["id"]);
            for (let j = 0; j < prof_rows[i]["pvks"].length; j++) {
                prof_rows[i]["pvks"][j]["name"] = pvk_lab1.rows.find(x => x["id"] === prof_rows[i]["pvks"][j]["pvk_id"])["name"]
            }
        }

        resp_res = resp_res_raw.rows;
        for (let i = 0; i < resp_res.length; i++) {
            resp_res[i].result_list = resp_res[i].result_list.join("; ")
            if (resp_res[i].result_list.length === 2) {
                resp_res_simple.push(resp_res[i])
            } else {
                resp_res_hard.push(resp_res[i])
            }
        }

        res.status(200).render('settings', {
            title: "Настройки | Без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            user: user,
            rows: prof_rows,
            resp_res: resp_res,
            resp_res_simple: resp_res_simple,
            resp_res_hard: resp_res_hard,
            users: users.rows,
            presets: groupedPresets
        })
    } catch (err) {
        next(err);
    }
});

router.get("/presets", async (req, res, next) => {
    try {
        const groupedPresets = await getPresets();

        res.status(200).render('presets', {
            title: "Пресеты | Без CHATGPT",
            isLoggedIn: req.cookies.usr_id,
            presets: groupedPresets
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

    const params = {
        preset_name: preset.preset_name,
        test_num: preset.test_num,
        runtime: preset.runtime,
        show_time: preset.show_time === 'true',
        show_stats: preset.show_stats === 'true',
        speed_koef: parseFloat(preset.speed_koef),
        acceleration_koef: parseFloat(preset.acceleration_koef),
    };

    const query = {
        text: 'INSERT INTO presets(lab_id, test_in_lab_id, params) VALUES($1, $2, $3)',
        values: [preset.lab_num, preset.test_num, params],
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

module.exports = router
