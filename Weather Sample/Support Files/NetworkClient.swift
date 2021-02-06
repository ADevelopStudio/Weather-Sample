//
//  NetworkClient.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import Foundation
struct NetworkClient {
    
    private static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private static let appID = "6fb230ebd5acaa6946bf6d09830d27fc"
    
    static func getWeather(cityId: Int, complition:  @escaping(Result<WeatherData, Error>)->()) {
        guard let url = URL(string: "\(baseURL)?id=\(cityId)&units=metric&APPID=\(appID)") else {
            let manualError = NSError(domain: baseURL, code:  0, userInfo: [NSLocalizedDescriptionKey: "Cant create URL"])
            complition(.failure(manualError))
            return
        }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data else {
                let manualError = NSError(domain: url.absoluteString, code:  0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
                complition(.failure(error ?? manualError))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let weatherData: WeatherData = try decoder.decode(WeatherData.self, from: data)
                print(weatherData)
                complition(.success(weatherData))
            } catch {
                complition(.failure(error))
                print("Error: \(error)")
            }
        })
        task.resume()
    }
    
}
