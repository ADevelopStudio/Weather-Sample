//
//  WeatherData.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import Foundation


fileprivate struct Location: Codable {
    var longitude: Double
    var latitude : Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

fileprivate struct WeatheDetails: Codable {
    var details: String
    var icon: String

    enum CodingKeys: String, CodingKey {
        case details = "description"
        case icon
    }
}
fileprivate struct WeatherMain: Codable {
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
    private var coord: Location
    private var weather: [WeatheDetails]
    private var main: WeatherMain
}

extension WeatherData {
    var imageUrl: URL? {
        guard let icon = self.weather.first?.icon, !icon.isEmpty,
              let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else {
            return nil
        }
        return url
    }
    var smallImageUrl: URL? {
        guard let icon = self.weather.first?.icon, !icon.isEmpty,
              let url = URL(string: "https://openweathermap.org/img/wn/\(icon).png") else {
            return nil
        }
        return url
    }
    
    func getData(type: TypeOfWeatherData) -> String {
        switch type {
        case .humidity:
            return "\(Int(self.main.humidity))%"
        case .weatherDescr:
            return self.weather.map({$0.details}).joined(separator: ", ")
        case .temperature:
            return "\(self.main.temp < 0 ? "" : "+")\(Int(self.main.temp))℃"
        case .temperatureFillsLike:
            return "\(self.main.feelsLike < 0 ? "" : "+")\(Int(self.main.feelsLike))℃"
        case .temperatureMax:
            return "\(self.main.tempMax < 0 ? "" : "+")\(Int(self.main.tempMax))℃"
        case .temperatureMin:
            return "\(self.main.tempMin < 0 ? "" : "+")\(Int(self.main.tempMin))℃"
        case .pressure:
            return "\(Int(self.main.pressure)) hPa"
        }
    }
}
