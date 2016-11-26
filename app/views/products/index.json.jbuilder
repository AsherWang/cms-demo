json.draw params[:draw].to_i
json.recordsTotal Product.all.size
json.recordsFiltered @filteredProducts.size
json.data @products, partial: 'products/product', as: :product