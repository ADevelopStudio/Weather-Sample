//
//  MainTableViewController.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

class MainTableViewController: UITableViewController, Storyboarded {
    weak var coordinator: MainCoordinator?

    var cities = DataStorage.getSavedCities()
    
    fileprivate var timerForUpdate: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CityWeatherCell", bundle: nil), forCellReuseIdentifier: "CityWeatherCell")
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func searchCitiesPressed(_ sender: Any) {
        coordinator?.searchCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cities = DataStorage.getSavedCities()
        self.tableView.reloadData()
        
        //update the weather every 1 minute if you're on this screen
        timerForUpdate?.invalidate()
        timerForUpdate = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { (_) in
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherCell", for: indexPath) as? CityWeatherCell else {
            return UITableViewCell()
        }
        cell.fillWith(city: cities[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CityWeatherCell,
              let cityWeather = cell.cityWeather else {
            coordinator?.showWeatherDetailed(data:  .needToLoad(city:  cities[indexPath.row]))
            return
        }
        coordinator?.showWeatherDetailed(data: .fulldata(data: cityWeather))
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.1, delay:  0.1 * Double(indexPath.row), options: [.curveEaseInOut]) {
            cell.alpha = 1
        }
    }
}
