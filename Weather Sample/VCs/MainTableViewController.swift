//
//  MainTableViewController.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit
extension MainTableViewController: CityWeatherCellDelegate {
    func cityWeatherSelected(model: CityWeatherCellViewModel) {
        guard let  type = model as? CityWeatherCellDataType else {return}
        switch type {
        case .loaded(let fullData):
            coordinator?.showWeatherDetailed(data: .fulldata(data: fullData))
        case .loading(let city):
            coordinator?.showWeatherDetailed(data: .needToLoad(city: city))
        case .loadingFailed(let city):
            coordinator?.showWeatherDetailed(data: .needToLoad(city: city))
        }
    }
}


class MainTableViewController: UITableViewController, Storyboarded {
    weak var coordinator: MainCoordinator?

    var cities = DataStorage.getSavedCities()
    
    //It was a task to update the weather every 1 minute
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
        let viewModel = CityWeatherCellDataType.loading( cities[indexPath.row])
        cell.fillWith(initialData: viewModel, delegate: self)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    ///cell appearance animation
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.1, delay:  0.1 * Double(indexPath.row), options: [.curveEaseInOut]) {cell.alpha = 1}
    }
}
