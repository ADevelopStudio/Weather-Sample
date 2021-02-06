//
//  SearchCityVC.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

extension SearchCityVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.cityList = DataStorage.searchCities(startingWith: searchText)
            self.tableView.reloadData()
        })
    }
}


class SearchCityVC: UITableViewController {

    var cityList = DataStorage.allTheCities
    var savedCities = DataStorage.getSavedCities()
    
    var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchTimer?.invalidate()
        DataStorage.save(cityList: savedCities)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city = cityList[indexPath.row]
        cell.textLabel?.text = city.name
        cell.accessoryType = savedCities.contains(city) ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        let city = cityList[indexPath.row]
        if let index = savedCities.firstIndex(of: city) {
            savedCities.remove(at: index)
        } else {
            savedCities.append(city)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
