CREATE DATABASE IF NOT EXISTS les_3;

USE les_3;

DROP TABLE IF EXISTS staff;

CREATE TABLE staff
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    post VARCHAR(45) NOT NULL,
    seniority INT,
    salary DECIMAL(8,2),
    age INT
);

INSERT staff(firstname, lastname, post, seniority,salary,age)
VALUES 
	("Петр", "Петров", "Начальник", 8, 70000, 30),
	('Вася', 'Петров', 'Начальник', 40, 100000, 60),
	('Петр', 'Власов', 'Начальник', 8, 70000, 30),
	('Катя', 'Катина', 'Инженер', 2, 70000, 25),
	('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
	('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
	('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
	('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
	('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
	('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
	('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
	('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
	('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
    
SELECT * FROM staff;

/*
1. Отсортируйте данные по полю заработная плата (salary) в порядке: 
 - убывания; 
 - возрастания
*/ 

SELECT * 
FROM staff
ORDER BY salary;

SELECT * 
FROM staff
ORDER BY salary DESC;


-- 2. Выведите 5 максимальных заработных плат (saraly)

SELECT salary AS 'Максимальные зарплаты'
FROM staff
ORDER BY salary DESC LIMIT 5;


-- 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)

SELECT 
	post AS 'Должность',
	SUM(salary) AS 'Суммарная зарплата'
FROM staff
GROUP BY post;


-- 4. Найдите кол-во сотрудников со специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.

SELECT 
	post AS 'Должность', 
	COUNT(*) AS 'Количество сотрудников'
FROM staff
WHERE post = 'Рабочий' AND age BETWEEN 24 AND 49;


-- 5. Найдите количество специальностей

-- вариант 1:
SELECT COUNT(DISTINCT post) AS 'Количество должностей'
FROM staff;

-- вариант 2:
SELECT COUNT(*) AS 'Количество должностей'
FROM 
	(
    SELECT COUNT(post) 
	FROM staff
    GROUP BY post
    ) staff;


-- 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет

SELECT post AS 'Должность', ROUND(AVG(age)) AS 'Средний возраст'
FROM staff
GROUP BY post
HAVING AVG(age) <= 30; -- меньше 30 нет, поэтому '<= 30' лет


-- Доп: Внутри каждой должности вывести ТОП-2 по ЗП (2 самых высокооплачиваемых сотрудника по ЗП внутри каждой должности)

SELECT * 
FROM (
	SELECT *, RANK() OVER(PARTITION BY post ORDER BY salary DESC) num
    FROM staff
    )
X
WHERE num <= 2;

-- Начальников 3, так как на 2-м месте двое с одинаковой зарплатой 