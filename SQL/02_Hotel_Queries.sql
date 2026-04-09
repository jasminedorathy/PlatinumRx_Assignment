SELECT b.user_id,
       b.room_no AS last_booked_room
FROM bookings b
INNER JOIN (
    SELECT user_id,
           MAX(booking_date) AS last_booking_date
    FROM bookings
    GROUP BY user_id
) AS latest
  ON b.user_id       = latest.user_id
 AND b.booking_date  = latest.last_booking_date;


SELECT
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date)  = 2021
  AND MONTH(bc.bill_date) = 11
GROUP BY bc.booking_id
ORDER BY total_billing_amount DESC;


SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date)  = 2021
  AND MONTH(bc.bill_date) = 10
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000
ORDER BY bill_amount DESC;


WITH monthly_item_totals AS (
    SELECT
        MONTH(bc.bill_date)        AS month_num,
        MONTHNAME(bc.bill_date)    AS month_name,
        i.item_id,
        i.item_name,
        SUM(bc.item_quantity)      AS total_quantity,
        RANK() OVER (
            PARTITION BY MONTH(bc.bill_date)
            ORDER BY SUM(bc.item_quantity) DESC
        ) AS rank_most,
        RANK() OVER (
            PARTITION BY MONTH(bc.bill_date)
            ORDER BY SUM(bc.item_quantity) ASC
        ) AS rank_least
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY
        MONTH(bc.bill_date),
        MONTHNAME(bc.bill_date),
        i.item_id,
        i.item_name
)
SELECT
    month_num,
    month_name,
    item_name,
    total_quantity,
    CASE
        WHEN rank_most  = 1 THEN 'Most Ordered'
        WHEN rank_least = 1 THEN 'Least Ordered'
    END AS order_status
FROM monthly_item_totals
WHERE rank_most = 1 OR rank_least = 1
ORDER BY month_num, order_status;


WITH bill_totals AS (
    SELECT
        b.user_id,
        u.name                              AS customer_name,
        MONTH(bc.bill_date)                 AS month_num,
        MONTHNAME(bc.bill_date)             AS month_name,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users    u ON b.user_id     = u.user_id
    JOIN items    i ON bc.item_id    = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY
        b.user_id,
        u.name,
        MONTH(bc.bill_date),
        MONTHNAME(bc.bill_date),
        bc.bill_id
),
ranked_bills AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY month_num
            ORDER BY bill_amount DESC
        ) AS bill_rank
    FROM bill_totals
)
SELECT
    month_num,
    month_name,
    user_id,
    customer_name,
    bill_id,
    bill_amount
FROM ranked_bills
WHERE bill_rank = 2
ORDER BY month_num;
