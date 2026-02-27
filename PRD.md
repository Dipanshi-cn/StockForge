Product Requirements Document (PRD)
Hardware Wholesale Stock & Order Management System

Version: 1.0
Tech Stack: Ruby on Rails + PostgreSQL

1. Overview
  1.1 Purpose

    Build a web-based system to manage hardware wholesale inventory and customer orders.

    Replace manual stock tracking and phone-based order handling.

    Implement an admin approval workflow before stock deduction.

  1.2 Scope (Phase One – Complete)
    Included

    Authentication (Admin, Dealer, Customer)

    Role-based authorization

    Category management

    Product management

    Inventory tracking

    Cart system

    Order placement

    Admin order approval/rejection

    Automatic stock deduction on approval

    Customer order tracking with expected delivery date

    Excluded

    Payment gateway

    Email/SMS notifications

    Invoice generation

    Advanced reporting/analytics

2. User Roles
  2.1 Admin

      Manage categories

      Manage products

      Update stock

      View all orders

      Approve or reject orders

      Set expected delivery date

  2.2 Dealer / Customer

    Register / Login

    Browse categories and products

    Add products to cart

    Place orders

    View and track own orders

3. Functional Requirements
  3.1 Authentication & Authorization

    Secure login and logout

    Encrypted passwords

    Role-based access control

    Admin-only access to admin dashboard

  3.2 Category Management (Admin)

    Create category

    Edit category

    Delete category

    View number of products per category

    Fields

    Name (required)

    Description (optional)

  3.3 Product Management (Admin)
    Admin Capabilities

    Create product

    Edit product

    Delete product

    Update stock quantity

    Set minimum stock alert

    Assign product to category

    Product Fields

    Name (required)

    SKU (unique, required)

    Category

    Brand

    Description

    Unit (Piece, Box, Kg, Meter)

    Cost Price

    Selling Price

    Stock Quantity

    Minimum Stock Alert

    Branch

    System Rules

    Stock cannot be negative

    Show low stock warning if stock ≤ minimum stock alert

  3.4 Admin Dashboard

    Display:

    Total categories

    Total products

    Total stock quantity

    Low stock products

    Pending orders count

    Approved orders count

    Rejected orders count

  3.5 Product Browsing (Dealer/Customer)

    Users can:

    View all categories

    View products by category

    Search products by name

    View product detail page

    Product Detail Page Must Show

    Name

    SKU

    Brand

    Selling price

    Available stock status

    Description

    Unit

  3.6 Cart System

    Users can:

    Add product to cart

    Update quantity

    Remove product

    View subtotal per item

    View total order amount

    System Rules

    Cannot add quantity greater than available stock

    Cart linked to logged-in user

    Cart clears after order placement

  3.7 Order Placement

    User must provide:

    Delivery address

    Contact number

    Optional notes

    On Order Submission

    Order status = Pending

    Stock remains unchanged

    Cart is cleared

  3.8 Order Management (Admin)

    Admin can:

    View all orders

    Open order details

    See customer details

    See ordered products and quantities

    Approve or reject order

    3.8.1 Approve Order

      System must:

      Validate stock availability for all items

      If insufficient stock → block approval

      If stock is sufficient:

      Reduce stock quantity

      Update status to Approved

      Store expected delivery date

      Save approval timestamp

      Use database transaction to ensure atomic update

    3.8.2 Reject Order

      Update status to Rejected

      Do not modify stock

  3.9 Customer Order Tracking

    Users must have a dedicated section:

    "My Orders"

    Each order displays:

    Order ID

    Order date

    Total amount

    Status (Pending / Approved / Rejected)

    Order Detail View

    Must display:

    Ordered products

    Quantity

    Price per unit

    Subtotal per item

    Total amount

    Delivery address

    Contact number

    Order date

    Current status

    Status Messages

    If Pending

    "Your order is under review."

    If Rejected

    "Your order has been rejected. Please contact the administrator."

    If Approved

    "Your order has been approved."

    "Expected delivery date: DD/MM/YYYY"

    (Expected delivery date is set by Admin at approval.)

4. Database (Core Tables)

  users

  categories

  products

  orders

  order_items

  carts

  Key Relationships

  User has many orders

  Order has many order_items

  Category has many products

  Product belongs to category

  Required Indexes

  Unique index on SKU

  Foreign key indexes

  Index on order status

5. Non-Functional Requirements
  Security

  Encrypted passwords

  CSRF protection

  Role-based authorization

  Data Integrity

  No negative stock allowed

  Order approval must be transaction-based

  Performance

  Support minimum 10,000 products

  UI

  Rails ERB views

  Tailwind CSS styling

  jQuery only if necessary

6. Success Criteria

  The system is complete when:

  Admin can fully manage categories and products

  Dealers/customers can place orders successfully

  Stock reduces only after admin approval

  Customers can track order status with expected delivery date

  No stock inconsistencies occur