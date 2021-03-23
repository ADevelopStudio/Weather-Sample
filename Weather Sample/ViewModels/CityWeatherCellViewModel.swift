//
//  CityWeatherCellViewModel.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 23/3/21.
//

import Foundation

protocol CityWeatherCellViewModel {
    var title: String {get}
    var subTitle: String {get}
    var iconURL: URL? {get}
    var isLoading: Bool {get}
    func loadFullData(complition: @escaping (CityWeatherCellViewModel)->())
}
