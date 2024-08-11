USE Hotel;
SELECT * FROM hotel.hotel_data;

 /* Total number of bookings */
SELECT COUNT(*) AS total_bookings FROM hotel.hotel_data;

/* Average number of adults per booking */
SELECT AVG(no_of_adults) AS avg_adults FROM hotel.hotel_data;


/* Bookings by market segment */
SELECT market_segment_type, COUNT(*) AS bookings_count FROM hotel.hotel_data 
GROUP BY market_segment_type;


/* Average price per room by room type */
SELECT room_type_reserved, AVG(avg_price_per_room) AS avg_price FROM hotel.hotel_data  
GROUP BY room_type_reserved;

/* Bookings with more than 2 weekend nights */
SELECT * FROM hotel.hotel_data  
WHERE no_of_weekend_nights > 2;

/* Bookings canceled vs. not canceled */
SELECT booking_status, COUNT(*) AS count FROM hotel.hotel_data 
GROUP BY booking_status;

/* Top 5 bookings with longest lead time */
SELECT TOP 5 * 
FROM hotel.hotel_data 
ORDER BY lead_time DESC;

/* Rolling average of lead time (Window Function) */
SELECT Booking_ID, lead_time, AVG(lead_time) 
OVER (ORDER BY arrival_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
AS rolling_avg_lead_time 
FROM hotel.hotel_data ;

/* Cumulative sum of average price per room (Window Function) */
SELECT Booking_ID, avg_price_per_room, SUM(avg_price_per_room) 
OVER (ORDER BY arrival_date) 
AS cumulative_sum_price 
FROM hotel.hotel_data;

/* Rank of average price per room within each market segment (Window Function) */
SELECT Booking_ID, market_segment_type, avg_price_per_room, RANK() 
OVER (PARTITION BY market_segment_type ORDER BY avg_price_per_room DESC) 
AS price_rank
FROM hotel.hotel_data;
 

 /* calculate average lead time by market segment and room type, and rank them */
SELECT  market_segment_type, room_type_reserved, AVG(lead_time) 
as avg_lead_time, RANK() 
OVER (PARTITION BY market_segment_type ORDER BY AVG(lead_time) DESC) 
as rank
FROM hotel.hotel_data   
GROUP BY market_segment_type, room_type_reserved
ORDER BY  market_segment_type, rank;
