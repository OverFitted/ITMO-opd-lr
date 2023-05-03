const CLIENT = require('../models/connector');
const uuid = require('uuid');

class User {
    constructor(body) {
        this.usrname = body.login
        this.name = body.name
        this.surname = body.surname
        this.passwd = body.password
        this.email = body.email
        this.age = parseInt(body.age)
        this.is_expert = body.exper === "on";
        this.gender = body.gender === "male" ? "M" : "F";

        if ("usr_id" in body) {
            this.usr_id = body.usr_id
        } else {
            this.usr_id = this.toHash(uuid.v4())
        }
    }

    toHash(usr_id) {
        var hash = 0,
            i, chr;
        if (usr_id.length === 0) return hash;
        for (i = 0; i < usr_id.length; i++) {
            chr = usr_id.charCodeAt(i);
            hash = ((hash << 5) - hash) + chr;
            hash |= 0;
        }
        return hash;
    }

    toJSON() {
        return {
            usrname: this.usrname,
            name: this.name,
            surname: this.surname,
            passwd: this.passwd,
            email: this.email,
            age: this.age,
            is_expert: this.is_expert,
            gender: this.gender,
            usr_id: this.usr_id
        }

    }

    async changeData(body) {
        try {
            this.usrname = body.login || this.usrname;
            this.name = body.name || this.name;
            this.surname = body.surname || this.surname;
            this.passwd = body.password || this.passwd;
            this.email = body.email || this.email;
            this.age = body.age ? parseInt(body.age) : this.age;
            this.is_expert = body.exper !== undefined ? body.exper === "on" : this.is_expert;
            this.gender = body.gender ? (body.gender === "male" ? "M" : "F") : this.gender;

            const query = {
                text: 'UPDATE users SET usrname = $1, name = $2, surname = $3, passwd = $4, email = $5, age = $6, is_expert = $7, gender = $8 WHERE usr_id = $9',
                values: [this.usrname, this.name, this.surname, this.passwd, this.email, this.age, this.is_expert, this.gender, this.usr_id],
            };

            await CLIENT.query(query);

            return true
        } catch (error) {
            throw error;
        }
    }

    static async userById(usr_id = 0) {
        try {
            const query = {
                text: 'SELECT * FROM users WHERE usr_id = $1',
                values: [usr_id],
            }

            const result = await CLIENT.query(query)

            if (result.rows.length === 0) {
                return null;
            }

            return result.rows[0]
        } catch (error) {
            throw error
        }
    }

    static async userByLogin(login, password) {
        try {
            const query = {
                text: 'SELECT * FROM users WHERE usrname = $1 and passwd = $2',
                values: [login, password],
            }

            const result = await CLIENT.query(query)

            if (result.rows.length === 0) {
                return null;
            }

            return result.rows[0]
        } catch (error) {
            throw error
        }
    }

    async saveToSQL(usr_id = 0) {
        if (usr_id === 0) {
            var data = this.toJSON()
        } else {
            var data = await this.getById(usr_id = usr_id)
        }

        const query = {
            text: 'INSERT INTO users (usr_id, name, surname, usrname, passwd, email, age, is_expert, gender) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)',
            values: [data.usr_id, data.name, data.surname, data.usrname, data.passwd, data.email, data.age, data.is_expert, data.gender],
        }

        await CLIENT.query(query)
    }

    sendResult(results) {
        var data = this.toJSON()

        if ("averageResult" in results) {
            var res_query = {
                text: 'INSERT INTO results_list_lr2 (result_list) VALUES ($1) RETURNING id',
                values: [
                    [Math.floor(results.averageResult)]
                ],
            }
        } else {
            var res_query = {
                text: 'INSERT INTO results_list_lr2 (result_list) VALUES ($1) RETURNING id',
                values: [
                    [Math.floor(results.averagePositiveResult), Math.floor(results.averageNegativeResult)]
                ],
            }
        }

        CLIENT.query(res_query).then((res) => {
            var id = res.rows[0].id

            const query = {
                text: 'INSERT INTO lr2_to_resp (respondent_id, result_id_lr2, test_id) VALUES ($1, $2, $3)',
                values: [data.usr_id, id, results.test_id],
            }
            CLIENT.query(query).then((result) => {
                console.log(result)
            })
        })
    }
}

module.exports = User