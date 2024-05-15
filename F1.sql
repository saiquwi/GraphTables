USE master;

DROP DATABASE IF EXISTS Formula1;
CREATE DATABASE Formula1;
USE Formula1;



--Задание 1.
--Узел Гонщик
CREATE TABLE Driver
(
	driverId INT IDENTITY NOT NULL PRIMARY KEY,
	surname NVARCHAR(50) NOT NULL,
	[name] NVARCHAR(50) NOT NULL 
) AS NODE;
--Узел Страна
CREATE TABLE Country
(
	countryId INT IDENTITY NOT NULL PRIMARY KEY,
	[name] NVARCHAR(50) NOT NULL 
) AS NODE;
--Узел Команда
CREATE TABLE Team
(
	teamId INT IDENTITY NOT NULL PRIMARY KEY,
	[name] NVARCHAR(50) NOT NULL 
) AS NODE;
--Узел Гонка
CREATE TABLE Race
(
	raceId INT IDENTITY NOT NULL PRIMARY KEY,
	[name] NVARCHAR(50) NOT NULL,
	raceDate DATE NOT NULL,
) AS NODE;



--Задание 2.
--Ребро Родился в (связь гонщик родился в стране)
CREATE TABLE BornIn AS EDGE;
ALTER TABLE BornIn ADD CONSTRAINT EC_BornIn CONNECTION (Driver TO Country);
--Ребро Выступает за (связь гонщик выступает за команду)
CREATE TABLE RacesFor AS EDGE;
ALTER TABLE RacesFor ADD CONSTRAINT EC_RacesFor CONNECTION (Driver TO Team);
--Ребро Основана в (связь команда основана в стране)
CREATE TABLE FoundIn AS EDGE;
ALTER TABLE FoundIn ADD CONSTRAINT EC_FoundIn CONNECTION (Team TO Country);
--Ребро Проводится в (связь гонка проводится в стране)
CREATE TABLE HeldIn AS EDGE;
ALTER TABLE HeldIn ADD CONSTRAINT EC_HeldIn CONNECTION (Race TO Country);
--Ребро Победил в (связь гонщик победил в гонке)
CREATE TABLE WonIn AS EDGE;
ALTER TABLE WonIn ADD CONSTRAINT EC_WonIn CONNECTION (Driver TO Race);
--Ребро Дружит с (связь один гонщик дружит с другим гонщиком)
CREATE TABLE FriendsWith AS EDGE;
ALTER TABLE FriendsWith ADD CONSTRAINT EC_FriendsWith CONNECTION (Driver TO Driver);



--Задание 3. Заполнение узлов
INSERT INTO Driver(surname,[name])
VALUES (N'Леклер', N'Шарль'),
	   (N'Сайнс', N'Карлос'),
	   (N'Норрис', N'Ландо'),
	   (N'Пиастри', N'Оскар'),
	   (N'Ферстаппен', N'Макс'),
	   (N'Перес', N'Серхио'),
	   (N'Алонсо', N'Фернандо'),
	   (N'Стролл', N'Лэнс'),
	   (N'Хэмильтон', N'Льюис'),
	   (N'Рассел', N'Джордж'),
	   (N'Албон', N'Алекс'),
	   (N'Сарджент', N'Логан');
SELECT * FROM Driver;

INSERT INTO Country([name])
VALUES (N'Монако'),
	   (N'Испания'),
	   (N'Великобритания'),
	   (N'Австралия'),
	   (N'Нидерланды'),
	   (N'Мексика'),
	   (N'Канада'),
	   (N'Таиланд'),
	   (N'США'),
	   (N'Италия'),
	   (N'Австрия'),
	   (N'Германия'),
	   (N'Бахрейн'),
	   (N'Саудовская Аравия'),
	   (N'Япония'),
	   (N'Китай'),;
SELECT * FROM Country;

INSERT INTO Team([name])
VALUES (N'Феррари'),
	   (N'Макларен'),
	   (N'Ред Булл'),
	   (N'Астон Мартин'),
	   (N'Мерседес'),
	   (N'Вильямс');
