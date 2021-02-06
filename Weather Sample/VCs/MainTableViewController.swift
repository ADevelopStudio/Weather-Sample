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
        return UITableView.automaticDimension
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
}
