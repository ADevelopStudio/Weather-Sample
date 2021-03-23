//
//  DetailedWeatherVC.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

class DetailedWeatherVC: UIViewController {
    @IBOutlet weak var weatherConditions: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherIcon: UIImageView!

    var passedData: PassedToDetailView = .nothing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.checkDataPassed()
    }

    
    private func checkDataPassed()  {
        switch passedData {
        case .nothing:
            fatalError()
        case .fulldata:
            self.fillTheView()
        case .needToLoad(let city):
            self.weatherConditions.text = "Loading..."
            NetworkClient.getWeather(city: city) {
                switch $0 {
                case .failure(let error):
                    self.weatherConditions.text = error.localizedDescription
                case .success(let data):
                    self.passedData = .fulldata(data: data)
                    self.fillTheView()
                }
            }
        }
    }
    
    
    private func fillTheView() {
        guard let weatherData = passedData.weatherData else { return}
        self.title = weatherData.name
        self.weatherConditions.text = weatherData.getData(type: .weatherDescr).uppercased()
        weatherIcon.load(url: weatherData.imageUrl)
        self.tableView.reloadData()
    }
}
