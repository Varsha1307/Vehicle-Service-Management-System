INSERT INTO m_customer (full_name, phone_no, email_id, address) VALUES
('Varsha Nayak', '9000011111', 'varsha@example.com', 'Bengaluru'),
('rama', '9000022222', 'rahul@example.com', 'Mysuru');

select * from m_customer;

INSERT INTO m_vehicle_type (type_name) VALUES
('Car'),
('Bike'),
('Truck');

select * from m_vehicle_type;

INSERT INTO m_service_type (service_name, base_price) VALUES
('Oil Change', 800.00),
('Brake Inspection', 500.00),
('Full Service', 2500.00);

select * from m_service_type;

INSERT INTO m_mechanic (full_name, phone_no, skill_level) VALUES
('Ramesh Kumar', '9876543210', 'Senior'),
('Anil Patel', '9988776655', 'Mid'),
('Suresh Rao', '8877665544', 'Junior');

select * from m_mechanic;

INSERT INTO m_payment_mode (mode_name) VALUES
('Cash'),
('Credit Card'),
('UPI');

select * from m_payment_mode;

INSERT INTO t_vehicle (vehicle_no, brand, model, vehicle_type_id, customer_id) VALUES
('KA01AB1234', 'Hyundai', 'i20', 1, 1),   -- Car owned by Varsha
('KA05XY9876', 'Hero', 'Splendor', 2, 2); -- Bike owned by Rahul

select * from t_vehicle;

INSERT INTO t_service_booking (customer_id, vehicle_id, booking_date, scheduled_date, status) VALUES
(1, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 'Pending'),
(2, 2, CURRENT_DATE, CURRENT_DATE + INTERVAL '2 day', 'Pending');

select * from t_service_booking;

-- For booking 1 (Varsha's Car)
INSERT INTO t_service_job (booking_id, service_type_id, mechanic_id, start_time, end_time, cost, remarks) VALUES
(1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '1 hour', 850.00, 'Oil changed successfully'),
(1, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '30 minutes', 550.00, 'Brakes checked');

-- For booking 2 (Rahul's Bike)
INSERT INTO t_service_job (booking_id, service_type_id, mechanic_id, start_time, end_time, cost, remarks) VALUES
(2, 3, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '2 hours', 2600.00, 'Full service done');

select * from t_service_job;

-- For booking 1
INSERT INTO t_invoice (booking_id, payment_mode_id, total_amount, remarks) VALUES
(1, 3, 1400.00, 'UPI payment by Varsha');

-- For booking 2
INSERT INTO t_invoice (booking_id, payment_mode_id, total_amount, remarks) VALUES
(2, 1, 2600.00, 'Cash payment by Rahul');

select * from t_invoice;

