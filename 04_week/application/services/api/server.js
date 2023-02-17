var koa = require('koa');
var router = require('koa-router');
const render = require('koa-ejs');
const serve = require('koa-static');
const { createConnection } = require('mysql2');
const sql = require('./query');
const { join } = require('path');

var app = new koa();
var router = new router();

render(app, {
  root: join(__dirname, 'views'),
  layout: 'layout',
  viewExt: 'ejs',
  cache: false,
  debug: true
});

var connection = createConnection({
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
app.use(async (ctx, next) => {
  try {
    const start = new Date;
    await next();
    const ms = new Date - start;
    console.log('%s %s - %s', ctx.method, ctx.url, ms);
  } catch (err) {
    ctx.body = { message: err.message }
    ctx.status = err.status || 500
  }
});

async function initDB() {
  try {
    const users = await connection.promise().query('SHOW TABLES LIKE "users"');
    if ( ! users[0].length ) {
      console.log('DB tables not initialized. Populating the DB.');
      await connection.promise().query(sql);
    } 
  } catch (error) {
    console.error(error);
  }
}

async function getInfo(data){
  var sql = "SELECT * FROM " + data
  const results = await connection.promise().query(sql)
  return results[0];
}

router.get('/api/initDB', async function () {
  try {
    await initDB();
    let message = "DB successfully initialized";
    console.log(message);
    await this.render("initDB", { message });
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/users', async function () {
  try {
    queryResults = await getInfo("users");
    console.log(queryResults);
    await this.render("users", {query: "users", queryResults: queryResults });
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/users/:userId', async function () {
  const id = parseInt(this.params.userId);
  console.log(this.params)
  console.log("User id " + id)
  try {
    queryResults = await getInfo("users WHERE id=" + id);
    await this.render("users", {query: "users WHERE id=" + id, queryResults: queryResults });
    console.log(queryResults);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/threads', async function () {
  try {
    queryResults = await getInfo("threads");
    await this.render("threads", { query: "threads", queryResults: queryResults });
    console.log(queryResults);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/threads/:threadId', async function () {
  const id = parseInt(this.params.threadId);
  try {
    queryResults = await getInfo("threads WHERE id=" + id);
    await this.render("threads", { query: "threads WHERE id=" + id, queryResults: queryResults });
    console.log(queryResults);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/posts', async function () {
  try {
    queryResults = await getInfo("posts");
    await this.render("posts", { query: "posts", queryResults: queryResults });
    console.log(queryResults);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/posts/in-thread/:threadId', async function () {
  const id = parseInt(this.params.threadId);
  try {
    queryResults = await getInfo("posts WHERE thread=" + id);
    await this.render("posts", { query: "posts WHERE thread=" + id, queryResults: queryResults });
    console.log(queryResults);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/posts/by-user/:userId', async function () {
  const id = parseInt(this.params.userId);
  try {
    queryResults = await getInfo("posts WHERE user=" + id);
    await this.render("posts", { query: "posts WHERE user=" + id, queryResults: queryResults });
    console.log(queryResults);
  } catch (error) {
    console.error(error);
  }
});

router.get('/api/', async function () {
  let message = "Ready to receive requests";
  console.log(message);
  await this.render("ready", { message: message });
});

app.use(router.routes());
app.use(router.allowedMethods());
app.use(serve("./public"));

app.use(async (ctx) => {
  let message = "Non-supported API.";
  await ctx.render("ready", { message: message });
});
app.listen(3000);

console.log('Worker started');
