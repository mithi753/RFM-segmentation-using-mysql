# RFM SEGMENTATION USING PIZZA SALES DATA 
## INTRODUCTION 
This project demonstrates how to perform Data cleaning , Exploratory analysis and  RFM (Recency, Frequency, Monetary) segmentation on pizza order data using MySQL. The dataset contains order details, including pizza types, quantities, prices, and customer purchases over time.
## DATASET DESCRIPTION 
The dataset contains pizza order details with the following columns:

1.pizza_id:Unique identifier for each pizza.

2.order_id: Unique identifier for each order.

3.pizza_name_id: Unique pizza name identifier.

4.quantity: Number of pizzas ordered.

5.order_date: Date when the order was placed.

6.order_time: Time when the order was placed.

7.unit_price: Price per unit pizza.

8.total_price: Total cost for the ordered pizzas.

9.pizza_size: Size of the pizza (S, M, L, etc.).

10.pizza_category: Category of the pizza (Classic, Veggie, Supreme, etc.).

11.pizza_ingredients: Ingredients used in the pizza.

12.pizza_name: Name of the pizza.
## Project Tasks
### 1. Data Cleaning
- Handling missing values.

- Standardizing column data types.

- Removing duplicates.

- Fixing inconsistencies in categorical values.
 ### 2. Exploratory Data Analysis (EDA)
- Understanding order patterns over time.

- Analyzing popular pizza categories and ingredients.

- Examining sales trends based on size and category.

- Identifying high-revenue pizzas.
### 3. RFM Segmentation
- Recency: Days since the last purchase.

- Frequency: Number of orders placed by a customer.

- Monetary: Total spending by a customer.

- Segmenting customers into different groups (e.g., high-value, frequent, occasional buyers).
### Process
Clone the repository:

- Import the dataset into MySQL.

- Run SQL scripts for data cleaning and analysis.

- Perform RFM segmentation based on the provided SQL queries.
### Contributing
Feel free to submit issues or pull requests for enhancements and additional insights.
