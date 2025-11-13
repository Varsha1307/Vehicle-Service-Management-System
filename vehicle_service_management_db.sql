-- 1. Master: Customer
CREATE TABLE m_customer (
    customer_id SERIAL PRIMARY KEY,
    full_name CHARACTER VARYING NOT NULL,
    phone_no CHARACTER VARYING NOT NULL UNIQUE,
    email_id CHARACTER VARYING,
    address CHARACTER VARYING,
    join_date DATE DEFAULT CURRENT_DATE
);


-- 2. Master: Vehicle Type
CREATE TABLE m_vehicle_type (
    vehicle_type_id SERIAL PRIMARY KEY,
    type_name CHARACTER VARYING NOT NULL UNIQUE
);

-- 3. Master: Service Type
CREATE TABLE m_service_type (
    service_type_id SERIAL PRIMARY KEY,
    service_name CHARACTER VARYING NOT NULL UNIQUE,
    base_price CHARACTER VARYING
);

-- 4. Master: Mechanic
CREATE TABLE m_mechanic (
    mechanic_id SERIAL PRIMARY KEY,
    full_name CHARACTER VARYING NOT NULL,
    phone_no CHARACTER VARYING,
    skill_level CHARACTER VARYING CHECK (skill_level IN ('Junior','Mid','Senior')) DEFAULT 'Junior'
);

-- 5. Master: Payment Mode
CREATE TABLE m_payment_mode (
    payment_mode_id SERIAL PRIMARY KEY,
    mode_name CHARACTER VARYING NOT NULL UNIQUE
);

-- 6. Transaction: Vehicle
CREATE TABLE t_vehicle (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_no CHARACTER VARYING NOT NULL UNIQUE,
    brand CHARACTER VARYING,
    model CHARACTER VARYING,
    vehicle_type_id INT NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT fk_vehicle_type FOREIGN KEY (vehicle_type_id)
        REFERENCES m_vehicle_type(vehicle_type_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_vehicle_customer FOREIGN KEY (customer_id)
        REFERENCES m_customer(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- 7. Transaction: Service Booking
CREATE TABLE t_service_booking (
    booking_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    booking_date DATE DEFAULT CURRENT_DATE,
    scheduled_date DATE NOT NULL,
    status CHARACTER VARYING CHECK (status IN ('Pending','In Progress','Completed','Cancelled')) DEFAULT 'Pending',
    CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id)
        REFERENCES m_customer(customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_booking_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES t_vehicle(vehicle_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- 8. Transaction: Service Job
CREATE TABLE t_service_job (
    job_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    service_type_id INT NOT NULL,
    mechanic_id INT NOT NULL,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    cost CHARACTER VARYING,
    remarks TEXT,
    CONSTRAINT fk_job_booking FOREIGN KEY (booking_id)
        REFERENCES t_service_booking(booking_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_job_service FOREIGN KEY (service_type_id)
        REFERENCES m_service_type(service_type_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_job_mechanic FOREIGN KEY (mechanic_id)
        REFERENCES m_mechanic(mechanic_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- 9. Transaction: Invoice
CREATE TABLE t_invoice (
    invoice_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_mode_id INT NOT NULL,
    invoice_date DATE DEFAULT CURRENT_DATE,
    total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    remarks TEXT,
    CONSTRAINT fk_invoice_booking FOREIGN KEY (booking_id)
        REFERENCES t_service_booking(booking_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_invoice_payment FOREIGN KEY (payment_mode_id)
        REFERENCES m_payment_mode(payment_mode_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

