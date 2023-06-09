const cookieParser = require('cookie-parser');
const express = require('express');
const morgan = require('morgan');
const multer  = require('multer');
const exphbs = require('express-handlebars');
const aboutRoutes = require('./routes/about');
const homeRoutes = require('./routes/home');
const contactRoutes = require('./routes/contact');
const adminRoutes = require('./routes/admin');
const userRoutes = require('./routes/user');
const labRoutes = require('./routes/lab');
const app = express();
const upload = multer();

const hbs = exphbs.create({
    defaultLayout: 'main',
    extname: 'hbs',
    helpers: require('./config/handlebars-helpers')
});

app.engine('hbs', hbs.engine);

app.set('view engine', 'hbs');
app.set('views', 'views');

app.use(express.json({extended: false}));
app.use(express.urlencoded({extended: true}));
app.use(cookieParser())
app.use(express.static('public'));
app.use(morgan('dev'))
app.use(upload.array());

app.use('/', homeRoutes);
app.use('/about', aboutRoutes);
app.use('/contact', contactRoutes);
app.use('/admin', adminRoutes);
app.use('/user', userRoutes);
app.use('/labs', labRoutes);

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
    console.log('Server running at port: ' + PORT);
});
