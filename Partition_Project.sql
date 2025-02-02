-- Step 1: Create the main partitioned table by release_date
CREATE TABLE steam_games (
    appid INT,
    name TEXT NOT NULL,
    release_date DATE NOT NULL,
	english TEXT,
    developer TEXT,
    publisher TEXT,
	platforms TEXT,
	required_age TEXT,
	categories TEXT,
    genres TEXT NOT NULL,
	steamspy_tags TEXT,
	achievements TEXT,
    positive_ratings INT,
    negative_ratings INT,
    average_playtime INT NOT NULL,
    median_playtime INT,
    owners TEXT NOT NULL,
	price DECIMAL(10,2) NOT NULL,			 
    PRIMARY KEY (appid, release_date, price, average_playtime, owners)
) PARTITION BY RANGE (release_date);

-- Step 2: Create partitions based on release_date
CREATE TABLE steam_games_1990s 
PARTITION OF steam_games
FOR VALUES FROM ('1990-01-01') TO ('2000-01-01') 
PARTITION BY RANGE (price);

CREATE TABLE steam_games_2000s 
PARTITION OF steam_games
FOR VALUES FROM ('2000-01-01') TO ('2010-01-01') 
PARTITION BY RANGE (price);

CREATE TABLE steam_games_2010s 
PARTITION OF steam_games
FOR VALUES FROM ('2010-01-01') TO ('2020-01-01') 
PARTITION BY RANGE (price);



-- Step 3:price-based partitions 
-- Free
CREATE TABLE steam_games_1990s_free 
PARTITION OF steam_games_1990s
FOR VALUES FROM (0) TO (0.1) 
PARTITION BY RANGE (average_playtime);

CREATE TABLE steam_games_2000s_free 
PARTITION OF steam_games_2000s
FOR VALUES FROM (0) TO (0.1) 
PARTITION BY RANGE (average_playtime);

CREATE TABLE steam_games_2010s_free 
PARTITION OF steam_games_2010s
FOR VALUES FROM (0) TO (0.1) 
PARTITION BY RANGE (average_playtime);

-- Paid

CREATE TABLE steam_games_1990s_paid 
PARTITION OF steam_games_1990s
FOR VALUES FROM (0.1) TO (1000) 
PARTITION BY RANGE (average_playtime);


CREATE TABLE steam_games_2000s_paid 
PARTITION OF steam_games_2000s
FOR VALUES FROM (0.1) TO (1000) 
PARTITION BY RANGE (average_playtime);


CREATE TABLE steam_games_2010s_paid 
PARTITION OF steam_games_2010s
FOR VALUES FROM (0.1) TO (1000) 
PARTITION BY RANGE (average_playtime);


-- Step 4:partitions for most/least played games 
--inside each price category
-- Free
CREATE TABLE steam_games_1990s_free_least_played 
PARTITION OF steam_games_1990s_free
FOR VALUES FROM (0) TO (10000); 

CREATE TABLE steam_games_1990s_free_most_played 
PARTITION OF steam_games_1990s_free
FOR VALUES FROM (10000) TO (999999999); 

CREATE TABLE steam_games_2000s_free_least_played 
PARTITION OF steam_games_2000s_free
FOR VALUES FROM (0) TO (10000); 

CREATE TABLE steam_games_2000s_free_most_played 
PARTITION OF steam_games_2000s_free
FOR VALUES FROM (10000) TO (999999999); 

CREATE TABLE steam_games_2010s_free_least_played 
PARTITION OF steam_games_2010s_free
FOR VALUES FROM (0) TO (10000); 

CREATE TABLE steam_games_2010s_free_most_played 
PARTITION OF steam_games_2010s_free
FOR VALUES FROM (10000) TO (999999999); 

--Paid
CREATE TABLE steam_games_1990s_paid_least_played 
PARTITION OF steam_games_1990s_paid
FOR VALUES FROM (0) TO (10000); 


CREATE TABLE steam_games_1990s_paid_most_played 
PARTITION OF steam_games_1990s_paid
FOR VALUES FROM (10000) TO (999999999); 


CREATE TABLE steam_games_2000s_paid_least_played 
PARTITION OF steam_games_2000s_paid
FOR VALUES FROM (0) TO (10000); 


CREATE TABLE steam_games_2000s_paid_most_played 
PARTITION OF steam_games_2000s_paid
FOR VALUES FROM (10000) TO (999999999); 


CREATE TABLE steam_games_2010s_paid_least_played 
PARTITION OF steam_games_2010s_paid
FOR VALUES FROM (0) TO (10000); 


CREATE TABLE steam_games_2010s_paid_most_played 
PARTITION OF steam_games_2010s_paid
FOR VALUES FROM (10000) TO (999999999); 


-- how to import data

COPY steam_games(appid, name, release_date, english, developer, 
				 publisher, platforms, required_age, categories, 
				 genres, steamspy_tags,	achievements, positive_ratings, 
				 negative_ratings, average_playtime, median_playtime, 
				 owners, price) 
FROM 'C:\Program Files\PostgreSQL\17\steam.csv'
DELIMITER ',' CSV HEADER;

--Query to test performance with partition
EXPLAIN ANALYZE 
SELECT * FROM steam_games
WHERE release_date BETWEEN ('1990-01-01') AND ('2000-01-01');

