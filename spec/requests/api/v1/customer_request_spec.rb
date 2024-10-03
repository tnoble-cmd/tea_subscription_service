require 'rails_helper'

RSpec.describe "Api::V1::Customers", type: :request do

  describe "POST /api/v1/customers" do 

    it "creates a customer" do #happy path

      customer_params = {
        customer: {
          first_name: "John",
          last_name: "Doe",
          email: "john.doe@example.com",
          address: "123 Main St"
        }
      }

      post "/api/v1/customers", params: customer_params

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(response_body).to be_a(Hash)
      expect(response_body[:first_name]).to eq("John")
      expect(response_body[:last_name]).to eq("Doe")
      expect(response_body[:email]).to eq("john.doe@example.com")
      expect(response_body[:address]).to eq("123 Main St")
    end

    it "returns an error if there are missing params" do #such a sad path 
      customer_params = {
        customer: {
          first_name: "John",
          last_name: "Doe",
          address: "123 Main St",
          email: ""
        }
      }

      post "/api/v1/customers", params: customer_params

      response_body = JSON.parse(response.body)

      expect(response).to have_http_status(422)
      expect(response_body).to be_a(Hash)
      expect(response_body["errors"]).to eq(["Email can't be blank"])
    end
  end

  describe "GET /api/v1/customers/:id" do 

    it "returns a customer" do #happy path
      customer = Customer.create(first_name: "Jeff", last_name: "Doe", email: "jeffdoe@example.com", address: "123 Main St")

      get "/api/v1/customers/#{customer.id}"

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(response_body).to be_a(Hash)
      expect(response_body[:first_name]).to eq("Jeff")
      expect(response_body[:last_name]).to eq("Doe")
      expect(response_body[:email]).to eq("jeffdoe@example.com")
      expect(response_body[:address]).to eq("123 Main St")
    end

    it "returns a 404 if the customer is not found" do #sad path
      get "/api/v1/customers/999"

      expect(response).to have_http_status(404)
    end
  end

  describe "PATCH /api/v1/customers/:id" do 

    it "updates a customer" do
      customer = Customer.create(first_name: "Jeff", last_name: "Doe", email: "jeffdoe@example.com", address: "123 Main St")

      patch "/api/v1/customers/#{customer.id}", params: {customer: {first_name: "John", email: "johndoe@example.com"}}

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(response_body).to be_a(Hash)
      expect(response_body[:first_name]).to eq("John")
      expect(response_body[:last_name]).to eq("Doe")
      expect(response_body[:email]).to eq("johndoe@example.com")
      expect(response_body[:address]).to eq("123 Main St")
    end
  end

  describe "DELETE /api/v1/customers/:id" do

    it "deletes a customer" do
      customer = Customer.create(first_name: "Jeff", last_name: "Doe", email: "jeffdoe@example.com", address: "123 Main St")

      delete "/api/v1/customers/#{customer.id}"

      expect(response).to have_http_status(200)
      
      get "/api/v1/customers/#{customer.id}"

      expect(response).to have_http_status(404)
    end
  end
end