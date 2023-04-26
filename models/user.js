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

        if (this.usr_id in body) {
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

    async getById(usr_id = 0) {
        try {
            const query = {
                text: 'SELECT * FROM users WHERE usr_id = $1',
                values: [usr_id],
            }

            const result = await CLIENT.query(query)

            if (result.rows.length === 0) {
                throw new Error(`No user found with usr_id ${usr_id}`)
            }

            return result.rows[0]
        } catch (error) {
            throw error
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
                throw new Error(`No user found with usr_id ${usr_id}`)
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
                throw new Error(`No user found with usr_id ${usr_id}`)
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
}

module.exports = User