/*Task 1*/
DECLARE @name CHAR(30)
GO

/*Task 2*/
DECLARE @team_id INT,
        @player_name CHAR(30),
        @max_avg FLOAT
SELECT @team_id = team_id FROM teams WHERE city = 'Portland'
SELECT @max_avg = MAX(average) FROM batters WHERE team = @taem_id
SELECT @player_name = name FROM batters WHERE average = @max_avg
PRINT @player_name
GO

/*Task 3*/
DECLARE @team_id INT,
        @player_name CHAR(30),
        @max_avg FLOAT
SELECT @team_id = team_id FROM teams WHERE city = 'Portland'
SELECT @max_avg = MAX(average) FROM batters WHERE team = @taem_id
SELECT @player_name = name FROM batters WHERE average = @max_avg
IF (@max_avg > 0.300)
BEGIN
  PRINT @player_name
  PRINT 'Give this guy a raise.'
END
ELSE
BEGIN
  PRINT @player_name
  PRINT 'Come back when you are hitting better.'
END
GO

/*Task 4*/
DECLARE @count INT
SELECT @count = 1
WHILE (@count < 10)
BEGIN
    SELECT @count = @count + 1
    IF (@count = 8)
    BEGIN
        BREAK
    END
END

/*Task 5*/
SET ROWCOUNT 1
DECLARE @player CHAR(30)
CREATE TABLE temp_batters(
name CHAR(30),
team INT,
average FLOAT,
homeruns INT,
rbis INT)
INSERT temp_batters
SELECT * FROM batters
WHILE EXISTS (SELECT * FROM temp_batters)
BEGIN
    SELECT @player = name FROM temp_batters
    PRINT @player
    DELETE FROM temp_batters WHERE name = @player
END

/*Task 6*/
SELECT name, homeruns
FROM batters
COMPUTE SUM(homeruns)

/*Task 7*/
SELECT 'PayDate' = CONVERT(CHAR(15), paydate, 105)
FROM payment_table
WHERE customer_id = 012845