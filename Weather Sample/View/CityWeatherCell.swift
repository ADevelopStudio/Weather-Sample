//
//  CityWeatherCell.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

class CityWeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var cityWeather: WeatherData? {
        didSet {
            if let cityWeather = cityWeather {
                self.loader.isHidden = true
                self.subtitleLabel.text =  cityWeather.getData(type: .temperature)
                self.weatherIcon.load(url: cityWeather.smallImageUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func fillWith(city: City) {
        self.cityName?.text = city.name
        loader.isHidden = false
        if !loader.isAnimating {loader.startAnimating()}
        subtitleLabel.text = "Loading..."
        cityWeather = nil
        self.loadWeather(city: city)
    }
        
    
    private func loadWeather(city: City) {
        NetworkClient.getWeather(city: city) { [self] in
            switch $0 {
            case .success(let data):
                self.cityWeather = data
            case .failure(_):
                self.subtitleLabel.text = "Error"
                loader.isHidden = true
            }
        }
    }
}
