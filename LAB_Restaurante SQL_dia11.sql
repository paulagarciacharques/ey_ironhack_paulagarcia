SELECT 
    s.customer_id,
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;
SELECT 
    customer_id,
    COUNT(DISTINCT order_date) AS visit_days
FROM sales
GROUP BY customer_id;
SELECT s.customer_id, m.product_name
FROM sales s
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date = (
    SELECT MIN(order_date)
    FROM sales
    WHERE customer_id = s.customer_id
);
SELECT 
    m.product_name,
    COUNT(*) AS times_bought
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY times_bought DESC
LIMIT 1;
SELECT customer_id, product_name, times_bought
FROM (
    SELECT 
        s.customer_id,
        m.product_name,
        COUNT(*) AS times_bought,
        ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY COUNT(*) DESC) AS rn
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY s.customer_id, m.product_name
) t
WHERE rn = 1;
SELECT s.customer_id, m.product_name
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date = (
    SELECT MIN(order_date)
    FROM sales
    WHERE customer_id = s.customer_id
      AND order_date >= mb.join_date
);
SELECT s.customer_id, m.product_name
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date = (
    SELECT MIN(order_date)
    FROM sales
    WHERE customer_id = s.customer_id
      AND order_date >= mb.join_date
);
SELECT s.customer_id, m.product_name
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date = (
    SELECT MIN(order_date)
    FROM sales
    WHERE customer_id = s.customer_id
      AND order_date >= mb.join_date
);
SELECT s.customer_id, m.product_name
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date = (
    SELECT MAX(order_date)
    FROM sales
    WHERE customer_id = s.customer_id
      AND order_date < mb.join_date
);
SELECT 
    s.customer_id,
    COUNT(*) AS items_before_member,
    SUM(m.price) AS total_spent_before_member
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date < mb.join_date
GROUP BY s.customer_id;
SELECT 
    s.customer_id,
    SUM(
        CASE 
            WHEN m.product_name = 'sushi' THEN m.price * 20
            ELSE m.price * 10
        END
    ) AS total_points
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date >= mb.join_date
GROUP BY s.customer_id;
SELECT 
    s.customer_id,
    SUM(
        CASE 
            WHEN s.order_date BETWEEN mb.join_date AND DATE_ADD(mb.join_date, INTERVAL 7 DAY)
                THEN m.price * 20
            WHEN m.product_name = 'sushi'
                THEN m.price * 20
            ELSE m.price * 10
        END
    ) AS january_points
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.customer_id IN ('A','B')
  AND s.order_date <= '2021-01-31'
GROUP BY s.customer_id;
