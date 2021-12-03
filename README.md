# Rails Engine

### Description 
  Rails Engine is a rails API created for consumption by a front-end team. Rails Engine has a variety of endpoints that provide information about commerce data in ranging from indexes of items to specific revenue information for merchants in the database. 
  
### Ruby/Rails Versions
  - Ruby: 2.7.2
  - Rails: 5.2.6

### Local Deployment
  For local deployment, run the following commands from the command line
  ```
    git clone git@github.com:acmassey3698/travel-weather.git
    
    bundle install
    
    rake db:{drop,create,migrate}
  ```

### Running the Test Suite
The RSpec test suite can be run using the command 
```
bundle exec rspec
```

### Running the Server
To run the server for local endpoint testing (i.e. Postman)
```
rails s
```

### All Endpoints

#### RESTful Endpoints
- `/api/v1/merchants`
- `/api/v1/merchants/:merchant_id`
- `/api/v1/merchants/:merchant_id/items`
- `/api/v1/items`
- `/api/v1/items/:item_id`
- `/api/v1/items/:item_id/merchant`

#### Non-RESTful Endpoints
- `/api/v1/merchants/find` required param: name
- `/api/v1/items/find_all` required param: name

#### Business Intelligence Endpoints
- `/api/v1/revenue/items?quantity=3` Get a Quantity of Items Ranked by Revenue
- `/api/v1/revenue/merchants?quantity=3`Get a Quantity of Merchants Ranked by Revenue
- `/api/v1/merchants/most_items?quantity=3`Get a a Quantity of Merchants Ranked by the number of Items sold

### Example Responses
- Base url: `http://localhost:3000/api/v1`

<details>
  
  <summary>Get All Merchants</summary>
  
  * method: GET
  
  * endpoint: `/merchants`
  
  * optional params: per_page, page
  
  * example request: `GET http://localhost:3000/api/v1/merchants?per_page=2`
  
  * example response:
  
  ```
  {
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store of Fate",
      }
    }
  ]
}
  ```
</details>

<details>
  <summary>Get One Merchant</summary>
  
  * method: GET
  
  * endpoint: `/merchants/:id`
  
  * required params: location: string (ex: Denver,CO)
  
  * example request: `GET http://localhost:3000/api/v1/merchants/1`
  
  * example response:
  
  ```
  {
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "Super Widget",
      "description": "A most excellent widget of the finest crafting",
      "unit_price": 109.99
    }
  }
}
  ```  
</details>

<details>
  <summary>Create a New User</summary>
  
  * method: POST
  
  * endpoint: `/users`
  
  * required params: MUST BE SENT AS JSON PAYLOAD IN BODY OF REQUEST
    
    - email: string
    
    - password: string 
  
    - password_confirmation: string
  
  * example request: `POST http://localhost:3000/api/v1/users`
  
  * example response:
  
  ```
  {
    "data": {
        "type": "users",
        "id": "4",
        "attributes": {
            "email": "alx@alex.com",
            "api_key": "33565062c1b85dbda984641d0a639da1"
        }
    }
}
  ```  
</details>


<details>
  <summary>Login as Existing User</summary>
    
  * method: POST
  
  * endpoint: `/sessions`
  
  * required params: MUST BE SENT AS JSON PAYLOAD IN BODY OF REQUEST
    
    - email: string
    
    - password: string 
  
  * example request: `POST http://localhost:3000/api/v1/sessions`
  
  * example response:
  
  ```
  {
    "data": {
        "type": "users",
        "id": "4",
        "attributes": {
            "email": "alx@alex.com",
            "api_key": "33565062c1b85dbda984641d0a639da1"
        }
    }
}
  ```     
</details>

<details>
  <summary>Create a Road Trip</summary>
    
  * method: POST
  
  * endpoint: `/road_trip`
  
  * required params: MUST BE SENT AS JSON PAYLOAD IN BODY OF REQUEST
    
    - origin: string (ex: Denver,CO
    
    - destination: string (ex: Rifle,CO)
  
    - api_key: string
  
  * example request: `POST http://localhost:3000/api/v1/road_trip`
  
  * example response:
  
  ```
 {
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Rifle,CO",
            "travel_time": "02:53:58",
            "weather_at_eta": {
                "temperature": 55.04,
                "conditions": "overcast clouds"
            }
        }
    }
}
  ```   
</details>

### Contact Info
  
  ![Linked In](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)
- [Andrew Massey](https://www.linkedin.com/in/andrew-massey-b06662194/)


![Github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)
- [Andrew Massey](https://github.com/acmassey3698)

