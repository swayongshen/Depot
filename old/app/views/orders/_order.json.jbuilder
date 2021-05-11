json.extract! order, :id, :buyer_name, :buyer_email, :address, :created_at, :updated_at
json.url order_url(order, format: :json)
