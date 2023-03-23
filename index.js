const express = require('express');
const morgan = require('morgan');
const homeRoutes = require('./routes/home');
const testRoutes = require('./routes/test');
const addTestRoutes = require('./routes/add');
const adminRoutes = require('./routes/admin');
const app = express();

app.use(express.json({
    extended: false
}));

app.use(express.urlencoded({
    extended: true
}));

app.use(express.static('public'));
app.use(morgan('dev'))
app.use('/', homeRoutes);
app.use('/add-test', addTestRoutes);
app.use('/test', testRoutes);
app.use('/admin', adminRoutes);

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
    console.log('Server running at port: ' + PORT);
});
