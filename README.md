# StockForge 🏭

A comprehensive web-based Hardware Wholesale Stock & Order Management System built with Ruby on Rails and PostgreSQL. Streamline your inventory management, order processing, and approval workflows with role-based access control.

## 🌟 Features

### For Administrators

- **Category Management**: Create, edit, and organize product categories
- **Product Management**: Full CRUD operations for products with SKU tracking
- **Inventory Control**: Real-time stock updates with low-stock alerts
- **Order Approval Workflow**: Review, approve, or reject customer orders
- **Stock Validation**: Automatic stock checks before order approval
- **Delivery Date Management**: Set expected delivery dates for approved orders
- **Dashboard Analytics**: Overview of categories, products, stock levels, and order statistics
- **Atomic Transactions**: Ensures data integrity during stock deduction

### For Dealers/Customers

- **Product Browsing**: Browse products by category with search functionality
- **Shopping Cart**: Add, update, and remove items with real-time stock validation
- **Order Placement**: Submit orders with delivery details and notes
- **Order Tracking**: Monitor order status (Pending/Approved/Rejected)
- **Order History**: View detailed order information including expected delivery dates

### Security & Authorization

- **Role-Based Access Control**: Admin, Dealer, and Customer roles
- **Secure Authentication**: Powered by Devise with encrypted passwords
- **CSRF Protection**: Built-in Rails security features
- **Authorization Policies**: Pundit-based permission management

## 🛠️ Tech Stack

- **Framework**: Ruby on Rails 7.x
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Authorization**: Pundit
- **Frontend**: ERB Templates, Tailwind CSS, Hotwire (Turbo & Stimulus)
- **Asset Pipeline**: Importmap
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **Deployment**: Standard Rails deployment (e.g. Render, Railway, Heroku, VPS)

## 📋 Prerequisites

- Ruby 3.2+
- PostgreSQL 14+
- Node.js 18+ (for asset compilation)
- Redis (optional, for caching)

## 🚀 Getting Started

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/stock-forge.git
   cd stock-forge
   ```

2. **Install dependencies**

   ```bash
   bundle install
   ```

3. **Setup database**

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Install JavaScript dependencies**

   ```bash
   rails importmap:install
   ```

5. **Build Tailwind CSS**
   ```bash
   rails tailwindcss:build
   ```

### Running the Application

**Development Mode:**

```bash
# Using foreman (recommended)
./bin/dev

# Or manually
rails server
```

Visit `http://localhost:3000` to access the application.

**Default Admin Credentials (if seeded):**

- Email: `admin@example.com`
- Password: `password`

## 👥 User Roles

### Admin

- Manage categories and products
- Update inventory and stock levels
- View all orders across all customers
- Approve/reject orders with delivery date assignment
- Access admin dashboard with statistics
- Delete categories, products, and manage system

### Dealer/Customer

- Register and manage own account
- Browse categories and products
- Add products to cart
- Place orders with delivery details
- Track order status and history
- View expected delivery dates for approved orders

## 📊 Database Schema

### Core Tables

**users**: User accounts with role assignment (admin, dealer, customer)

**categories**: Product categories

- Fields: name, description

**products**: Product inventory

- Fields: name, sku (unique), category_id, brand, description, unit, cost_price, selling_price, stock_quantity, minimum_stock_alert, branch

**orders**: Customer orders

- Fields: user_id, total_amount, status (pending/approved/rejected), delivery_address, contact_number, notes, expected_delivery_date, approved_at

**order_items**: Line items for orders

- Fields: order_id, product_id, quantity, price_per_unit, subtotal

**carts**: Shopping cart (optional, can be session-based)

- Fields: user_id

**cart_items**: Cart line items

- Fields: cart_id, product_id, quantity

## 🧪 Testing

Run the test suite:

```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/product_test.rb

# Run with coverage (if configured)
COVERAGE=true rails test
```

Security audits:

```bash
# Check for security vulnerabilities
./bin/brakeman

# Audit gem dependencies
./bin/bundler-audit
```

Code quality:

```bash
# Run RuboCop linter
./bin/rubocop

# Auto-correct issues
./bin/rubocop -A
```

## 📁 Project Structure

```
app/
├── controllers/        # Request handlers
├── models/            # Business logic and data models
├── views/             # ERB templates
├── policies/          # Pundit authorization policies
├── services/          # Business logic services (e.g., order approval)
├── helpers/           # View helpers
└── javascript/        # Stimulus controllers

config/
├── routes.rb          # Application routes
├── database.yml       # Database configuration
└── initializers/      # Rails initializers

db/
├── migrate/           # Database migrations
├── schema.rb          # Database schema
└── seeds.rb           # Seed data

test/
├── models/            # Model tests
├── controllers/       # Controller tests
└── integration/       # Integration tests
```

## 🔐 Environment Variables

Create a `.env` file in the root directory:

```bash
DATABASE_URL=postgresql://username:password@localhost/stock_forge_development
RAILS_MASTER_KEY=your_master_key_here
REDIS_URL=redis://localhost:6379/1
```

## 🚢 Deployment

Use any standard Ruby on Rails deployment target. At minimum:

1. Set required secrets (for example with `rails credentials:edit`)
2. Provision PostgreSQL
3. Run `rails db:migrate`
4. Start the app with `rails server` or your production process manager

## 📝 Key Workflows

### Order Approval Process

1. Customer places order → Status: **Pending** (stock unchanged)
2. Admin reviews order in admin dashboard
3. Admin clicks "Approve":
   - System validates stock availability
   - If sufficient: Deducts stock, sets status to **Approved**, adds expected delivery date
   - If insufficient: Shows error, blocks approval
4. Customer sees status update with delivery date

### Stock Management

- Admin can update stock quantities at any time
- System shows low-stock warnings when stock ≤ minimum alert level
- Stock validation prevents overselling
- Atomic transactions ensure consistency

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is proprietary software. All rights reserved.

## 🆘 Support

For support or questions, please contact the development team or open an issue in the repository.

---

**Built with ❤️ using Ruby on Rails**
