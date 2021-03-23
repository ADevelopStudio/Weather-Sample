//
//  CityWeatherCellDataType.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 23/3/21.
//

import Foundation
extension CityWeatherCellDataType: CityWeatherCellViewModel {
    
    var title: String {
        switch self {
        case .loaded(let fullData):
            return fullData.name
        case .loading(let city):
            return city.name
        case .loadingFailed(let city):
            return city.name
        }
    }
    
    var subTitle: String {
        switch self {
        case .loaded(let fullData):
            return fullData.getData(type: .temperature)
        case .loading:
            return "loading..."
        case .loadingFailed:
            return "failed"
        }
    }
    
    var iconURL: URL? {
        switch self {
        case .loaded(let fullData):
            return fullData.imageUrl
        case .loading, .loadingFailed:
            return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loaded, .loadingFailed:
            return false
        case .loading:
            return true
        }
    }
    
    func loadFullData(complition: @escaping (CityWeatherCellViewModel) -> ()) {
        switch self {
        case .loading(let city):
            NetworkClient.getWeather(city: city) {
                switch $0 {
                case .success(let data):
                    complition(CityWeatherCellDataType.loaded(data))
                case .failure(_):
                    complition(CityWeatherCellDataType.loadingFailed(city))
                }
            }
        default:
            return
        }

    }
}


enum CityWeatherCellDataType {
    case loading(City), loaded(WeatherData), loadingFailed(City)
}
