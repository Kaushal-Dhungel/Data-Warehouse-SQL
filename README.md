# SQL Data Warehouse (Medallion Architecture)

A from-scratch implementation of a **Data Warehouse** using the **Medallion Architecture (Bronze → Silver → Gold)** pattern.

Demonstrates data ingestion, transformation, dimensional modeling (Star Schema), and data quality validation.

---

## 🏗️ Architecture

The warehouse follows a **three-layer Medallion architecture**:

![Architecture](Resources/Diagram.jpeg)

### 🥉 Bronze Layer – Raw Data
- Stores raw source data as-is.
- Data ingested from CSV files.
- No transformations or constraints applied.
- Serves as a historical data backup.

### 🥈 Silver Layer – Cleaned & Standardized
- Data cleansing and normalization.
- Deduplication and validation.
- Standardized formats (dates, categories, codes).
- Prepares data for analytical modeling.

### 🥇 Gold Layer – Business-Ready (Star Schema)
- Dimensional modeling (Facts & Dimensions).
- Surrogate keys.
- Optimized for reporting and analytics.
- Can be queried directly by BI tools.

---

## 🧱 Data Model (Gold Layer)

The Gold layer follows a **Star Schema**:

- **Dimension Tables**
  - `gold.dim_customers`
  - `gold.dim_products`

- **Fact Table**
  - `gold.fact_sales`

---

# 📘 Data Catalog (Gold Layer)

## 1️⃣ `gold.dim_customers`

**Purpose:** Customer dimension enriched with demographic and geographic attributes.

| Column | Description |
|--------|------------|
| `customer_key` | Surrogate key |
| `customer_id` | Business customer ID |
| `customer_number` | Source system identifier |
| `first_name`, `last_name` | Customer name |
| `country` | Country of residence |
| `marital_status` | Standardized marital status |
| `gender` | Standardized gender (CRM primary, ERP fallback) |
| `birthdate` | Date of birth |
| `create_date` | Record creation date |

---

## 2️⃣ `gold.dim_products`

**Purpose:** Product dimension with category enrichment.

| Column | Description |
|--------|------------|
| `product_key` | Surrogate key |
| `product_id` | Business product ID |
| `product_number` | Source product identifier |
| `product_name` | Product name |
| `category_id` | Category code |
| `category`, `subcategory` | Category hierarchy |
| `maintenance` | Maintenance flag |
| `cost` | Product cost |
| `product_line` | Product line (Mountain, Road, etc.) |
| `start_date` | Active start date |

---

## 3️⃣ `gold.fact_sales`

**Purpose:** Sales transaction fact table.

| Column | Description |
|--------|------------|
| `order_number` | Sales order ID |
| `product_key` | FK → `dim_products` |
| `customer_key` | FK → `dim_customers` |
| `order_date`, `shipping_date`, `due_date` | Transaction dates |
| `sales_amount` | Total sales amount |
| `quantity` | Units sold |
| `price` | Unit price |

---

## 🔄 ETL Process Overview

1. **Source → Bronze**
   - Bulk load CSV files.
   - Raw ingestion without transformations.

2. **Bronze → Silver**
   - Data cleansing (trim spaces, normalize codes).
   - Deduplication using window functions.
   - Date validation and correction.
   - Standardization of categorical values.

3. **Silver → Gold**
   - Dimensional modeling.
   - Surrogate key generation.
   - Fact-to-dimension joins.
   - Business-ready dataset creation.

---

## ✅ Data Quality Checks

Validation scripts ensure:

- No duplicate primary keys in Silver.
- No negative or invalid numeric values.
- Valid date ranges.
- Fact-to-dimension referential integrity.
- Standardized categorical values.

---

## 🛠️ Tech Stack

- SQL (PostgreSQL / SQL Server compatible logic)
- Window functions (`ROW_NUMBER`, `LEAD`)
- Views & Stored Procedures
- Star Schema modeling

---

## 🎯 Key Concepts Demonstrated

- Medallion Architecture
- ETL pipeline design
- Data cleansing & standardization
- Dimensional modeling (Star Schema)
- Surrogate key generation
- Data validation & integrity testing