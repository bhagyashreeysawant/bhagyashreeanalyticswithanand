--Create a table named spotify_data with the following structure:
DROP TABLE spotify_data;


CREATE TABLE spotify_data (
 playlist_url VARCHAR(100),
 `year` NUMBER(10),
 track_id VARCHAR(100),
 track_name VARCHAR(100),
 track_popularity NUMBER(10),
 album VARCHAR(100),
 artist_id VARCHAR(100),
 artist_name VARCHAR(100),
 artist_genres VARCHAR(200),
 artist_popularity NUMBER(10),
 danceability NUMBER(10),
 energy NUMBER(10),
 key NUMBER(10),
 loudness NUMBER(10),
 `mode` NUMBER(10),
 speechiness NUMBER(10),
 acousticness NUMBER(10),
 instrumentalness VARCHAR(100),
 liveness NUMBER(10),
 valence NUMBER(10),
 tempo NUMBER(10),
 duration_ms NUMBER(10),
 time_signature NUMBER(10));


-- QUE-1. Check the entire dataset

SELECT * FROM spotify_data ;

--QUE-2 Number of songs on Spotify for each artist
SELECT artist_name,count(track_id) FROM spotify_data GROUP BY artist_name;

--QUE-3 Top 10 songs based on popularity

SELECT TOP 10 track_name,track_popularity FROM spotify_data ORDER BY track_popularity DESC;

--QUE-4 Total number of songs on spotify based on year
SELECT `year`,COUNT(track_id) AS Totol_songs FROM spotify_data GROUP BY `year` ORDER BY `year`;

--QUE-5 Top song for each year (2000-2022) based on popularity

SELECT  MAX(track_name) AS top_song,`year`,MAX(track_popularity) AS max_popularity FROM spotify_data WHERE 
    `year` BETWEEN 2000 AND 2022 GROUP BY `year` ORDER BY `year` ,max_popularity DESC;

--QUE-6 Analysis based on Tempo : 
-- tempo > 121.08 -> 'Above Average Tempo'
-- tempo = 121.08 -> 'Average Tempo'
-- tempo < 121.08 -> 'Below Average Tempo'

SELECT track_name, tempo,
 CASE 
    WHEN tempo > 121.08 THEN 'Above Average Tempo'
    WHEN tempo = 121.08 THEN 'Average Tempo'
    ELSE 'Below Average Tempo'
 END AS tempo_category
 FROM spotify_data;

--QUE-7 Songs with Highest Tempo

SELECT MAX(track_name) AS max_track_name, MAX(tempo) AS max_tempo FROM spotify_data ORDER BY max_tempo DESC LIMIT 1;

--QUE-8. Number of Songs for different Tempo Range : track_name, energy
-- Modern_Music -> tempo BETWEEN 60.00 AND 100.00
-- Classical_Music -> tempo BETWEEN 100.001 AND 120.00
-- Dance_Music -> tempo BETWEEN 120.001 AND 150.01
-- HighTempo_Music -> tempo > 150.01

SELECT track_name, tempo,energy,
 CASE 
    WHEN tempo BETWEEN 60.00 AND 100.00 THEN 'Modern_Music'
    WHEN tempo BETWEEN 100.001 AND 120.00 THEN 'Classical_Music'
     WHEN tempo BETWEEN 120.001 AND 150.01 THEN 'Dance_Music'
     WHEN tempo > 150.01 THEN 'HighTempo_Music'
    END AS tempo_range
 FROM spotify_data;

 ---QUE-9 Energy Analysis : TOP 10 track_name, danceability, track_popularity
 --energy > 0.64 -> 'Above Average Energy 
-- energy = 0.64 -> 'Average Energy’ 
-- energy < 0.64 -> 'Below Average Energy’ 
-- energy BETWEEN 0.1 AND 0.3 -> 'Calm Music'
-- energy BETWEEN 0.3 AND 0.6 -> 'Moderate Music'
-- Energy >0.6 -> ‘Energetic Music'

SELECT TOP 10 track_name,energy,danceability, track_popularity,
 CASE 
    WHEN energy > 0.64 THEN 'Above Average Energy'
    WHEN energy = 0.64 THEN 'Average Energy'
    WHEN energy < 0.64 THEN 'Below Average Energy'
     WHEN energy BETWEEN 0.1 AND 0.3 THEN 'Calm Music'
     WHEN energy BETWEEN 0.3 AND 0.6  THEN 'Moderate Music'
     WHEN energy > 0.6 THEN 'Energetic Music'
    END AS energy_category
 FROM spotify_data
 ORDER BY track_popularity  DESC;

--QUE-10. Number of Songs for different energy ranges(above)


SELECT
    COUNT(*) AS num_songs,
    CASE 
        WHEN energy > 0.64 THEN 'Above Average Energy'
        WHEN energy = 0.64 THEN 'Average Energy'
        WHEN energy < 0.64 THEN 'Below Average Energy'
        WHEN energy BETWEEN 0.1 AND 0.3 THEN 'Calm Music'
        WHEN energy BETWEEN 0.3 AND 0.6 THEN 'Moderate Music'
        WHEN energy > 0.6 THEN 'Energetic Music'
    END AS energy_category
FROM spotify_data
GROUP BY energy_category
ORDER BY energy_category;

 --QUE-11  Danceability Analysis : Top 20 track_name, danceability
