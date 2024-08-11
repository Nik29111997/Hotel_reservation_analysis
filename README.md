# Hotel Reservation Data Analysis

This repository contains SQL scripts for analyzing hotel reservation data using Azure SQL Server. The SQL queries are designed to extract meaningful insights from the dataset, including booking statistics, market segment analysis, and pricing trends.

## Getting Started

### Prerequisites

- **Azure Account**: Ensure you have an Azure account to create SQL Server and Database.
- **Azure Data Studio**: Download and install [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio).
- **SQL Server**: Set up an Azure SQL Server and Database named `Hotel`.

### Installation

1. **Create SQL Server and Database**:
   - Log in to your Azure portal.
   - Create a SQL Server and a Database named `Hotel`.

2. **Import SQL Script**:
   - Open Azure Data Studio.
   - Connect to your Azure SQL Server.
   - Open the `Hotel_reservation.sql` file and execute it to set up the database schema and populate it with sample data.

## SQL Queries Overview

The SQL script includes a variety of queries to analyze hotel reservation data:

### Total Number of Bookings

SELECT COUNT(*) AS total_bookings FROM hotel.hotel_data;

### Average Number of Adults per Booking

SELECT AVG(no_of_adults) AS avg_adults FROM hotel.hotel_data;

### Bookings by Market Segment

SELECT market_segment_type, COUNT(*) AS bookings_count 
FROM hotel.hotel_data 
GROUP BY market_segment_type;

### Average Price per Room by Room Type

SELECT room_type_reserved, AVG(avg_price_per_room) AS avg_price 
FROM hotel.hotel_data 
GROUP BY room_type_reserved;

### Bookings with More than 2 Weekend Nights

SELECT * FROM hotel.hotel_data 
WHERE no_of_weekend_nights > 2;

### Bookings Canceled vs. Not Canceled

SELECT booking_status, COUNT(*) AS count 
FROM hotel.hotel_data 
GROUP BY booking_status;

### Top 5 Bookings with Longest Lead Time

SELECT TOP 5 * 
FROM hotel.hotel_data 
ORDER BY lead_time DESC;

### Rolling Average of Lead Time (Window Function)

SELECT Booking_ID, lead_time, AVG(lead_time) 
OVER (ORDER BY arrival_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_lead_time 
FROM hotel.hotel_data;

### Cumulative Sum of Average Price per Room (Window Function)

SELECT Booking_ID, avg_price_per_room, SUM(avg_price_per_room) 
OVER (ORDER BY arrival_date) AS cumulative_sum_price 
FROM hotel.hotel_data;

### Rank of Average Price per Room within Each Market Segment (Window Function)

SELECT Booking_ID, market_segment_type, avg_price_per_room, RANK() 
OVER (PARTITION BY market_segment_type ORDER BY avg_price_per_room DESC) AS price_rank 
FROM hotel.hotel_data;

### Average Lead Time by Market Segment and Room Type

SELECT market_segment_type, room_type_reserved, AVG(lead_time) AS avg_lead_time, 
RANK() OVER (PARTITION BY market_segment_type ORDER BY AVG(lead_time) DESC) AS rank 
FROM hotel.hotel_data 
GROUP BY market_segment_type, room_type_reserved 
ORDER BY market_segment_type, rank;

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

## Acknowledgments

Thanks to Azure Data Studio for providing a robust platform for SQL development and analysis.


This README is formatted to ensure clarity and consistency, making it easy for users to follow the instructions and understand the SQL queries. Each section is clearly defined, and SQL code blocks are properly formatted for readability.
