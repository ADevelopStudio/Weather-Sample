//
//  MainTableViewController.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

class MainTableViewController: UITableViewController {

    var cities = DataStorage.getSavedCities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CityWeatherCell", bundle: nil), forCellReuseIdentifier: "CityWeatherCell")
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cities = DataStorage.getSavedCities()
        self.tableView.reloadData()
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
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CityWeatherCell,
              let cityWeather = cell.cityWeather else {
            self.performSegue(withIdentifier: "details", sender: PassedToDetailView.needToLoad(city:  cities[indexPath.row]))
            return
        }
        self.performSegue(withIdentifier: "details", sender: PassedToDetailView.fulldata(data: cityWeather))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailedWeatherVC, let data = sender as? PassedToDetailView {
            vc.passedData = data
        }
    }
    
}
