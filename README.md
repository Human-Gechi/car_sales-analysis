# car_sales-analysis
# 🚗 Car Listings Analysis using SQL

This project provides a detailed SQL-based analysis of car listings to uncover insights into market trends, pricing, value retention, consumer preferences, and vehicle condition.
## 📊 Dataset Assumptions

The analysis assumes the presence of the following fields in a SQL-accessible table named `car_sales`:

- `car_make`: Brand of the car (e.g., Toyota, Ford)
- `car_model`: Specific model name
- `year`: Year of manufacture
- `price`: Listed price of the car
- `mileage`: Distance the car has traveled
- `transmission`: Type of transmission (automatic/manual)
- `fuel_type`: Gasoline, Diesel, Hybrid, Electric, etc.
- `color`: Exterior color
- `condition`: Condition of the vehicle (new, used, like new, etc.)
- `accident`: Whether the car has been in an accident (Yes/No)
- `options_features`: Optional features (e.g., sunroof, GPS), stored as text or JSON


---

## 📌 Analysis Overview

### 🚗 Car Popularity & Demand

- **Most Popular Cars**: Identifies the top-selling makes and models.
- **Value Retention by Brand**: Compares average price per brand adjusted for vehicle age.
- **Color Trends**: Determines which car colors are most listed and their average prices.
- **Fuel Type Distribution**: Shows the market share of fuel types.
- **Electric/Hybrid Trends**: Tracks adoption over time based on listing dates.

### 💰 Pricing Insights

- **Average Price by Make/Model/Year**: Detailed breakdown of pricing trends.
- **Price vs. Mileage**: Dataset for regression analysis on depreciation.
- **Transmission Price Gap**: Compares automatic vs. manual car prices.
- **Condition-Based Pricing**: Assesses how vehicle condition affects value.
- **Accident Impact on Price**: Evaluates how accident history influences market price.

### 🧾 Depreciation & Value Retention

- **Yearly Depreciation**: Average price by vehicle year.
- **Top Value Retainers**: Identifies models with highest resale value after 5 years.

### 🧰 Features & Options Analysis

- **Features in Premium Cars**: Finds features commonly found in higher-priced vehicles.
- **Features by Brand**: Shows frequency of feature offerings by make.

### ⚙️ Condition & Reliability

- **Accident-Prone Models**: Highlights makes/models with the most accident listings.

### 📈 Inventory & Supply

- **Year Distribution**: Visualizes supply of vehicles by manufacturing year.

---

## 💾 Getting Started

### 1. **Set up your database**

Ensure your car listings data is stored in a table named `car_sales` with the fields described above.

### 2. **Run SQL Queries**

Use your preferred SQL client (e.g., PostgreSQL, MySQL, SQLite)  i used PostgreSQL

### 3. **Export Data for Further Analysis (Optional)**

Some queries (e.g., mileage vs. price) can be exported to a CSV for regression or visualization in Python, Excel, or Power BI.

---

## 🧠 Insights Goals

- Understand what makes/models/colors/fuel types are in demand.
- Identify vehicles that retain value well over time.
- See how condition, mileage, and accident history affect price.
- Discover which features influence high pricing.