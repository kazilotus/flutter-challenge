## MonogDB Schema Structure

```
entry:
  idx: Number                 # Order in list of the Client
  name: String                # Name of the Client
  service: String             # Service that client requires
  completed: Boolean          # Whether the service has been completed
  
waitlist:
  date: String                # Date of the document associated
  entries: [ entry: Entry ]   # Array of all the entries made in a day
```

## API Endpoints and Request Data Structures

### Waitlist

`GET     /waitlists`

`PATCH   /waitlist/:date`
```
{
    "date": "15-08-2022",
    "entries": [
        {
            
            "_id": "62f8ff5492b58c22e2c25671",
            "idx": 0,
            "name": "Golden",
            "completed": false,
            "service": "Teeth Brushing"
            
        }
    ]
}
```

### Entry

`POST    /entry/:date`
```
{
    "idx": 12,
    "name": "Max",
    "service": "Grooming",
    "completed": false
}
```

`PATCH   /entry/:date/:id`
```
{
    "idx": 12,
    "name": "Max",
    "service": "Grooming",
    "completed": true
}
```

`DELETE   /entry/:date/:id`