--danceability BETWEEN 0.69 AND 0.79 -> 'Low Danceability'
--(danceability BETWEEN 0.49 AND 0.68) OR (danceability BETWEEN 0.79 AND 0.89) -> 'Moderate Danceability'
--(danceability BETWEEN 0.39 AND 0.49) OR (danceability BETWEEN 0.89 AND 0.99) -> 'High Danceability'
--danceability < 0.39 OR danceability > 0.99 -> 'Cant Dance on this one'

 SELECT TOP 20 track_name,danceability,
    CASE
        WHEN danceability BETWEEN 0.69 AND 0.79 THEN 'Low Danceability'
        WHEN (danceability BETWEEN 0.49 AND 0.68) OR (danceability BETWEEN 0.79 AND 0.89) THEN 'Moderate Danceability'
        WHEN (danceability BETWEEN 0.39 AND 0.49) OR (danceability BETWEEN 0.89 AND 0.99) THEN 'High Danceability'
        WHEN danceability < 0.39 OR danceability > 0.99 THEN 'Cant Dance on this one'
        END AS danceability_category
  FROM spotify_data ORDER BY danceability DESC;

--QUE-12 12. Number of Songs for different danceability ranges(above)


 SELECT
    COUNT(*) AS num_songs,
    CASE
        WHEN danceability BETWEEN 0.69 AND 0.79 THEN 'Low Danceability'
        WHEN (danceability BETWEEN 0.49 AND 0.68) OR (danceability BETWEEN 0.79 AND 0.89) THEN 'Moderate Danceability'
        WHEN (danceability BETWEEN 0.39 AND 0.49) OR (danceability BETWEEN 0.89 AND 0.99) THEN 'High Danceability'
        WHEN danceability < 0.39 OR danceability > 0.99 THEN 'Cant Dance on this one'
        END AS danceability_category
 FROM spotify_data 
 GROUP BY danceability_category
 ORDER BY danceability_category ;




 --QUE-13  Loudness Analysis : Top 20 track_name, loudness,
--loudness BETWEEN -23.00 AND -15.00 ->'Low Loudness'
-- loudness BETWEEN -14.99 AND -6.00 -> 'Below Average Loudness'
-- loudness BETWEEN -5.99 AND -2.90 -> 'Above Average Loudness'
-- loudness BETWEEN -2.89 AND -1.00 -> 'Peak Loudness'

SELECT TOP 20 track_name,loudness,
    CASE
        WHEN loudness BETWEEN -23.00 AND -15.00 THEN 'Low Loudness'
        WHEN loudness BETWEEN -14.99 AND -6.00  THEN 'Below Average Loudness'
        WHEN loudness BETWEEN -5.99 AND -2.90  THEN 'Above Average Loudness'
        WHEN loudness BETWEEN -2.89 AND -1.00 THEN 'Peak Loudness'
        END AS loudness_category
FROM spotify_data ORDER BY loudness DESC;

--QUE-14. Number of Songs for different loudness ranges(above)

SELECT COUNT(*) AS num_songs, 
    CASE
        WHEN loudness BETWEEN -23.00 AND -15.00 THEN 'Low Loudness'
        WHEN loudness BETWEEN -14.99 AND -6.00  THEN 'Below Average Loudness'
        WHEN loudness BETWEEN -5.99 AND -2.90  THEN 'Above Average Loudness'
        WHEN loudness BETWEEN -2.89 AND -1.00 THEN 'Peak Loudness'
        END as loudness_category
FROM spotify_data 
GROUP BY loudness_category
ORDER BY loudness_category;

--QUE-15 Valence Analysis : Top 20 track_name, valence, track_popularity,
-- valence > 0.535 -> Above Avg Valence
-- valence = 0.535 -> Avg Valence
-- valence < 0.535 -> Below Average'

SELECT TOP 20 track_name,valence, track_popularity,
    CASE
        WHEN valence > 0.535 THEN 'Above Avg Valence'
        WHEN valence = 0.535   THEN 'Avg Valence'
        WHEN valence < 0.535 THEN 'Below Average'
        END AS valence_category
FROM spotify_data ORDER BY valence DESC;

--QUE-16. Number of Songs for different valence ranges(above)

SELECT COUNT(*) as num_songs,
    CASE
        WHEN valence > 0.535 THEN 'Above Avg Valence'
        WHEN valence = 0.535   THEN 'Avg Valence'
        WHEN valence < 0.535 THEN 'Below Average'
        END AS valence_category
FROM spotify_data 
GROUP BY valence_category
ORDER BY valence_category;


--QUE-17-Speechiness Analsis : Top 20 track_name, speechiness, tempo,
--- speechiness > 0.081-> Above Avg Speechiness
--- speechiness = 0.081-> Avg Speechiness
-- speechiness < 0.081-> Below Speechiness

SELECT TOP 20 track_name,speechiness, tempo,
    CASE
        WHEN speechiness > 0.081 THEN 'Above Avg Speechiness'
        WHEN speechiness = 0.081 THEN 'Avg Speechiness'
        WHEN speechiness < 0.081 THEN 'Below Speechiness'
        END AS speechiness_category
FROM spotify_data ORDER BY speechiness DESC;

##--QUE-18. Acoustic Analysis : DISTINCT TOP 25 track_name, album, artist_name, acousticness
##--- (acousticness BETWEEN 0 AND 0.40000 -> 'Not Acoustic'
##--- (acousticness BETWEEN 0.40001 AND 0.80000) ->'Acoustic'
##--- (acousticness BETWEEN 0.80001 AND 1) ->'Highly Acoustic

SELECT DISTINCT TOP 25 track_name, album, artist_name, acousticness,
    CASE
        WHEN acousticness BETWEEN 0 AND 0.40000 THEN 'Not Acoustic'
        WHEN acousticness BETWEEN 0.40001 AND 0.80000 THEN 'Acoustic'
        WHEN acousticness BETWEEN 0.80001 AND 1THEN 'Highly Acoustic'
        END AS acousticness_category
FROM spotify_data ORDER BY acousticness DESC;