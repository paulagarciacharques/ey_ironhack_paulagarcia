/* 1. ¿Qué músico ha pertenecido a más bandas? */
SELECT 
    mn.musician_name,
    COUNT(DISTINCT bm.band_id) AS total_bands
FROM band_musician bm
JOIN musician_name mn ON bm.musician_id = mn.musician_id
GROUP BY mn.musician_name
ORDER BY total_bands DESC
LIMIT 1;


/* 2. ¿Qué músico ha participado en más álbumes? */
SELECT 
    mn.musician_name,
    COUNT(DISTINCT a.album_id) AS total_albums
FROM band_musician bm
JOIN musician_name mn ON bm.musician_id = mn.musician_id
JOIN album a ON bm.band_id = a.band_id
GROUP BY mn.musician_name
ORDER BY total_albums DESC
LIMIT 1;


/* 3. ¿Qué banda ha hecho más discos? */
SELECT 
    b.band_name,
    COUNT(a.album_id) AS total_albums
FROM band b
JOIN album a ON b.band_id = a.band_id
GROUP BY b.band_id
ORDER BY total_albums DESC
LIMIT 1;
