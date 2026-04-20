# CV Bank Management System (SQL Server Based)

A robust Relational Database Management System (RDBMS) designed to streamline the process of managing job seeker profiles and employment requests. This project demonstrates advanced SQL skills, data normalization, and complex entity relationship modeling.


### 🚀 Key Features
- **Relational Architecture:** Organized data into multiple normalized tables (Users, Education, Experience, Skills, etc.).
- **Many-to-Many Relationships:** Handled complex skill-to-user mapping using junction tables.
- **Advanced Querying:** Implementation of multi-level JOINS, Aggregations (GROUP BY, HAVING), and Conditional Logic (CASE statements).
- **Data Integrity:** Used Primary Keys, Foreign Keys, and Unique Constraints to ensure high data quality.

### 🛠️ Technical Stack
- **Database:** Microsoft SQL Server (T-SQL)
- **Design Tool:** ER Modeling

### 📋 Database Components
The system manages the following core entities:
- **Users:** Personal details and contact information.
- **Education & Experience:** Academic background and professional history.
- **Skills:** Management of technical and soft skills.
- **CV Requests:** Tracking recruitment requests from companies.

### 🔍 Example Queries Included
The script includes practical examples of:
- Finding top users by skills.
- Categorizing experience levels (Junior/Mid/Senior).
- Handling missing data using `ISNULL`.
- Aggregating total users per skill set.

### ⚙️ How to Setup
1. Open **SQL Server Management Studio (SSMS)**.
2. Create a new query window.
3. Copy and paste the contents of `CV_Bank_Management_System.sql`.
4. Execute the script to create the database and populate sample data.
