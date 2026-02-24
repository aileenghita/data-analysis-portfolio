## 📚 E-Bookstore Database & Business Insight Analysis

This project simulates a relational database system for an online bookstore. 
The database manages publishers, books, members and transactions.

In addition to database design, SQL queries were used to extract business insights 
related to revenue performance, customer behavior, and inventory management.

The e-bookstore needs to:
- Track customer purchases and feedback
- Monitor inventory levels
- Identify high-value customers
- Analyze operational backlog (pending shipments)

### 🗂 Entity Relationship Diagram
<img width="940" height="370" alt="image" src="https://github.com/user-attachments/assets/5968daca-4030-420a-95e5-1a2ab2390a32" />

### 📈 Key Insights

- Customer engagement in October 2023 is concentrated on a small number of titles, with a few books receiving multiple reviews.
- Several books show stock levels significantly above the overall average, indicating potential overstock risk.
- The store manages 7 genres, with Lifestyle holding the highest inventory concentration.
- Two registered members have not made any purchases, representing potential churn or re-engagement opportunities.
- Five transactions remain in non-delivered status (3 shipped, 2 pending), indicating operational backlog.
- A small group of members demonstrates repeat purchasing behavior, suggesting potential high-value customers.
- The highest transaction value recorded in October 2023 was RM500.

### 💡 Recommendations

1. Implement targeted promotional campaigns for overstocked books to optimize inventory turnover and reduce holding costs.

2. Introduce retention or engagement campaigns for inactive members to encourage first-time purchases.

3. Improve fulfillment monitoring processes to reduce pending and shipped transaction backlog, ensuring faster delivery completion.

4. Develop a loyalty program targeting repeat customers to maximize lifetime value.

### 🛠 SQL Concepts Used

- Primary & Foreign Key constraints
- CHECK constraints
- JOIN
- GROUP BY & HAVING
- Subqueries
- Common Table Expressions (CTE)
- Aggregate functions
