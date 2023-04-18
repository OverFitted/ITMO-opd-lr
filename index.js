const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const homeRoutes = require('./routes/home');
const addRoutes = require('./routes/add');
const adminRoutes = require('./routes/admin');
const labRoutes = require('./routes/lab');
const app = express();

const hbs = exphbs.create({
    defaultLayout: 'main',
    extname: 'hbs',
    helpers: require('./config/handlebars-helpers')
});

app.engine('hbs', hbs.engine);

app.set('view engine', 'hbs');
app.set('views', 'views');

app.use(express.json({
    extended: false
}));

app.use(express.urlencoded({
    extended: true
}));

app.use(express.static('public'));
app.use(morgan('dev'))
app.use('/', homeRoutes);
app.use('/add', addRoutes);
app.use('/admin', adminRoutes);
app.use('/labs', labRoutes);

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
    console.log('Server running at port: ' + PORT);
});
