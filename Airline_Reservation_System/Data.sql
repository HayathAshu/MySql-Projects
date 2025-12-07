USE AirlineReservationSystem;

-- Insert into Flights
INSERT INTO Flights VALUES
(1, 'AI101', 'Air India', 'Delhi', 'Mumbai', '2025-08-20 10:00:00', '2025-08-20 12:15:00', 6500.00),
(2, 'AI202', 'Air India', 'Mumbai', 'Bangalore', '2025-08-21 09:00:00', '2025-08-21 11:30:00', 5500.00),
(3, '6E303', 'IndiGo', 'Delhi', 'Bangalore', '2025-08-22 14:00:00', '2025-08-22 17:00:00', 7000.00),
(4, 'SG404', 'SpiceJet', 'Chennai', 'Delhi', '2025-08-23 06:00:00', '2025-08-23 08:45:00', 7200.00);

-- Insert into Passengers
INSERT INTO Passengers VALUES
(1, 'Rahul', 'Sharma', 'rahul@example.com', '9876543210'),
(2, 'Priya', 'Singh', 'priya@example.com', '9876501234'),
(3, 'Arjun', 'Kumar', 'arjun@example.com', '9876512345'),
(4, 'Sneha', 'Patel', 'sneha@example.com', '9876523456');

-- Insert into Routes
INSERT INTO Routes VALUES
(1, 'Delhi', 'Mumbai', 1400),
(2, 'Mumbai', 'Bangalore', 980),
(3, 'Delhi', 'Bangalore', 2150),
(4, 'Chennai', 'Delhi', 2200);

-- Insert into Bookings
INSERT INTO Booking VALUES
(1, 1, 1, '2025-08-15', 'Economy', 'Confirmed'),
(2, 2, 2, '2025-08-16', 'Business', 'Confirmed'),
(3, 3, 3, '2025-08-16', 'Economy', 'Cancelled'),
(4, 4, 4, '2025-08-17', 'Economy', 'Pending');

-- Insert into Payments
INSERT INTO Payments VALUES
(1, 1, 6500.00, '2025-08-15', 'Credit Card'),
(2, 2, 12000.00, '2025-08-16', 'UPI');
