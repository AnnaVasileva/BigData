/*Task 1*/
SELECT model, speed MHz, hd GB
FROM laptop
WHERE price < 1200;

/*Task 2*/
SELECT model, (price * 1.1) AS price_in_euro
FROM laptop
ORDER BY price;

/*Task 3*/
SELECT model, ram, screen
FROM laptop
WHERE price > 1000;

/*Task 4*/
SELECT price
FROM printer
WHERE color = 'y';

/*Task 5*/
SELECT model, speed, hd
FROM pc
WHERE cd LIKE '%12x%'
OR
cd LIKE '%16x%'
AND price < 2000;

/*Task 6*/
SELECT code, model, (speed + ram + 10*screen) AS rating
FROM laptop
ORDER BY rating DESC;

/*Task 7*/
SELECT p.maker, l.speed
FROM laptop l
JOIN product p ON l.model = p.model
WHERE l.hd >= 9;

/*Task 8*/
SELECT p.maker
FROM product p
JOIN pc ON p.model = pc.model
WHERE speed >= 1000;

/*Task 9*/
SELECT *
FROM (SELECT code, price
      FROM printer
      ORDER BY price DESC)
WHERE ROWNUM <= 3;

/*Task 10*/
SELECT *
FROM (SELECT p.maker, pr.price
      FROM product p
      JOIN printer pr ON p.model = pr.model
      WHERE pr.color = 'y'
      ORDER BY pr.price DESC)
WHERE ROWNUM <= 1;

/*Task 11*/
SELECT AVG(speed)
FROM laptop;

/*Task 12*/
SELECT p.maker, AVG(l.screen) AS AVG_Screen
FROM laptop l
JOIN product p ON l.model = p.model
GROUP BY p.maker;

/*Task 13*/
SELECT AVG(speed)
FROM laptop
WHERE price > 1000;

/*Task 14*/
SELECT AVG(l.price)
FROM laptop l
JOIN product p ON l.model = p.model
WHERE p.maker = 'A';

/*Task 15*/
SELECT AVG(pc.price) AS AVG_PC_price, AVG(l.price) AS AVG_Laptop_price
FROM laptop l
RIGHT JOIN product p ON l.model = p.model
LEFT JOIN pc ON p.model = pc.model
WHERE p.maker = 'B';

/*Task 16*/
SELECT p.maker
FROM product p
JOIN pc ON p.model = pc.model
GROUP BY p.maker
HAVING COUNT(DISTINCT pc.model) >= 3;