# PlatinumRx Data Analyst Assignment

## Project Structure

```
PlatinumRx_Assignment/
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
└── README.md
```

---

## Phase 1 — SQL Proficiency

### Tools Used
MySQL (compatible with MySQL Workbench or any online SQL compiler)

### Part A: Hotel Management System

**Schema:** `users`, `bookings`, `items`, `booking_commercials`

| Question | Approach |
|----------|----------|
| Q1 – Last booked room per user | Subquery with `MAX(booking_date)` joined back to bookings |
| Q2 – Total billing in Nov 2021 | JOIN `booking_commercials` and `items`, filter by month/year, `SUM(qty × rate)` |
| Q3 – Bills > 1000 in Oct 2021 | Same JOIN with `HAVING SUM(...) > 1000` |
| Q4 – Most/Least ordered item per month | CTE + `RANK()` window function partitioned by month |
| Q5 – 2nd highest bill per month | CTE + `DENSE_RANK()` window function, filter `rnk = 2` |

### Part B: Clinic Management System

**Schema:** `clinics`, `customer`, `clinic_sales`, `expenses`

| Question | Approach |
|----------|----------|
| Q1 – Revenue by sales channel | `GROUP BY sales_channel`, `SUM(amount)` |
| Q2 – Top 10 valuable customers | JOIN `clinic_sales` and `customer`, `SUM(amount)`, `LIMIT 10` |
| Q3 – Month-wise revenue/expense/profit | Two CTEs (revenue & expense), `LEFT JOIN` on month, subtract for profit |
| Q4 – Most profitable clinic per city | CTE with clinic profit, `RANK()` partitioned by city (DESC) |
| Q5 – 2nd least profitable clinic per state | CTE with clinic profit, `DENSE_RANK()` partitioned by state (ASC), filter `rnk = 2` |

---

## Phase 2 — Spreadsheet Proficiency

**File:** `Spreadsheets/Ticket_Analysis.xlsx`

- **Sheet 1: ticket** — Contains `ticket_id`, `created_at`, `closed_at`, `outlet_id`, `cms_id`
- **Sheet 2: feedbacks** — Contains `cms_id`, `feedback_at`, `feedback_rating`, `ticket_created_at`

### Q1 — Populate `ticket_created_at` in feedbacks

```excel
=VLOOKUP(A2, ticket!$E:$B, 2, FALSE)
```

### Q2a — Same-day tickets (created & closed on same day)

```excel
=IF(INT(B2)=INT(C2), "Yes", "No")
```

### Q2b — Same hour of same day

```excel
=IF(AND(INT(B2)=INT(C2), HOUR(B2)=HOUR(C2)), "Yes", "No")
```

---

## Phase 3 — Python Proficiency

### Script 1: `01_Time_Converter.py`

Converts total minutes into a human-readable string.

```
130 minutes  →  2 hrs 10 minutes
110 minutes  →  1 hr 50 minutes
 60 minutes  →  1 hr 0 minutes
 45 minutes  →  45 minutes
```

**Logic:**
- `hours = total_minutes // 60`
- `minutes = total_minutes % 60`

### Script 2: `02_Remove_Duplicates.py`

Removes duplicate characters from a string using a `for` loop.

```
"programming"  →  "progamin"
"hello world"  →  "helo wrd"
"aabbcc"       →  "abc"
```

**Logic:** Iterate over each character; append to result only if not already present.

---

## Assumptions & Notes

1. SQL dialect: MySQL syntax (`YEAR()`, `MONTH()`, `MONTHNAME()`, `LIMIT`). For PostgreSQL use `EXTRACT(YEAR FROM ...)` and `FETCH FIRST 10 ROWS ONLY`.
2. Window functions (`RANK`, `DENSE_RANK`) require MySQL 8.0+ or PostgreSQL.
3. Clinic Q4 & Q5: Update `MONTH(cs.datetime) = 9` to any desired month.
4. Python scripts are compatible with Python 3.6+.

---

## How to Run

### SQL
1. Open MySQL Workbench or any SQL client.
2. Run `01_Hotel_Schema_Setup.sql` → then `02_Hotel_Queries.sql`.
3. Run `03_Clinic_Schema_Setup.sql` → then `04_Clinic_Queries.sql`.

### Python
```bash
python Python/01_Time_Converter.py
python Python/02_Remove_Duplicates.py
```

### Excel
1. Open `Ticket_Analysis.xlsx`.
2. Add ticket data in the **ticket** sheet, feedback data in the **feedbacks** sheet.
3. Apply the VLOOKUP and helper column formulas as described above.
