object false
node(:success) { @handler.success }
node(:error) { @handler.error }
node(:successful) { @handler.successful? }
node(:status_code) { @handler.status_code }
node(:total) { Spree::Money.new(@order.total).to_s }
node(:promo_total) { Spree::Money.new(@order.promo_total).to_s }