SELECT * FROM Team;

INSERT INTO Race([name], raceDate)
VALUES (N'Сахир', '2024-03-02'),
	   (N'Джидда', '2024-03-09'),
	   (N'Мельбурн', '2024-03-24'),
	   (N'Сузука', '2024-04-07'),
	   (N'Шанхай', '2024-04-21'),
	   (N'Майами', '2024-05-05');
SELECT * FROM Race;



--Задание 4. Заполнение рёбер
INSERT INTO BornIn($from_id, $to_id)
VALUES ((SELECT $node_id FROM Driver WHERE driverId = 1), (SELECT $node_id FROM	Country WHERE countryId = 1)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 2), (SELECT $node_id FROM Country WHERE countryId = 2)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 3), (SELECT $node_id FROM Country WHERE countryId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 4), (SELECT $node_id FROM Country WHERE countryId = 4)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 5), (SELECT $node_id FROM	Country WHERE countryId = 5)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 6), (SELECT $node_id FROM Country WHERE countryId = 6)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 7), (SELECT $node_id FROM Country WHERE countryId = 2)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 8), (SELECT $node_id FROM Country WHERE countryId = 7)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 9), (SELECT $node_id FROM	Country WHERE countryId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 10), (SELECT $node_id FROM Country WHERE countryId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 11), (SELECT $node_id FROM Country WHERE countryId = 8)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 12), (SELECT $node_id FROM Country WHERE countryId = 9));
SELECT * FROM BornIn;

INSERT INTO RacesFor($from_id, $to_id)
VALUES ((SELECT $node_id FROM Driver WHERE driverId = 1), (SELECT $node_id FROM Team WHERE teamId = 1)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 2), (SELECT $node_id FROM Team WHERE teamId = 1)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 3), (SELECT $node_id FROM Team WHERE teamId = 2)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 4), (SELECT $node_id FROM Team WHERE teamId = 2)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 5), (SELECT $node_id FROM	Team WHERE teamId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 6), (SELECT $node_id FROM Team WHERE teamId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 7), (SELECT $node_id FROM Team WHERE teamId = 4)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 8), (SELECT $node_id FROM Team WHERE teamId = 4)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 9), (SELECT $node_id FROM	Team WHERE teamId = 5)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 10), (SELECT $node_id FROM Team WHERE teamId = 5)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 11), (SELECT $node_id FROM Team WHERE teamId = 6)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 12), (SELECT $node_id FROM Team WHERE teamId = 6));
SELECT * FROM RacesFor;

INSERT INTO FoundIn($from_id, $to_id)
VALUES ((SELECT $node_id FROM Team WHERE teamId = 1), (SELECT $node_id FROM	Country WHERE countryId = 10)),
	   ((SELECT $node_id FROM Team WHERE teamId = 2), (SELECT $node_id FROM Country WHERE countryId = 3)),
	   ((SELECT $node_id FROM Team WHERE teamId = 3), (SELECT $node_id FROM Country WHERE countryId = 11)),
	   ((SELECT $node_id FROM Team WHERE teamId = 4), (SELECT $node_id FROM Country WHERE countryId = 3)),
	   ((SELECT $node_id FROM Team WHERE teamId = 5), (SELECT $node_id FROM	Country WHERE countryId = 12)),
	   ((SELECT $node_id FROM Team WHERE teamId = 6), (SELECT $node_id FROM Country WHERE countryId = 3));
SELECT * FROM FoundIn;

INSERT INTO HeldIn($from_id, $to_id)
VALUES ((SELECT $node_id FROM Race WHERE raceId = 1), (SELECT $node_id FROM Country WHERE countryId = 13)),
	   ((SELECT $node_id FROM Race WHERE raceId = 2), (SELECT $node_id FROM Country WHERE countryId = 14)),
	   ((SELECT $node_id FROM Race WHERE raceId = 3), (SELECT $node_id FROM Country WHERE countryId = 4)),
	   ((SELECT $node_id FROM Race WHERE raceId = 4), (SELECT $node_id FROM Country WHERE countryId = 15)),
	   ((SELECT $node_id FROM Race WHERE raceId = 5), (SELECT $node_id FROM	Country WHERE countryId = 16)),
	   ((SELECT $node_id FROM Race WHERE raceId = 6), (SELECT $node_id FROM Country WHERE countryId = 9));
