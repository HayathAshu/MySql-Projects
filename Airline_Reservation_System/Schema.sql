create database if not exists AirlineReservationSystem;
use AirlineReservationSystem;

-- Flights Table
create table Flights(
	Flight_id INT primary key not null,
    Flight_number varchar(10) not null,
    Airline varchar(50) not null,
    Departure_airport varchar(50) not null,
    Arrival_airport varchar(50) not null,
    Departure_time datetime not null,
    Arrival_time datetime not null,
    Price decimal(10, 2) not null
);

-- Passengers Table
create table Passengers(
	Passenger_id int primary key not null,
    First_name varchar(50) not null,
    Last_name varchar(50) not null,
    Email_id varchar(50) unique not null,
    Phone_number varchar(15) unique not null
);

-- Routes Table
create table Routes(
	Route_id int primary key,
    Origin varchar(50) not null,
    Destination varchar(50) not null,
    Distance_KM int not null
);

-- Booking Table
create table Booking(
	Booking_id int Primary key,
    Passenger_id int not null,
    Flight_id int not null,
    Booking_date date not null,
    Seat_class varchar(20) not null,
    Status varchar(20) not null check(Status in ('Confirmed', 'Cancelled', 'Pending')),
    foreign key (Passenger_id) references Passengers(Passenger_id),
    foreign key (Flight_id) references Flights(Flight_id)
);

-- Payments Table
create table Payments(
	Payment_id int primary key,
    Booking_id int not null,
    Amount Decimal (10, 2) not null,
    Payment_date date not null,
    Method varchar(20) not null check(Method in('Credit Card', 'Debit Card', 'UPI', 'Net Banking')),
    foreign key (Booking_id) references Booking(Booking_id)
);
