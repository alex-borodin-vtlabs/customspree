north_america = Spree::Zone.find_by_name!("North America")
default = Spree::TaxCategory.find_by_name!("Default")
tax_rate = Spree::TaxRate.create(
  :name => "North America",
  :zone => north_america, 
  :amount => 0,
  :tax_category => default)
tax_rate.calculator = Spree::Calculator::DefaultTax.create!
tax_rate.save!