SELECT * FROM HeldIn;

INSERT INTO WonIn($from_id, $to_id)
VALUES ((SELECT $node_id FROM Driver WHERE driverId = 5), (SELECT $node_id FROM Race WHERE raceId = 1)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 5), (SELECT $node_id FROM Race WHERE raceId = 2)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 2), (SELECT $node_id FROM Race WHERE raceId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 5), (SELECT $node_id FROM Race WHERE raceId = 4)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 5), (SELECT $node_id FROM Race WHERE raceId = 5)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 3), (SELECT $node_id FROM Race WHERE raceId = 6));
SELECT * FROM WonIn;

INSERT INTO FriendsWith($from_id, $to_id)
VALUES ((SELECT $node_id FROM Driver WHERE driverId = 5),(SELECT $node_id FROM Driver WHERE driverId = 1)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 1),(SELECT $node_id FROM Driver WHERE driverId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 1),(SELECT $node_id FROM Driver WHERE driverId = 9)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 3),(SELECT $node_id FROM Driver WHERE driverId = 2)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 11),(SELECT $node_id FROM Driver WHERE driverId = 1)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 11),(SELECT $node_id FROM Driver WHERE driverId = 12)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 12),(SELECT $node_id FROM Driver WHERE driverId = 4)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 4),(SELECT $node_id FROM Driver WHERE driverId = 3)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 10),(SELECT $node_id FROM Driver WHERE driverId = 11)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 10),(SELECT $node_id FROM Driver WHERE driverId = 7)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 7),(SELECT $node_id FROM Driver WHERE driverId = 8)),
	   ((SELECT $node_id FROM Driver WHERE driverId = 8),(SELECT $node_id FROM Driver WHERE driverId = 6));
SELECT * FROM FriendsWith;


--Задание 5.

--За какую команду выступает гонщик
SELECT (D.[name] + ' ' + D.surname) AS driver, T.[name] AS team
FROM Driver as D, RacesFor, Team as T
WHERE MATCH(D-(RacesFor)->T) AND D.surname = N'Леклер';

--Какие гонщики выступают за команду
SELECT (D.[name] + ' ' + D.surname) AS driver, T.[name] AS team
FROM Driver as D, RacesFor, Team as T
WHERE MATCH(T<-(RacesFor)-D) AND T.[name] = N'Астон Мартин';

--Из какой команды победивший в какой гонке гонщик
SELECT (D.[name] + ' ' + D.surname + N' выиграл	гонку ' + R.[name]) AS Level1
		, (D.[name] + ' ' + D.surname + N' выступает за команду ' + T.[name]) AS Level2
FROM Driver AS D, Race AS R,Team AS T, RacesFor, WonIn 
WHERE MATCH(T<-(RacesFor)-D-(WonIn)->R) AND D.surname = N'Ферстаппен';

--В какой стране основана команда, за которую выступает гонщик
SELECT (D.[name] + ' ' + D.surname + N' выступает за команду ' + T.[name]) AS Level1
	   , (T.[name] + N' основан в стране ' + C.[name]) AS Level2
FROM Driver AS D, Country AS C,Team AS T, RacesFor, FoundIn 
WHERE MATCH(D-(RacesFor)->T-(FoundIn)->C) AND D.surname = N'Хэмильтон';

--Из какой страны сокомандник гонщика
SELECT (d1.[name] + ' ' + d1.surname) AS driver
	   , t.[name] AS team
	   , (d2.[name] + ' ' + d2.surname) AS teammate
	   , c.[name] AS [teammate born in]
FROM Driver AS d1
	 , Driver AS d2
	 , Country AS c
	 , Team AS t
	 , RacesFor AS RacesFor1
	 , RacesFor AS RacesFor2
	 , BornIn 
