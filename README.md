# Blinkit-2023-Revenue-SQL-Analysis
Case Study investigating a 2023 revenue anomaly using SQL and Data Storytelling


##  Executive Summary
While performing a Month-over-Month (MoM) revenue analysis on Blinkit’s 2023 dataset using **SQL**, an alarming anomaly appeared: **Month 11 recorded a severe ~43% revenue drop.** 

Instead of treating this as a simple calculation, this project executes a thorough **root-cause analysis (RCA)** to dissect the drivers behind the dip. By systematically testing data completeness, category performance, order volumes, and regional distribution, this project uncovers the behavioral and operational trends behind the numbers.

---

##  The Tech Stack & Skills Demonstrated
* **Database / Querying:** Advanced SQL (Aggregation, Window Functions, Joins, MoM calculations, Filtering)
* **Analytical Thinking:** Root Cause Analysis (RCA), Data Quality Checks, Funnel Breakdown
* **Domain:** Quick-Commerce Analytics (Blinkit-2023 Dataset)

---

##  Investigation & Step-by-Step Breakdown

### Step 1: Month-over-Month (MoM) Revenue Growth Analysis
* **Objective:** Track monthly revenue velocity to spot sudden macro shifts.
* **Finding:** Identified a massive **-43.02% revenue contraction** in Month 11 compared to Month 10.

### Step 2: Category-Level Failure Check
* **Objective:** Determine if a specific product category (e.g., Electronics, Vegetables) crashed and dragged down the overall revenue.
* **Finding:** **Every single category** experienced uniform negative growth (ranging from -26% to -60%). This completely ruled out product-specific issues or category outages.


### Step 3: Order Volume vs. Value Isolation
* **Objective:** Check whether the drop was driven by lower order frequency or smaller basket sizes (AOV).
* **Finding:** Total monthly transaction count plummeted sharply from **501 to 295 orders**, proving that the revenue crash was driven entirely by a contraction in customer order volume.


### Step 4: Geographic & Area-Level Deep Dive
* **Objective:** Locate where the order volume loss occurred across operating areas.
* **Finding:** The drop was not confined to a single hub or city; rather, it was a widespread, micro-level reduction in transactions spread across multiple regions.



##  Repository Structure
```text
Blinkit-2023-Performance-Analysis/
│
├── sql_queries/
│   
│
├── tables /
│   ├── mom_growth_output.png
│   ├── category_drop_output.png
│   ├── order_count_output.png
│   └── area_diff_output.png
│
└── README.md
