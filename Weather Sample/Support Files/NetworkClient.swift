//
//  NetworkClient.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import Foundation
struct NetworkClient {
    
    private static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private static let appID = "6fb230ebd5acaa6946bf6d09830d27fc" //ENTER HERE
    
    static func getWeather(city: City, complition:  @escaping(Result<WeatherData, Error>)->()) {
        if appID.isEmpty { fatalError("enter AppID")}
        guard let url = URL(string: "\(baseURL)?id=\(city.id)&units=metric&APPID=\(appID)") else {
            let manualError = NSError(domain: baseURL, code:  0, userInfo: [NSLocalizedDescriptionKey: "Cant create URL"])
            DispatchQueue.main.async { complition(.failure(manualError)) }
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
                DispatchQueue.main.async { complition(.failure(error ?? manualError))}
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let weatherData: WeatherData = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async { complition(.success(weatherData))}
            } catch {
                DispatchQueue.main.async { complition(.failure(error))}
            }
        })
        task.resume()
    }
    
}
