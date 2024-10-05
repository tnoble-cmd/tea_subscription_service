require 'rails_helper'

RSpec.describe "Api::V1::Subscription", type: :request do
  before :each do
    @customer = Customer.create!(first_name: "John",last_name: "Doe", email: "john@example.com", address: "123 Elm St")
    @tea = Tea.create!(title: "Green Tea", description: "A refreshing green tea", temperature: 80, brew_time: 2)

  end

  describe "POST /api/v1/customers/:customer_id/subscriptions" do
    it "creates a subscription" do #happy path
    
      subscription_params = {
        subscription: {
          title: "Monthly Green Tea Subscription",
          price: 19.99,
          status: "active",
          frequency: "monthly",
          customer_id: @customer.id,
          tea_id: @tea.id
        }
      }

      post "/api/v1/customers/#{@customer.id}/subscriptions", params: subscription_params

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(201)
      
      expect(parsed_response).to have_key(:id)
      expect(parsed_response).to have_key(:title)
      expect(parsed_response).to have_key(:price)
      expect(parsed_response).to have_key(:status)
      expect(parsed_response).to have_key(:frequency)
      expect(parsed_response).to have_key(:customer_id)
      expect(parsed_response).to have_key(:tea_id)

      expect(parsed_response[:customer_id]).to eq(@customer.id)
      expect(parsed_response[:tea_id]).to eq(@tea.id)
    end


    it "returns an error if subscription is not created" do #sad path

      subscription_params = {
        subscription: {
          title: "Monthly Green Tea Subscription",
          price: 19.99,
          status: "active",
          frequency: "monthly",
          customer_id: "27",
          tea_id: @tea.id
        }
      }

      post "/api/v1/customers/27/subscriptions", params: subscription_params

      expect(response).to have_http_status(422) #customer_id is not valid
    end
  end


  describe "GET /api/v1/customers/:customer_id/subscriptions" do #index
    it "returns a list of subscriptions for a customer" do #happy path
      subscription_1 = Subscription.create!(title: "Monthly Green Tea Subscription", price: 19.99, status: "active", frequency: "monthly", customer_id: @customer.id, tea_id: @tea.id)
      subscription_2 = Subscription.create!(title: "Weekly Green Tea Subscription", price: 9.99, status: "cancelled", frequency: "weekly", customer_id: @customer.id, tea_id: @tea.id)

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(parsed_response).to be_an(Array)
      expect(parsed_response.first).to be_a(Hash)
      expect(parsed_response.first).to have_key(:id)
      expect(parsed_response.first).to have_key(:title)
      expect(parsed_response.first).to have_key(:price)
      expect(parsed_response.first).to have_key(:status)
      expect(parsed_response.first).to have_key(:frequency)
      expect(parsed_response.first).to have_key(:customer_id)
      expect(parsed_response.first).to have_key(:tea_id)
      expect(parsed_response.first[:customer_id]).to eq(@customer.id)

      expect(parsed_response[1]).to be_a(Hash)
      
      expect(parsed_response.count).to eq(2) #assuming second hash is structured the same way.
    end


    it "returns an error if no customer is found" do #sad path
      get "/api/v1/customers/27/subscriptions"

      #NO CUSTOMER WITH ID 27 expecting 404

      expect(response).to have_http_status(404)
    end

    it "returns an error if no subscriptions are associated with the customer" do #sad path
      customer_2 = Customer.create!(first_name: "Jane",last_name: "Doe", email: "JaneJane@example.com", address: "123 Elm St")

      #Jane has no subscriptions

      get "/api/v1/customers/#{customer_2.id}/subscriptions"

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(parsed_response).to have_key(:errors)
      expect(customer_2.subscriptions).to eq([])
      expect(parsed_response[:errors]).to eq("No subscriptions found")
    end

  describe "PATCH /api/v1/customers/:id/subscriptions/:id"

    it "successfully updates the status of a subscription" do
      subscription_1 = Subscription.create!(title: "Monthly Green Tea Subscription", price: 19.99, status: "active", frequency: "monthly", customer_id: @customer.id, tea_id: @tea.id)
      subscription_2 = Subscription.create!(title: "Weekly Green Tea Subscription", price: 9.99, status: "cancelled", frequency: "weekly", customer_id: @customer.id, tea_id: @tea.id)

      subscription_params = {
        subscription: {

          status: "cancelled",
        }
      }

      patch "/api/v1/customers/#{@customer.id}/subscriptions/#{subscription_1.id}", params: subscription_params

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(parsed_response).to be_a(Hash)
      expect(parsed_response[:status]).to eq("cancelled")

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(parsed_response).to be_an(Array)
      expect(parsed_response.first).to be_a(Hash)
      expect(parsed_response.first).to have_key(:status)
      expect(parsed_response.first[:status]).to eq("cancelled")
    end

    it "returns an error if the subscription is not updated" do
      subscription_1 = Subscription.create!(title: "Monthly Green Tea Subscription", price: 19.99, status: "active", frequency: "monthly", customer_id: @customer.id, tea_id: @tea.id)
      subscription_2 = Subscription.create!(title: "Weekly Green Tea Subscription", price: 9.99, status: "cancelled", frequency: "weekly", customer_id: @customer.id, tea_id: @tea.id)

      subscription_params = {
        subscription: {
          status: "cancelled",
        }
      }

      patch "/api/v1/customers/27/subscriptions/#{subscription_1.id}", params: subscription_params


      expect(response).to have_http_status(404) #customer_id is not valid
      
    end
  end
end