WHERE MATCH(d1-(RacesFor1)->t<-(RacesFor2)-d2-(BornIn)->c) 
	  AND d1.surname = N'Сарджент' 
	  AND d1.surname != d2.surname;

--Какие гонщики выступают за команду, основанную в стране, где они родились
SELECT (d.[name] + ' ' + d.surname) AS driver
	   , t.[name] AS team
	   , c.[name] AS country
FROM Driver AS d
	 , Country AS c
	 , Team AS t
	 , RacesFor
	 , BornIn 
	 , FoundIn
WHERE MATCH(d-(RacesFor)->t-(FoundIn)->c
			AND d-(BornIn)->c)



--Задание 6.

--1)
SELECT d1.[name] + ' ' + d1.surname AS driver
	   , STRING_AGG(d2.[name] + ' ' + d2.surname, '->') WITHIN GROUP (GRAPH PATH) AS friends
FROM Driver AS d1
	 , Driver FOR PATH AS d2
	 , FriendsWith FOR PATH AS fw
WHERE MATCH(SHORTEST_PATH(d1(-(fw)->d2)+))
	  AND d1.surname = N'Рассел';

--2) Кратчайший путь от Джорджа Рассела до Ландо Норриса
WITH T1 AS
(
	SELECT d1.[name] + ' ' + d1.surname AS driver
	   , STRING_AGG(d2.[name] + ' ' + d2.surname, '->') WITHIN GROUP (GRAPH PATH) AS friends
	   , LAST_VALUE(d2.[name] + ' ' + d2.surname) WITHIN GROUP (GRAPH PATH) AS lastNode
FROM Driver AS d1
	 , Driver FOR PATH AS d2
	 , FriendsWith FOR PATH AS fw
WHERE MATCH(SHORTEST_PATH(d1(-(fw)->d2)+))
	  AND d1.surname = N'Рассел'
)
SELECT driver, friends
FROM T1
WHERE lastNode = N'Ландо Норрис';

--3)
SELECT d1.[name] + ' ' + d1.surname AS driver
	   , STRING_AGG(d2.[name] + ' ' + d2.surname, '->') WITHIN GROUP (GRAPH PATH) AS friends
FROM Driver AS d1
	 , Driver FOR PATH AS d2
	 , FriendsWith FOR PATH AS fw
WHERE MATCH(SHORTEST_PATH(d1(-(fw)->d2){1,3}))
	  AND d1.surname = N'Рассел';




--Сервер: Maya-comp\SQLEXPRESS
--База данных: Formula1
--https://github.com/saiquwi/img/blob/main/
SELECT @@SERVERNAME
SELECT d1.driverId AS idFirst
	   , d1.surname AS [first]
	   , CONCAT(N'driver',d1.driverId) AS [First image name]
	   , d2.driverId AS idSecond
	   , d2.surname AS [second]
	   , CONCAT(N'driver',d2.driverId) AS [Second image name]
FROM dbo.Driver as d1
	 , dbo.FriendsWith as f
	 , dbo.Driver as d2
WHERE MATCH(d1-(f)->d2)


SELECT d.driverId AS idFirst
	   , d.surname AS [first]
	   , CONCAT(N'driver',d.driverId) AS [First image name]
	   , c.countryId AS idSecond
	   , c.[name] AS [second]
	   , CONCAT(N'country',c.countryId) AS [Second image name]
FROM dbo.Driver as d
	 , dbo.BornIn as b
	 , dbo.Country AS c
WHERE MATCH(d-(b)->c)


SELECT d.driverId AS idFirst
	   , d.surname AS [first]
	   , CONCAT(N'driver',d.driverId) AS [First image name]
	   , t.teamId AS idSecond
	   , t.[name] AS [second]
	   , CONCAT(N'team',t.teamId) AS [Second image name]
FROM dbo.Driver as d
	 , dbo.RacesFor as r
	 , dbo.Team AS t
WHERE MATCH(d-(r)->t)