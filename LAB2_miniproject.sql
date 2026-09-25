SELECT 
    b.band_name,
    COUNT(a.album_id) AS total_albums
FROM band b
JOIN album a ON b.band_id = a.band_id
GROUP BY b.band_id
ORDER BY total_albums DESC
LIMIT 1;
