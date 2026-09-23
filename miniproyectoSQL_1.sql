SELECT 
    AVG(TIMESTAMPDIFF(YEAR, s.dob, CURDATE())) AS edad_promedio_sobresalientes
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grades >= 9 AND g.grades <= 10;
SELECT 
    g.student_id,
    g.subject_id,
    g.grades,
    CASE
        WHEN g.grades >= 9 THEN 'EXCELENTE'
        WHEN g.grades BETWEEN 7 AND 8 THEN 'BUENO'
        WHEN g.grades BETWEEN 5 AND 6 THEN 'APROBADO'
        ELSE 'REPROBADO'
    END AS categoria_nota
FROM grades g;
SELECT 
    u.university_id,
    u.uni_name,
    AVG(TIMESTAMPDIFF(YEAR, s.dob, CURDATE())) AS edad_media
FROM students s
JOIN campus c      ON s.campus_id = c.campus_id
JOIN university u  ON c.university_id = u.university_id
GROUP BY u.university_id, u.uni_name;
SELECT 
    sub.subject_id,
    sub.subj_name,
    SUM(CASE WHEN g.grades < 5 THEN 1 ELSE 0 END) AS num_suspendidos,
    COUNT(*) AS total_alumnos,
    100.0 * SUM(CASE WHEN g.grades < 5 THEN 1 ELSE 0 END) / COUNT(*) AS porcentaje_suspendidos
FROM grades g
JOIN subjects sub ON g.subject_id = sub.subject_id
GROUP BY sub.subject_id, sub.subj_name
ORDER BY porcentaje_suspendidos DESC;
-- Con Erasmus (aparecen en international_agreement)
SELECT 
    'CON_ERASMUS' AS tipo,
    AVG(g.grades) AS nota_media
FROM grades g
WHERE g.student_id IN (
    SELECT DISTINCT ia.student_id
    FROM international_agreement ia
);

-- Sin Erasmus
SELECT 
    'SIN_ERASMUS' AS tipo,
    AVG(g.grades) AS nota_media
FROM grades g
WHERE g.student_id NOT IN (
    SELECT DISTINCT ia.student_id
    FROM international_agreement ia
);
SELECT 
    u.university_id,
    u.uni_name,
    SUM(CASE WHEN b.bachelor_name LIKE '%Licenciatura%' THEN 1 ELSE 0 END) AS num_licenciatura,
    SUM(CASE WHEN b.bachelor_name LIKE '%Master%'      THEN 1 ELSE 0 END) AS num_maestria,
    SUM(CASE WHEN b.bachelor_name LIKE '%Doctor%'     THEN 1 ELSE 0 END) AS num_doctorado
FROM university u
LEFT JOIN bachelor b ON u.university_id = b.university_id
GROUP BY u.university_id, u.uni_name;
SELECT 
    u.university_id,
    u.uni_name,
    AVG(r.intl_ranking) AS ranking_medio
FROM ranking r
JOIN university u ON r.university_id = u.university_id
GROUP BY u.university_id, u.uni_name
ORDER BY ranking_medio DESC
LIMIT 5;
SELECT 
    s.student_id,
    s.f_name,
    s.l_name,
    u.uni_name AS universidad_origen,
    s.email,
    COUNT(*) AS num_acuerdos
FROM international_agreement ia
JOIN students s   ON ia.student_id = s.student_id
JOIN campus c     ON s.campus_id = c.campus_id
JOIN university u ON c.university_id = u.university_id
GROUP BY s.student_id, s.f_name, s.l_name, u.uni_name, s.email
ORDER BY num_acuerdos DESC
LIMIT 10;
SELECT 
    s.student_id,
    s.f_name,
    s.l_name,
    u.uni_name AS universidad_origen,
    c.city     AS ciudad_intercambio
