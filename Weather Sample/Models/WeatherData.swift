//
//  WeatherData.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import Foundation
/*
 {
     "coord": {
         "lon": -80.6081,
         "lat": 28.0836
     },
     "weather": [
         {
             "id": 800,
             "main": "Clear",
             "description": "clear sky",
             "icon": "01n"
         }
     ],
     "base": "stations",
     "main": {
         "temp": 290.3,
         "feels_like": 288.56,
         "temp_min": 288.71,
         "temp_max": 292.15,
         "pressure": 1015,
         "humidity": 63
     },
     "visibility": 10000,
     "wind": {
         "speed": 2.57,
         "deg": 230
     },
     "clouds": {
         "all": 1
     },
     "dt": 1612577101,
     "sys": {
         "type": 1,
         "id": 4922,
         "country": "US",
         "sunrise": 1612526834,
         "sunset": 1612566343
     },
     "timezone": -18000,
     "id": 4163971,
     "name": "Melbourne",
     "cod": 200
 }
 */

struct Location: Codable {
    var longitude: Double
    var latitude : Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct WeatheDetails: Codable {
    var details: String
    var icon: String

    enum CodingKeys: String, CodingKey {
        case details = "description"
        case icon
    }
}
struct WeatherMain: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
}


struct WeatherData: Codable {
    var id: Int
    var name: String
    var coord: Location
    var weather: [WeatheDetails]
    var main: WeatherMain
    
    var temterature: String {
        return "\(self.main.temp < 0 ? "" : "+")\(Int(self.main.temp))℃"
    }
}
