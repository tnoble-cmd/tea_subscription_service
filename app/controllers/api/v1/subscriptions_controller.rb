class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.create(subscription_params)
    
    if subscription.save
      render json: subscription, status: :created #201
    else
      render json: {errors: subscription.errors.full_messages.uniq}, status: :unprocessable_entity #422
    end
  end

  def index
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions

    if subscription.any?
      render json: subscription, status: :ok #200
    else
      render json: {errors: "No subscriptions found"}, status: :not_found #404
    end
  end

  def update
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.find(params[:id])

    if subscription.update(subscription_params)
      render json: subscription, status: :ok #200
    end
  end
  
  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end
