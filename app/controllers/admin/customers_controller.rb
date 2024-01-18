class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :is_deleted)
  end
end
