//
//  Enums.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import Foundation





enum TypeOfDataToDetailedVC {
    case needToLoad(city: City), fulldata(data: WeatherData), nothing
    var weatherData: WeatherData? {
        switch self {
        case .fulldata(let data):
            return data
        default:
            return nil
        }
    }
}

enum TypeOfWeatherData {
    static let allValues = [TypeOfWeatherData.temperature, .temperatureFillsLike , .temperatureMin, .temperatureMax, .pressure, .humidity]
    case weatherDescr
    case temperature
    case temperatureFillsLike
    case temperatureMax
    case temperatureMin
    case pressure
    case humidity
    
    var title: String {
        switch self {
        case .weatherDescr:
            return ""
        case .temperature:
            return "Temperature"
        case .temperatureFillsLike:
            return "Fills Like"
        case .temperatureMax:
            return "Temperature Max"
        case .temperatureMin:
            return "Temperature Min"
        case .pressure:
            return "Pressure"
        case .humidity:
            return "Humidity"
        }
    }
}
