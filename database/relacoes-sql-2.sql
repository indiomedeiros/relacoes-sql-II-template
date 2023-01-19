-- Active: 1674131408368@@127.0.0.1@3306
-- pratica 1.1 Crie a tabela users

CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL, 
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    create_at TEXT DEFAULT(DATETIME('now', 'localtime')) NOT NULL
);

SELECT * FROM users;
SELECT DATETIME("now", "localtime");

DROP TABLE users;


-- pratica 1.2 Popule-a com pelo menos 3 pessoas
INSERT INTO users(id, name, email, password)
VALUES
("U001","Indio", "indio@gmail.com", "indio123"),
("U002","Vini", "vini@gmail.com", "vini123"),
("U003","Marcelo", "marcelo@gmail.com", "marcelo123");

DELETE FROM users;

-- pratica 2.1 Criar tabela de relação follows

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

SELECT * FROM follows;

--2.2 Sabendo que a tabela users possui 3 pessoas (A, B e C),
-- popule a tabela follows respeitando os seguintes requisitos:
-- Pessoa A segue B e C
-- Pessoa B segue A
-- Pessoa C não segue ninguém

INSERT INTO follows (follower_id, followed_id)
VALUES
("U001", "U002"),
("U001", "U003"),
("U002", "U001")
;


DELETE FROM follows;

-- pratica 2.2
-- Faça uma consulta com junção INNER JOIN entre as duas tabelas 
-- (follows.follower_id = users.id)
SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id
;


--pratica 3.1
-- Crie uma junção que possibilite a visualização das pessoas que não seguem ninguém.
-- O resultado também deve continuar incluindo as pessoas que seguem outras pessoas, ou seja, a interseção.
SELECT * FROM users 
LEFT JOIN follows
ON follows.follower_id = users.id
;

--PRATICA 3.2
-- Crie uma nova consulta que mantém o mesmo resultado anterior, mas também retorna o nome da pessoa seguida.
-- Remova as ambiguidades e aplique nomenclatura camelCase.
SELECT * FROM users 
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id
;

--removendo ambiguidades
SELECT 
users.id AS usersId,
users.name,
users.email,
users.password,
users.create_at AS createAt,
follows.follower_id AS followerId,
follows.followed_id AS followedId,
usersFollowed.name AS nameFollowed
 FROM users 
 JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id
;
