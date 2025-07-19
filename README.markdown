# Retail Sales Database Project

## Overview
This project involves the creation and analysis of a retail sales database using SQL. The database, named `project1`, contains a table `retail_sales` that stores transaction data for retail sales. The project includes SQL scripts for database setup, data cleaning, data exploration, and data analysis to address various business questions.

## Project Structure
- **Database Setup**: Creates the `project1` database and the `retail_sales` table with relevant columns.
- **Data Cleaning**: Identifies and removes records with missing values.
- **Data Exploration**: Provides insights into the dataset, such as total sales, unique customers, and top categories.
- **Data Analysis**: Answers specific business questions through SQL queries, such as sales by category, customer demographics, and peak sales periods.
- **SQL File**: The main SQL script (`retail_sales_analysis.sql`) contains all queries for setup, cleaning, exploration, and analysis.

## Database Schema
The `retail_sales` table has the following columns:
- `transactions_id` (INT, PRIMARY KEY): Unique identifier for each transaction.
- `sale_date` (DATE): Date of the sale.
- `sale_time` (TIME): Time of the sale.
- `customer_id` (INT): Unique identifier for the customer.
- `gender` (VARCHAR(10)): Customer's gender.
- `age` (INT): Customer's age.
- `category` (VARCHAR(25)): Product category (e.g., Clothing, Beauty).
- `quantity` (INT): Number of units sold.
- `price_per_unit` (FLOAT): Price per unit.
- `cogs` (FLOAT): Cost of goods sold.
- `total_sale` (FLOAT): Total sale amount.

## Prerequisites
- A SQL-compatible database management system (e.g., MySQL, PostgreSQL).
- Basic knowledge of SQL for running the queries.
- Sample data to populate the `retail_sales` table (not provided in this repository).

## Setup Instructions
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/retail-sales-project.git
   ```
2. **Set Up the Database**:
   - Open your SQL client (e.g., MySQL Workbench, pgAdmin).
   - Run the following SQL commands to create the database and table:
     ```sql
     CREATE DATABASE project1;
     USE project1;
     CREATE TABLE retail_sales (
         transactions_id INT PRIMARY KEY,
         sale_date DATE,
         sale_time TIME,
         customer_id INT,
         gender VARCHAR(10),
         age INT,
         category VARCHAR(25),
         quantity INT,
         price_per_unit FLOAT,
         cogs FLOAT,
         total_sale FLOAT
     );
     ```
3. **Load Data**:
   - Import your dataset into the `retail_sales` table (e.g., via CSV import or INSERT statements).
4. **Run the Analysis**:
   - Execute the SQL queries in `retail_sales_analysis.sql` to perform data cleaning, exploration, and analysis.

## SQL Queries
The project includes the following key analyses:
1. **Data Cleaning**:
   - Identifies records with missing values.
   - Deletes records with NULL values in critical columns.
2. **Data Exploration**:
   - Counts total sales and unique customers.
   - Identifies the date with maximum sales.
   - Determines the most frequent gender and top-selling category.
3. **Business Questions**:
   - Retrieves sales for a specific date ('2022-11-05').
   - Filters transactions for 'Clothing' with quantity > 3 in November 2022.
   - Calculates total sales by category.
   - Finds the average age of customers purchasing from the 'Beauty' category.
   - Lists transactions with total sales > 1000.
   - Counts transactions by gender and category.
   - Computes average sales per month and identifies the best-selling month per year.
   - Finds the top 5 customers by total sales.
   - Counts unique customers per category.
   - Groups transactions by shift (Morning, Afternoon, Evening) based on sale time.

## Usage
1. Open the `retail_sales_analysis.sql` file in your SQL client.
2. Execute the queries sequentially to:
   - Set up the database and table.
   - Clean the data.
   - Explore the dataset.
   - Answer the business questions.
3. Modify the queries as needed to suit your dataset or additional requirements.

## Example Queries
Below are some sample queries from the project:

### Q1: Sales on a Specific Date
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### Q7: Average Sales by Month
```sql
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    ROUND(AVG(total_sale)) AS avg_sales
FROM retail_sales
GROUP BY year, month
ORDER BY year, avg_sales DESC;
```

### Q10: Orders by Shift
```sql
WITH hourly_sale AS (
    SELECT *,
        CASE 
            WHEN HOUR(sale_time) < 12 THEN 'morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
            ELSE 'evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift, COUNT(*)
FROM hourly_sale
GROUP BY shift;
```

## Notes
- The SQL queries assume the `retail_sales` table is populated with data.
- Some queries (e.g., maximum gender, maximum category) in the exploration section may not provide meaningful insights due to the use of `MAX()`. Consider replacing them with `GROUP BY` or other aggregations for more accurate analysis.
- Ensure your dataset has valid data to avoid errors during query execution.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue to suggest improvements or additional analyses.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.