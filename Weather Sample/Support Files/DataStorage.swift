//
//  DataStorage.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import Foundation

struct DataStorage {
    
    ///beause I didn't want to spent time to create a storage to all 200,000 cities
    static let allTheCities: [City] = [
        City(id: 4163971, name: "Sydney"),
        City(id: 2147714, name: "Melbourne"),
        City(id: 2174003, name: "Brisbane"),
        City(id: 2165087, name: "Gold Coast"),
        City(id: 7839567, name: "Cairns"),
        City(id: 2063523, name: "Perth"),
        City(id: 2078025, name: "Adelaide"),
        City(id: 2172517, name: "Canberra"),
        City(id: 7839402, name: "Darwin"),
        City(id: 2172880, name: "Byron Bay"),
        City(id: 7839672, name: "Hobart"),
        City(id: 7839399, name: "Darwin"),
        City(id: 7839402, name: "Townsville")
    ]
    
    
    static func searchCities(startingWith: String) -> [City]{
        let searchStr = startingWith.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchStr.isEmpty {return self.allTheCities}
        return self.allTheCities.filter({$0.name.lowercased().hasPrefix(searchStr.lowercased())})
    }
    
    static func getSavedCities() -> [City]{
        let defaultList = [
            City(id: 4163971, name: "Sydney"),
            City(id: 2147714, name: "Melbourne"),
            City(id: 2174003, name: "Brisbane")
        ]
        guard let data = UserDefaults.standard.value(forKey:"cityList") as? Data  else {return defaultList}
        do {
            let array = try PropertyListDecoder().decode([City].self, from: data)
            return array
        } catch {
            return defaultList
        }
    }
    
    static func save(cityList: [City]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(cityList), forKey:"cityList")
    }
}
