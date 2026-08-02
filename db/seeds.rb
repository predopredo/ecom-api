# db/seeds.rb

puts "Clearing existing products..."
Product.destroy_all

categories = [
  { name: "Audio", prefix: "AUD", price_range: (29.99..399.99) },
  { name: "Computers & Accessories", prefix: "COMP", price_range: (19.99..1499.99) },
  { name: "Monitors & Displays", prefix: "DISP", price_range: (149.99..999.99) },
  { name: "Gaming Gear", prefix: "GAME", price_range: (39.99..599.99) },
  { name: "Smart Home", prefix: "SMART", price_range: (24.99..299.99) },
  { name: "Wearable Tech", prefix: "WEAR", price_range: (49.99..449.99) },
  { name: "Office & Ergonomics", prefix: "OFF", price_range: (15.99..799.99) },
  { name: "Mobile & Accessories", prefix: "MOB", price_range: (12.99..199.99) },
  { name: "Photography & Video", prefix: "CAM", price_range: (89.99..1299.99) },
  { name: "Networking & Storage", prefix: "NET", price_range: (34.99..499.99) }
]

adjectives = [
  "Pro", "Ultra", "Ergonomic", "Wireless", "Compact", "HD", "4K", "RGB", "Silent", "Premium",
  "Portable", "Smart", "High-Speed", "Mechanical", "Precision", "Noise-Cancelling", "Heavy-Duty",
  "Aluminum", "Modular", "Next-Gen", "Advanced", "Slim", "Rugged", "Eco-Friendly", "Studio-Grade"
]

product_types = {
  "Audio" => ["Headphones", "Earbuds", "Bluetooth Speaker", "Soundbar", "Studio Microphone", "Audio Interface", "DAC Amplifier"],
  "Computers & Accessories" => ["Mechanical Keyboard", "Wireless Mouse", "USB-C Hub", "Docking Station", "Laptop Stand", "Webcam 1080p", "Trackpad"],
  "Monitors & Displays" => ["Curved Monitor 27\"", "4K Gaming Monitor 32\"", "Portable Touchscreen Display", "Ultrawide Monitor 34\"", "Dual-Monitor Arm"],
  "Gaming Gear" => ["Gaming Controller", "Flight Stick", "VR Headset Mount", "Racing Wheel", "Gaming Chair", "Stream Deck Controller"],
  "Smart Home" => ["Smart Plug 4-Pack", "RGB LED Light Strip", "Smart Thermostat", "Security Camera 2K", "Video Doorbell", "Smart Hub"],
  "Wearable Tech" => ["Fitness Tracker", "Smartwatch Series X", "Heart Rate Monitor Chest Strap", "Sleep Tracking Ring", "Smart Glasses"],
  "Office & Ergonomics" => ["Ergonomic Desk Chair", "Electric Standing Desk", "Leather Desk Pad", "Footrest Cushion", "Lumbar Support Pillow"],
  "Mobile & Accessories" => ["Fast Wireless Charger", "Magnetic Power Bank 10000mAh", "GaN Wall Charger 65W", "Car Phone Mount", "Braided Cable Set"],
  "Photography & Video" => ["Ring Light Kit", "Carbon Fiber Tripod", "4K Action Camera", "Camera Gimbal Stabilizer", "Vlog Microphone"],
  "Networking & Storage" => ["Wi-Fi 6E Mesh Router", "External SSD 1TB", "NAS Storage Enclosure 4-Bay", "Gigabit Ethernet Switch", "High-Speed Flash Drive 256GB"]
}

features = [
  "with long-lasting battery life and fast charging capabilities",
  "designed for seamless productivity and maximum comfort during long hours",
  "featuring premium build quality and modern minimalist aesthetic",
  "equipped with intelligent auto-sync and multi-device pairing options",
  "built with eco-friendly recycled materials and low energy consumption",
  "offering high precision performance tailored for power users and professionals",
  "with customizable settings, customizable RGB illumination, and dedicated app control",
  "engineered for ultra-low latency and maximum reliability in any environment"
]

products_data = []
now = Time.current

800.times do |i|
  cat = categories[i % categories.length]
  adj1 = adjectives[(i * 3 + 1) % adjectives.length]
  adj2 = adjectives[(i * 7 + 2) % adjectives.length]
  adj2 = adjectives[(i * 7 + 3) % adjectives.length] if adj1 == adj2
  
  type_list = product_types[cat[:name]]
  p_type = type_list[i % type_list.length]
  
  name = "#{adj1} #{adj2} #{p_type}".squeeze(" ")
  price = rand(cat[:price_range]).round(2)
  sku = "#{cat[:prefix]}-#{(i + 1).to_s.rjust(4, '0')}"
  stock = rand(0..250)
  feature = features[i % features.length]
  description = "#{name} – Top-tier #{cat[:name].downcase} product #{feature}."

  products_data << {
    name: name,
    price: price,
    sku: sku,
    stock: stock,
    description: description,
    created_at: now,
    updated_at: now
  }
end

puts "Inserting 800 products..."
Product.insert_all(products_data)

puts "Successfully seeded #{Product.count} products into the database!"
