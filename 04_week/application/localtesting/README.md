## Testing DB connectivity locally

```
cd localtesting
docker build -f Docker_mysql -t mysql_todo .
docker run -d -e MYSQL_ROOT_PASSWORD=pw -p 3306:3306 --name mysql_db mysql_todo
```

# To verify the DB is healthy

```
docker exec -it mysql_db bash 
```

# Inside MySQL container

```
mysql -p
mysql use todoapp;
SELECT * FROM users;
```

## Run the application locally

```
export RDS_HOSTNAME=localhost
export RDS_PORT=3306
export RDS_USERNAME=root
export RDS_DBNAME=todoapp
export RDS_PASSWORD=pw

cd ../services/api
node  server.js  
# The below command keeps CSS updated with the changes made in views
npx tailwindcss -i ./src/input.css -o ./public/styles/output.css --watch
```

### You should see

```
Worker started
Connected to database.
```

### Open another terminal and run the commands below

```
curl localhost:3000/api/initDB  # Make sure to run this command only once
curl localhost:3000/api/posts
curl localhost:3000/api/users
curl localhost:3000/api/user/1
curl localhost:3000/api/posts/by-user/1
curl localhost:3000/api/posts/in-thread/2
```
