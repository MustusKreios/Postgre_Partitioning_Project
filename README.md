# Database_project
A relational database to test my skills

# Steam Games Database  

This project is a **PostgreSQL database** designed to store and manage Steam game data efficiently using **table partitioning**. It categorizes games based on:  
- **Release Year** (1990s, 2000s, 2010s)  
- **Price** (Free or Paid)  
- **Average Playtime** (Most Played, Least Played)  

## Features  
✔ **Optimized Queries** – Partitioning improves search performance  
✔ **Structured Data** – Organizes games by release date, price, and playtime  

## Sample Data  
You can download the sample dataset from the link below:  

📂 **[Steam Games Sample Data](https://www.kaggle.com/datasets/nikdavis/steam-store-games?fbclid=IwZXh0bgNhZW0CMTEAAR2qJNxMxG1ALQqSTvme2q7GfQEFTWNYPmhEzYDd4mCx5x9GTBrX6QW8Zeg_aem_0_D7CqY-pQIhLCnjCr6NdQ)**  

## Example Query  
```sql
SELECT * FROM steam_games 
WHERE release_date BETWEEN '2000-01-01' AND '2010-01-01';
