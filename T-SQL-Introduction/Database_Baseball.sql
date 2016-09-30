CREATE DATABASE baseball ON default
GO

---Table Batters---
USE baseball
GO
CREATE TABLE batters (
name CHAR(30),
team INT,
average FLOAT,
homeruns int,
RBIS int)
GO

---Table Pitchers---
USE baseball
GO
CREATE TABLE pitchers (
name CHAR(30),
team INT,
won INT,
lost INT,
era FLOAT)
GO

---Table Teams---
USE baseball
GO
CREATE TABLE teams (
team_id INT,
city CHAR(30),
name CHAR(30),
won INT,
lost INT,
total_home_attendance INT,
avg_home_attendance INT)
go

---Inser into Batters---
INSERT INTO batters VALUES
('Billy Brewster', 1, 0.275, 14, 46 ),
('John Jackson', 1, 0.293, 2, 29),
('Phil Hartman', 1, 0.221, 13, 21),
('Jim Gehardy', 2, 0.316, 29, 84 ),
('Tom Trawick', 2, 0.258, 3, 51 ),
('Eric Redstone', 2, 0.305, 0, 28 );

---Inser into Pitchers---
INSERT INTO pitchers VALUES
('Tom Madden', 1, 7, 5, 3.46),
('Bill Witter', 1, 8, 2, 2.75),
('Jeff Knox', 2, 2, 8, 4.82),
('Hank Arnold', 2, 13, 1, 1.93),
('Tim Smythe', 3, 4, 2, 2.76);

---Inser into Teams---
INSERT INTO teams VALUES
(1, 'Portland', 'Beavers', 72, 63, 1226843, 19473),
(2, 'Washington', 'Represe ntatives', 50, 85, 941228, 14048),
(3, 'Tampa', 'Sharks', 90, 36, 2028652, 30278);