//
//  DetailedWeatherVC+TableView.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

extension DetailedWeatherVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.passedData.weatherData == nil ? 0 : TypeOfWeatherData.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherData = self.passedData.weatherData else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let element  = TypeOfWeatherData.allValues[indexPath.row]
        cell.textLabel?.text = element.title
        cell.detailTextLabel?.text = weatherData.getData(type: element)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height / 2)
        cell.alpha = 0
        UIView.animate(withDuration: 0.3, delay:  0.3 * Double(indexPath.row), options: [.curveEaseInOut]) {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
        }
    }
}
