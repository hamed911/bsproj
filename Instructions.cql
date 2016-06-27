CREATE KEYSPACE weblog WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor':1};

USE weblog;

CREATE TABLE blogs (id uuid PRIMARY KEY, blog_name varchar,author varchar, email varchar,password varchar);

CREATE TABLE posts (id timeuuid, blog_id uuid, posted_on timestamp, title text, content text, tags set<varchar>, PRIMARY KEY(blog_id,id));

CREATE TABLE categories (cat_name varchar, blog_id uuid, post_id timeuuid, post_title text, PRIMARY KEY(cat_name, blog_id, post_id));

CREATE TABLE comments (id timeuuid, post_id timeuuid, title text, content text, posted_on timestamp, commenter varchar, PRIMARY KEY(post_id, id));

CREATE TABLE post_votes(post_id timeuuid PRIMARY KEY, upvotes counter, downvotes counter);

CREATE TABLE comment_votes(comment_id timeuuid PRIMARY KEY, upvotes counter, downvotes counter);

INSERT INTO blogs (id, blog_name, author, email, password) VALUES ( blobAsUuid(timeuuidAsBlob(now())), 'Random Ramblings', 'JRR Rowling', 'rowling@yahoo.com', 'someHashed#passwrd');

SELECT * FROM blogs;

INSERT INTO posts (id, blog_id, title, content, tags, posted_on) VALUES (now(), 516d6f30-3859-11e6-b90d-3beccf337c08,'first post', 'hey howdy!', {'random','welcome'}, 1407822921000);

SELECT * FROM posts;

INSERT INTO categories (cat_name, blog_id, post_id,post_title) VALUES ( 'welcome', 83cec740-22b1-11e4-a4f0-7f1a8b30f852,047224f0-22b2-11e4-a4f0-7f1a8b30f852, 'first post');

INSERT INTO posts (id, blog_id, title, content, tags, posted_on) VALUES (now(), 516d6f30-3859-11e6-b90d-3beccf337c08, 'Fooled by randomness', 'posterior=(prior*likelihood)/evidence', {'random','maths'},1407823189000);

INSERT INTO categories (cat_name, blog_id, post_id, post_title) VALUES ( 'random', 516d6f30-3859-11e6-b90d-3beccf337c08, eb8f7650-390b-11e6-b90d-3beccf337c08, 'Fooled by randomness');

INSERT INTO categories (cat_name, blog_id, post_id, post_title) VALUES ( 'maths', 516d6f30-3859-11e6-b90d-3beccf337c08, eb8f7650-390b-11e6-b90d-3beccf337c08, 'Fooled by randomness');

#Insert Comments

INSERT INTO comments (id, post_id, commenter, title, content, posted_on) VALUES (now(), 2628db50-385b-11e6-b90d-3beccf337c08, 'liz@gmail.com', 'Thoughful article but', 'It is too short to describe the complexity.', 1407868973000);

INSERT INTO comments (id, post_id, commenter, title, content, posted_on) VALUES (now(), 2628db50-385b-11e6-b90d-3beccf337c08,'tom@gmail.com', 'Nice!', 'Thanks, this is good stuff.', 1407868975000);

INSERT INTO comments (id, post_id, commenter, title, content, posted_on) VALUES (now(), 2628db50-385b-11e6-b90d-3beccf337c08,'g@ouv.com', 'Follow my blog', 'Please follow my blog.', 1407868979000);

INSERT INTO comments (id, post_id, commenter, title, content, posted_on) VALUES (now(), eb8f7650-390b-11e6-b90d-3beccf337c08, 'liz@gmail.com', 'New blogger?', 'Welcome to weblog application.',1407868981000);

UPDATE comment_votes SET upvotes = upvotes + 1 WHERE comment_id = 02e59fe0-390d-11e6-b90d-3beccf337c08;
UPDATE comment_votes SET downvotes = downvotes + 1 WHERE comment_id = 19960900-390d-11e6-b90d-3beccf337c08;
UPDATE post_votes SET upvotes = upvotes + 1 WHERE post_id = 2628db50-385b-11e6-b90d-3beccf337c08;

select * from posts where blog_id = 516d6f30-3859-11e6-b90d-3beccf337c08 order by id desc limit 2;
select * from comments where post_id = 2628db50-385b-11e6-b90d-3beccf337c08 order by id desc;
select * from comment_votes where comment_id = 19960900-390d-11e6-b90d-3beccf337c08;