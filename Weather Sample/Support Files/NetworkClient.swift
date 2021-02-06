//
//  NetworkClient.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import Foundation
struct NetworkClient {
    static func getWeather() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=4163971&units=metric&APPID=6fb230ebd5acaa6946bf6d09830d27fc") else {return}
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let test: WeatherData = try decoder.decode(WeatherData.self, from: data)
                print(test)
            } catch {
                print("Error: \(error)")
            }
        })
        task.resume()
    }
    
}
