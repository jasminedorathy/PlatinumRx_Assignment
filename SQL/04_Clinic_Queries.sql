SELECT
    sales_channel,
    SUM(amount)          AS total_revenue,
    COUNT(oid)           AS total_orders,
    ROUND(AVG(amount),2) AS avg_order_value
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;


SELECT
    c.uid,
    c.name,
    c.mobile,
    SUM(cs.amount) AS total_spent,
    COUNT(cs.oid)  AS total_orders
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY c.uid, c.name, c.mobile
ORDER BY total_spent DESC
LIMIT 10;


WITH monthly_revenue AS (
    SELECT
        MONTH(datetime)     AS month_num,
        MONTHNAME(datetime) AS month_name,
        SUM(amount)         AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime), MONTHNAME(datetime)
),
monthly_expense AS (
    SELECT
        MONTH(datetime) AS month_num,
        SUM(amount)     AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT
    r.month_num,
    r.month_name,
    r.revenue,
    COALESCE(e.expense, 0)                     AS expense,
    r.revenue - COALESCE(e.expense, 0)         AS profit,
    CASE
        WHEN r.revenue - COALESCE(e.expense, 0) >= 0
        THEN 'Profitable'
        ELSE 'Not-Profitable'
    END                                        AS status
FROM monthly_revenue r
LEFT JOIN monthly_expense e ON r.month_num = e.month_num
ORDER BY r.month_num;


WITH clinic_monthly_profit AS (
    SELECT
        cl.city,
        cl.cid,
        cl.clinic_name,
        COALESCE(SUM(cs.amount), 0) AS revenue,
        COALESCE(SUM(ex.amount), 0) AS expense,
        COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) AS profit,
        RANK() OVER (
            PARTITION BY cl.city
            ORDER BY COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) DESC
        ) AS rnk
    FROM clinics cl
    LEFT JOIN clinic_sales cs
           ON cl.cid = cs.cid
          AND YEAR(cs.datetime)  = 2021
          AND MONTH(cs.datetime) = 9
    LEFT JOIN expenses ex
           ON cl.cid = ex.cid
          AND YEAR(ex.datetime)  = 2021
          AND MONTH(ex.datetime) = 9
    GROUP BY cl.city, cl.cid, cl.clinic_name
)
SELECT city, cid, clinic_name, revenue, expense, profit
FROM clinic_monthly_profit
WHERE rnk = 1
ORDER BY city;


WITH clinic_monthly_profit AS (
    SELECT
        cl.state,
        cl.cid,
        cl.clinic_name,
        COALESCE(SUM(cs.amount), 0) AS revenue,
        COALESCE(SUM(ex.amount), 0) AS expense,
        COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs
           ON cl.cid = cs.cid
          AND YEAR(cs.datetime)  = 2021
          AND MONTH(cs.datetime) = 9
    LEFT JOIN expenses ex
           ON cl.cid = ex.cid
          AND YEAR(ex.datetime)  = 2021
          AND MONTH(ex.datetime) = 9
    GROUP BY cl.state, cl.cid, cl.clinic_name
),
ranked_clinics AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY state
            ORDER BY profit ASC
        ) AS rnk
    FROM clinic_monthly_profit
)
SELECT state, cid, clinic_name, revenue, expense, profit
FROM ranked_clinics
WHERE rnk = 2
ORDER BY state;
