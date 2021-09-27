## Developer notes

This is a simple rails API application designed to fetch test panel and respective tests details.

URL: /api/v1/test_panels?id=Tp2&include=test&api_key='10ae820f-8c24-4e69-888b-03cbc36c89a6'
Method: GET
Response format:

```json
{
 "data": {
    "type": "test_panels",
    "id": "TP2",
    "attributes": {
      "price": 2100,
      "sample_tube_types": ["purple", "yellow"],
      "sample_volume_requirement": 220
    },
    "relationships": {
      "test": {
        "data": [
          { "id": "B12", "type": "test"},
          { "id": "HBA1C", "type": "test"}
        ]
      }
    }
  },
  "included": [
    {
      "type": "test",
      "id": "B12",
      "attributes": {
        "name": "Vitamin B12",
        "sample_volume_requirement": 180,
        "sample_tube_type": "yellow"
      }
    },
    {
      "type": "test",
      "id": "HBA1C",
      "attributes": {
        "name": "HbA1C",
        "sample_volume_requirement": 40,
        "sample_tube_type": "purple"
      }
    }
  ]
}
```

##Implementation details:  

1. Developed /test_panels API with 'api/v1' versioning. I've taken below points into consideration while developing /v1/test_panels/ API.

a. When a valid test id is passed then API should respond back with results in JSON format with status code 200.
b. Implemented API caching, to cache API response when same API request params were passed.
c. I've not validated 'include' param in API request as it is an optional attribute. We will consider params[:include] when it matches with 'test' value.
d. If any error occurs while fetching test details, /v1/test_panels/ API request will respond back with error message along with status code 404.

2. I've defined TestPanelSearch class which is responsible to fetch test panel details based on id and parse data into required format.(Defined in README.md)

3. Added RSpec test cases for

a. API requests
b. Models
c. Controllers
d. TestPanel search service

I run them, they passed.

4. Security: As we are not using any database schema or api secrets to validate authentication of API requests, I have defined api_key with value '10ae820f-8c24-4e69-888b-03cbc36c89a6' in api_key.rb
