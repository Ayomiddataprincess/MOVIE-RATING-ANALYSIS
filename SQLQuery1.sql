--To view dataset
SELECT*
FROM MOVIE_RATING

--changing runtime to integer to allow analysis to be carried out on runtime 
UPDATE MOVIE_RATING
SET runtime = REPLACE(runtime, 'min', '')
WHERE runtime LIKE '%min%';


UPDATE MOVIE_RATING
SET runtime = REPLACE(runtime, ',', '')
WHERE runtime LIKE '%,%';

-- Convert Runtime column to INT
ALTER TABLE MOVIE_RATING
ALTER COLUMN runtime INT;

--To determine duplicate values
SELECT DISTINCT(rating),lister_item_header,runtime,votes
FROM MOVIE_RATING
ORDER BY rating DESC

--To determine average rating across d movies
SELECT AVG (RATING)
FROM MOVIE_RATING

--Average votes across d movies
SELECT AVG (votes)
FROM MOVIE_RATING

--Top 10 movies with votes above d average votes
SELECT DISTINCT TOP 10 (rating),lister_item_header,runtime,votes
FROM MOVIE_RATING
WHERE votes >= (
                 SELECT AVG (votes)
			    FROM MOVIE_RATING
				);

--Top 5 movies with highest rating 
SELECT TOP 5 (votes),rating,genre,lister_item_header,runtime
FROM MOVIE_RATING
ORDER BY votes DESC 

--To determine average runtime
SELECT AVG (runtime)
FROM MOVIE_RATING

--Total no of movies that are drama
SELECT COUNT (lister_item_header)
FROM MOVIE_RATING
WHERE genre LIKE '%Drama%'

--Total no of movies that are comedy
SELECT COUNT (lister_item_header)
FROM MOVIE_RATING
WHERE genre LIKE '%Comedy%'


--Top rated movies in each genre
SELECT genre, lister_item_header, rating
FROM (
    SELECT genre, lister_item_header, rating,
           ROW_NUMBER() OVER (PARTITION BY genre ORDER BY rating DESC) AS rn
    FROM MOVIE_RATING
) ranked
WHERE rn = 1;

--Average rating and number of votes for each certificate category
SELECT certificate, AVG(rating) AS avg_rating, SUM(votes) AS total_votes
FROM MOVIE_RATING
GROUP BY certificate;