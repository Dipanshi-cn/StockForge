# Create Admin
admin = User.find_or_initialize_by(email: 'admin@stockforge.com')
admin.password = 'password123'
admin.password_confirmation = 'password123'
admin.role = :admin
admin.save!

# Create Dealer
dealer = User.find_or_initialize_by(email: 'dealer@stockforge.com')
dealer.password = 'password123'
dealer.password_confirmation = 'password123'
dealer.role = :dealer
dealer.save!

# Create Customer
customer = User.find_or_initialize_by(email: 'customer@stockforge.com')
customer.password = 'password123'
customer.password_confirmation = 'password123'
customer.role = :customer
customer.save!

# Create Categories
categories = [
  { name: 'Power Tools', description: 'Heavy-duty electric and cordless tools for professionals.' },
  { name: 'Plumbing', description: 'Pipes, fittings, and bathroom fixtures.' },
  { name: 'Electrical', description: 'Wiring, switches, and electrical components.' },
  { name: 'Fasteners', description: 'Screws, bolts, and industrial adhesives.' },
  { name: 'Hand Tools', description: 'Precision manual tools for every trade.' }
]

categories.each do |cat_attrs|
  Category.find_or_create_by!(cat_attrs)
end

# Create Products
power_tools = Category.find_by(name: 'Power Tools')
plumbing = Category.find_by(name: 'Plumbing')
hand_tools = Category.find_by(name: 'Hand Tools')

products = [
  {
    name: 'Industrial Hammer Drill',
    sku: 'PT-HD-001',
    category: power_tools,
    brand: 'DeWalt',
    description: '18V XR Brushless Hammer Drill Driver for heavy-duty applications.',
    unit: 'Piece',
    cost_price: 150.00,
    selling_price: 249.99,
    stock_quantity: 50,
    min_stock_alert: 10,
    branch: 'Main Warehouse'
  },
  {
    name: 'Cordless Angle Grinder',
    sku: 'PT-AG-002',
    category: power_tools,
    brand: 'Makita',
    description: 'High-performance 125mm cordless angle grinder.',
    unit: 'Piece',
    cost_price: 120.00,
    selling_price: 189.99,
    stock_quantity: 30,
    min_stock_alert: 5,
    branch: 'Main Warehouse'
  },
  {
    name: 'PVC Pipe 20mm',
    sku: 'PL-PV-001',
    category: plumbing,
    brand: 'Generic',
    description: 'High-density 20mm PVC pipe for residential plumbing.',
    unit: 'Meter',
    cost_price: 1.50,
    selling_price: 3.99,
    stock_quantity: 500,
    min_stock_alert: 100,
    branch: 'Annex A'
  },
  {
    name: 'Copper Fitting Elbow',
    sku: 'PL-CF-002',
    category: plumbing,
    brand: 'ProFlow',
    description: '15mm 90-degree copper elbow fitting.',
    unit: 'Box',
    cost_price: 25.00,
    selling_price: 45.00,
    stock_quantity: 100,
    min_stock_alert: 20,
    branch: 'Annex A'
  },
  {
    name: 'Professional Socket Set',
    sku: 'HT-SS-001',
    category: hand_tools,
    brand: 'Stanley',
    description: '45-piece chrome vanadium socket and bit set.',
    unit: 'Box',
    cost_price: 60.00,
    selling_price: 99.99,
    stock_quantity: 25,
    min_stock_alert: 5,
    branch: 'Main Warehouse'
  },
  {
    name: 'Magnetic Spirit Level',
    sku: 'HT-SL-002',
    category: hand_tools,
    brand: 'Empire',
    description: '600mm professional magnetic spirit level.',
    unit: 'Piece',
    cost_price: 15.00,
    selling_price: 29.99,
    stock_quantity: 5, # Low stock to trigger alert
    min_stock_alert: 10,
    branch: 'Main Warehouse'
  }
]

products.each do |prod_attrs|
  Product.find_or_create_by!(sku: prod_attrs[:sku]) do |p|
    p.assign_attributes(prod_attrs)
  end
end

puts "Seed completed!"
puts "Admin: admin@stockforge.com / password123"
puts "Dealer: dealer@stockforge.com / password123"
puts "Customer: customer@stockforge.com / password123"
