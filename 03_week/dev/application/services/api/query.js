var sql =     "CREATE TABLE IF NOT EXISTS users(id VARCHAR(20), user_name VARCHAR(20),first_name VARCHAR(20),bio VARCHAR(200)); \
     CREATE TABLE IF NOT EXISTS threads(id VARCHAR(20), title VARCHAR(100), created_by VARCHAR(20)); \
     CREATE TABLE IF NOT EXISTS posts(thread VARCHAR(20),content VARCHAR(100), user VARCHAR(20)); \
     INSERT INTO users VALUES ('1','marceline','Marceline Abadeer','1000 year old vampire queen, musicianmile'); \
     INSERT INTO users VALUES ('2','finn','Finn the Human', 'Adventurer and hero, last human, defender of good'); \
     INSERT INTO threads VALUES ('3', 'In search of a new guitar', '1'); \
     INSERT INTO threads VALUES ('1','Party at the candy kingdom tomorrow', '1'); \
     INSERT INTO threads VALUES ('2','What is up with the Lich?', '2'); \
     INSERT INTO posts VALUES ('1', 'It is no use going back to yesterday, because I was a different person then', '1'); \
     INSERT INTO posts VALUES ('2', 'Curiouser and curiouser!', '1'); \
     INSERT INTO posts VALUES ('3', 'I do not think --Then you should not talk.', '2'); \
     INSERT INTO posts VALUES ('1', 'It would have made a dreadfully ugly child; but it makes rather a handsome pig.', '1');"; 

exports.sql = sql;