FROM international_agreement ia
JOIN students s   ON ia.student_id = s.student_id
JOIN campus c     ON ia.away_university = c.university_id
JOIN university u ON ia.home_university = u.university_id
WHERE ia.agreement_code = @agreement_code;  -- parámetro
SELECT 
    sub.subject_id,
    sub.subj_name,
    COUNT(DISTINCT us.university_id) AS num_universidades,
    AVG(g.grades) AS nota_media_asignatura
FROM subjects sub
LEFT JOIN uni_subj us ON sub.subject_id = us.subject_id
LEFT JOIN grades g    ON sub.subject_id = g.subject_id
GROUP BY sub.subject_id, sub.subj_name;
SELECT 
    s.city,
    s.state,
    100.0 * SUM(CASE WHEN g.grades >= 9 AND g.grades <= 10 THEN 1 ELSE 0 END) / COUNT(*) 
        AS porcentaje_sobresalientes
FROM grades g
JOIN students s ON g.student_id = s.student_id
GROUP BY s.city, s.state
ORDER BY porcentaje_sobresalientes DESC
LIMIT 5;
SELECT 
    u.university_id,
    u.uni_name,
    COUNT(DISTINCT ia.student_id) AS num_estudiantes_enviados
FROM international_agreement ia
JOIN university u ON ia.home_university = u.university_id
GROUP BY u.university_id, u.uni_name
ORDER BY num_estudiantes_enviados DESC;
SELECT 
    u.university_id,
    u.uni_name,
    COUNT(DISTINCT ia.student_id) AS num_estudiantes_recibidos
FROM international_agreement ia
JOIN university u ON ia.away_university = u.university_id
GROUP BY u.university_id, u.uni_name
ORDER BY num_estudiantes_recibidos DESC;
SELECT 
    u.university_id,
    u.uni_name,
    COUNT(DISTINCT ia.student_id) AS num_estudiantes,
    'ENVIADOS' AS tipo
FROM international_agreement ia
JOIN university u ON ia.home_university = u.university_id
GROUP BY u.university_id, u.uni_name

UNION ALL

SELECT 
    u.university_id,
    u.uni_name,
    COUNT(DISTINCT ia.student_id) AS num_estudiantes,
    'RECIBIDOS' AS tipo
FROM international_agreement ia
JOIN university u ON ia.away_university = u.university_id
GROUP BY u.university_id, u.uni_name;
SELECT 
    u.university_id,
    u.uni_name,
    AVG(g.grades) AS nota_media_global
FROM university u
JOIN campus c ON u.university_id = c.university_id
JOIN students s ON s.campus_id = c.campus_id
JOIN grades g ON g.student_id = s.student_id
GROUP BY u.university_id, u.uni_name
ORDER BY nota_media_global DESC;
SELECT 
    u.university_id,
    u.uni_name,
    AVG(g.grades) AS mejor_nota_media
FROM university u
JOIN campus c ON u.university_id = c.university_id
JOIN students s ON s.campus_id = c.campus_id
JOIN grades g ON g.student_id = s.student_id
GROUP BY u.university_id, u.uni_name
ORDER BY mejor_nota_media DESC
LIMIT 1;
SELECT 
    sub.subject_id,
    sub.subj_name,
    AVG(g.grades) AS nota_media_asignatura
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN campus c ON s.campus_id = c.campus_id
JOIN university u ON c.university_id = u.university_id
JOIN subjects sub ON g.subject_id = sub.subject_id
WHERE u.university_id = (
    SELECT 
        u2.university_id
    FROM university u2
    JOIN campus c2 ON u2.university_id = c2.university_id
    JOIN students s2 ON s2.campus_id = c2.campus_id
    JOIN grades g2 ON g2.student_id = s2.student_id
    GROUP BY u2.university_id
    ORDER BY AVG(g2.grades) DESC
    LIMIT 1
)
GROUP BY sub.subject_id, sub.subj_name
ORDER BY nota_media_asignatura DESC;
