class Admin::DashboardController < Admin::BaseController
  def show
    @products_count = Product.all.length
    @categories_count = Category.all.length
  end
end
