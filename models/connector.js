const {
    Client
} = require('pg')

const client = new Client({
    user: 'graevsky',
    host: 'localhost',
    database: 'cm',
    password: '1234',
    port: 5432,
})
client.connect()

module.exports = client
