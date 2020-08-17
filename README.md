# MyOpenWeather

## Introduction

This framework allows a connection with [API OpenWeather](https://openweathermap.org/api). Only 2 services has been implemented.

This Framework use:

- an Enum Endpoint to identify a service.
- a Protocol OWAPI for update your Model.
- a Struct Reponse (Codable with JSONDecoder) to collect service reponse .
- an Enum APIError with a errorDescription.

Every public methods has a unit Test.

**This Framework is compiled under the x86_64 architecture (for the iOS simulator)**

## How to use

The class OpenWeatherWS() should work with your API_KEY and a URLSession.

``` Swift

    import OpenWeatherFramework
    
    let ws = OpenWeatherWS(APIKey: "{YOUR_API_KEY}", Session: URLSession.shared)

```

### Services

The Endpoint .weather(City:) allows you to create a request:

``` Swift

    // Request is optional due to query character restrictions.
    if let request = ws.request(Endpoint: .weather(City: name)) {
    
        // Use with the classic URLSession.shared
        URLSession.shared.dataTask(with: request) { (data, rep, err) in
        
            if let error = err {
                // Handle Error 
                }
        
            else if let data = data {
                // Play with the Data
            }
            
        }.resume()
    }
    
```

__Available for :__ Weather, OneCall

The method weatherTask(CityName:,Callback:) allows you to retrieve a struct (JSONDecodable) OpenWeather.WeatherReponse.

``` Swift

    ws.weatherTask(CityName: City) { (result) in
        
        switch result {
        case .success(let data): reponse = data.weathers[0].description
        case .failure(let error): reponse = error.localizedDescription
        }
    }
```

__Available for :__ Weather, OneCall

The method weatherUpdate(Model:, Result:) allows you to update your own Model with the protocol OWAPIWeather.

``` Swift

    class MyModel : OWAPIWeather {
        // var mainTemp : Double = 0
        // var cityNameRequest : String = "Paris"
        // ...
    }
    
    let model = MyModel()
    
    print(model.mainTemp) // -> 0
    
    ws.weatherUpdate(Model: model) { (result) in
        
        switch result {
        case .success(let hasUpdate):
            print(hasUpdate) // Yes
            print(model.mainTemp) // 19.0
        case .failure(let error): reponse = error.localizedDescription
        }
    }

```
__Available for :__ Weather

## Developped by Luc CASIMIR. 

