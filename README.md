# Vehicle Service Management System (VSMS)

## Description
A relational database project designed for a vehicle service center.  
The system manages customers, vehicles, service bookings, service jobs, mechanics, and invoices.  
Designed using **PostgreSQL** and follows **industry-standard naming** conventions:
- Master tables prefixed with `m_`
- Transactional tables prefixed with `t_`

---

## 🧩 Database Structure
### Master Tables
- m_customer
- m_vehicle_type
- m_service_type
- m_mechanic
- m_payment_mode

### Transactional Tables
- t_vehicle
- t_service_booking
- t_service_job
- t_invoice

---

## ⚙️ How to Run
1. Open **pgAdmin**.
2. Connect to your PostgreSQL server.
3. Create a new database:  
   ```sql
   CREATE DATABASE vehicle_service_db;
