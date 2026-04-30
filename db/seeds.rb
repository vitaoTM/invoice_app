# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
BusinessSetting.find_or_create_by!(id: 1) do |bs|
  bs.name = "Personal Concierge & Tours"
  bs.tagline = "Aruba Tourist Services"
  bs.address = "Oranjestad, Aruba"
  bs.registration_number = "H42115.0"
  bs.registration_label = "KvK Aruba"
  bs.currency = "USD"
  bs.payment_terms_days = 15
end

client = Client.find_or_create_by!(name: "Andrea Souza") do |c|
  c.country = "Brasil"
end

invoice = Invoice.find_or_create_by!(invoice_number: "INV-2026-001") do |inv|
  inv.client = client
  inv.invoice_date = Date.new(2026, 4, 13)
  inv.status = "draft"
  inv.event_type = "Renovação de Votos"
  inv.event_location = "Eagle Beach"
  inv.event_date = Date.new(2026, 5, 12)
  inv.schedule_notes = "Setup minimalista em: Eagle Beach"
  inv.tax_amount = 0.0
end

[
  { description: "Fotos", quantity: 1, unit_price: 420.00, position: 1 },
  { description: "Permissão", quantity: 1, unit_price: 225.00, position: 2 },
  { description: "Setup Minimalista / arco com cortinas branca", quantity: 1, unit_price: 250.00, position: 3 },
  { description: "Honorários", quantity: 1, unit_price: 100.00, position: 4 }
].each do |attrs|
  invoice.line_items.find_or_create_by!(description: attrs[:description]) do |li|
    li.assign_attributes(attrs)
  end
end

puts "Seed complete: 1 business, 1 client, 1 invoice with 4 line items."
