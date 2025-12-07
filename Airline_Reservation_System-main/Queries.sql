use AirlineReservationSystem;

-- 1. Find flights with the highest booking rate
select flight_number, count(booking_id) as Total_Bookings from 
flights as f
join
booking as b on f.Flight_id = b.Flight_id
where b.Status = 'Confirmed'
group by f.Flight_number
order by Total_Bookings desc;

-- 2. Average ticket price by route
select r.origin, r.destination, round(avg(f.price),0) as Avg_Price from routes as r
join
flights as f on r.Origin = f.Departure_airport and r.Destination = f.Arrival_airport
group by r.Origin, r.Destination;

-- 3. Passengers who frequently cancel bookings
select p.passenger_id, concat(p.First_name, ' ', p.last_name) as Full_name, b.Status from passengers as p
join
booking as b on p.Passenger_id = b.Passenger_id where Status = 'Cancelled';

-- 4. Total revenue per airline
SELECT f.airline, SUM(p.amount) AS total_revenue
FROM Flights as f
JOIN Booking as b ON f.flight_id = b.flight_id
JOIN Payments as p ON b.booking_id = p.booking_id
GROUP BY f.airline
ORDER BY total_revenue DESC;

-- 5. List all pending bookings with passenger and flight details
select * from booking where status = 'Cancelled';

select f.flight_id, concat(p.first_name, ' ', p.last_name)as Full_name, b.passenger_id, Airline, b.status 
from flights as f 
join
booking as b on f.flight_id = b.flight_id
join
passengers as p on b.passenger_id = p.passenger_id
where b.status = 'Cancelled';

-- Find the most expensive flight
select flight_id, Airline, Price from flights order by price desc limit 1;

-- 7. Count total passengers per airline (Confirmed bookings only)
SELECT f.airline, COUNT(DISTINCT b.passenger_id) AS total_passengers
FROM Flights f
JOIN Booking b ON f.flight_id = b.flight_id
WHERE b.status = 'Confirmed'
GROUP BY f.airline;
