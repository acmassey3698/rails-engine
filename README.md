# Rails Engine

### Description 
  Rails Engine is a rails API created for consumption by a front-end team. Rails Engine has a variety of endpoints that provide information about commerce data in ranging from indexes of items to specific revenue information for merchants in the database. 
  
### Schema Design

![rails_engine_schema](https://user-images.githubusercontent.com/75844153/144647589-66c349a0-e9ee-453a-9605-4acf7bca168e.png)

  
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

### Contact Info
  
  ![Linked In](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)
- [Andrew Massey](https://www.linkedin.com/in/andrew-massey-b06662194/)


![Github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)
- [Andrew Massey](https://github.com/acmassey3698)

