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
                self.subtitleLabel.text =  cityWeather.getData(type: .temperature)
                self.weatherIcon.load(url: cityWeather.smallImageUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.isMultipleTouchEnabled = true
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
            self.loader.isHidden = true
            switch $0 {
            case .success(let data):
                self.cityWeather = data
            case .failure(_):
                self.subtitleLabel.text = "Error"
            }
        }
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {self.transform = CGAffineTransform(scaleX: 0.97, y:  0.97)}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {self.transform = CGAffineTransform(scaleX: 1, y:  1)}
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {self.transform = CGAffineTransform(scaleX: 1, y:  1)}
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected { UISelectionFeedbackGenerator().selectionChanged()}
    }
    
}
