const app = require('koa')();
const router = require('koa-router')();
var mysql = require('mysql2');
var query = require('./query');



var connection = mysql.createConnection({
  host     : process.env.RDS_HOSTNAME,
  user     : process.env.RDS_USERNAME,
  password : process.env.RDS_PASSWORD,
  port     : process.env.RDS_PORT,
  database : process.env.RDS_DBNAME,
  multipleStatements: true
});

connection.connect(function(err) {
  if (err) {
    console.error('Database connection failed: ' + err.stack);
    return;
  }
  console.log('Connected to database.');
});


// Log requests here
app.use(function *(next){
  const start = new Date;
  yield next;
  const ms = new Date - start;
  console.log('%s %s - %s', this.method, this.url, ms);
});

async function initDB() {
  var sql = query.sql;
  const results = await connection.promise().query(sql);
  console.log(results);
}

async function getInfo(data){
  var sql = "SELECT * FROM " + data
  const results = await connection.promise().query(sql)
  return results[0];
}

router.get('/api/initDB', async function () {
  try {
    await initDB();
    console.log("DB successfully initialized");
    this.body = "DB successfully initialized";
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/users', async function () {
  try {
    this.body = await getInfo("users");
    console.log(this.body);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/users/:userId', async function () {
  const id = parseInt(this.params.userId);
  console.log(this.params)
  console.log("User id " + id)
  try {
    this.body = await getInfo("users WHERE id=" + id);
    console.log(this.body);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/threads', async function () {
  try {
    this.body = await getInfo("threads");
    console.log(this.body);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/threads/:threadId', async function () {
  const id = parseInt(this.params.threadId);
  try {
    this.body = await getInfo("threads WHERE id=" + id);
    console.log(this.body);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/posts', async function () {
  try {
    this.body = await getInfo("posts");
    console.log(this.body);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/posts/in-thread/:threadId', async function () {
  const id = parseInt(this.params.threadId);
  try {
    this.body = await getInfo("posts WHERE thread=" + id);
    console.log(this.body);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/posts/by-user/:userId', async function () {
  const id = parseInt(this.params.userId);
  try {
    this.body = await getInfo("posts WHERE user=" + id);
    console.log(this.body);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/', function *() {
  this.body = "This API ready to receive requests";
});

router.get('/', function *() {
  this.body = "Ready to receive requests";
});

app.use(router.routes());
app.use(router.allowedMethods());

app.listen(3000);

console.log('Worker started');
