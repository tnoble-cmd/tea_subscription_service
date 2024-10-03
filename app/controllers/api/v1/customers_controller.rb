class Api::V1::CustomersController < ApplicationController

  def create
    customer = Customer.create(customer_params)
    if customer.save
      render json: customer, status: :created #201
    else
      render json: {errors: customer.errors.full_messages.uniq}, status: :unprocessable_entity #422
    end
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer, status: :ok #200
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    render json: customer, status: :ok #200
  end

  def destroy
    customer = Customer.find(params[:id])
    render json: customer.destroy, status: :ok #200
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end
end