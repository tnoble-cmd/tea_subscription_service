### Tea Box API
---
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)  ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)


About: 
---

This Project was designed to simulate a take home challange to be presented to an interviewer. I am to create a Rails API that satisfies the following requierments. 


## Requirements
### You must create:

- An endpoint to subscribe a customer to a tea subscription
- An endpoint to cancel a customer’s tea subscription
- An endpoint to see all of a customer’s subsciptions (active and cancelled)


## Learning Goals:

- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

----

# Setup

1. Fork and clone this repo.
2. In the terminal run ```bundle install```. After running check (in the terminal) ```rails -v``` and ```ruby -v``` ensure they are versions: Rails 7.1.4 / Ruby 3.2.2
3. Run  ```rails db:{drop,migrate,create,seed}``` * this will set up the Postgres DB and give necessary seeded ```Tea``` subscriptions
4. Start the local server by running ```rails s``` in the terminal
5. You may test the endpoints via Postman by following JSON contracts below.
6. If using Puma you can navigate to ```http://localhost:3000//api/v1``` in your browser followed by the endpoints listed below.



# Testing

Rspec was utilized as the test suite in this application and tests may be ran by typing this in the terminal:
```bundle exec rspec ```
All tests will be passing. 
I checked test coverage with the gem ```Simplecove```

To check test coverage with ```Simplecov``` in the terminal type ``` open coverage/index.html```

# Schema

![Screenshot 2024-10-17 at 12 37 42 PM](https://github.com/user-attachments/assets/3fc7b657-7947-4450-869c-15b66d8a1302)


# Endpoints

To Get all Customer Subscriptions:

### - Request: ```GET /api/v1/customers/#{customer.id}/subscriptions```

#### Successful: ```202```:

![Screenshot 2024-10-17 at 12 46 51 PM](https://github.com/user-attachments/assets/e7714702-1e90-4d22-8a33-211e21ccd538)

#### Customer exists, but there are no subscriptions associated: ```404```
![Screenshot 2024-10-17 at 12 49 12 PM](https://github.com/user-attachments/assets/c3b4c8e3-70fb-449d-8bef-3e90166cca81)



#### Customer does not exist: ```404```

----
To Create a Customer Subscription:

### - Request: ```POST /api/v1/customers/#{customer.id}/subscriptions```

![Screenshot 2024-10-17 at 12 58 24 PM](https://github.com/user-attachments/assets/414d2a42-b4a7-4fa3-8ac1-6be88fa181df)


#### Successful: ```201```

![Screenshot 2024-10-17 at 12 59 02 PM](https://github.com/user-attachments/assets/504d60cc-6aa7-4f12-9df2-9edecf4ff2d9)

#### Customer/Tea must be provided: ```422```

![Screenshot 2024-10-17 at 1 00 05 PM](https://github.com/user-attachments/assets/0eeaa389-878b-4685-b932-37422088e575)

----

To Update a Customers Subscription Params:

### - Request: ```PATCH /api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}```

![Screenshot 2024-10-17 at 1 05 22 PM](https://github.com/user-attachments/assets/74f5d383-9278-4089-a78f-d54998e0b4b6)

#### Successful: ```200```

![Screenshot 2024-10-17 at 1 06 11 PM](https://github.com/user-attachments/assets/fc7c78f2-da0d-41d5-a534-e69de69ce6a1)

#### Customer/subscription not found: ```404```



