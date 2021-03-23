//
//  Weather_SampleTests.swift
//  Weather SampleTests
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import XCTest
@testable import Weather_Sample

class Weather_SampleTests: XCTestCase {
    var sut: URLSession!
    
    override func setUp() {
      super.setUp()
      sut = URLSession(configuration: .default)
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }

    
    func testJSON() throws {
        let str = """
         {
             "coord": {
                 "lon": -80.6081,
                 "lat": 28.0836
             },
             "weather": [
                 {
                     "id": 800,
                     "main": "Clear",
                     "description": "clear sky",
                     "icon": "01n"
                 }
             ],
             "base": "stations",
             "main": {
                 "temp": 290.3,
                 "feels_like": 288.56,
                 "temp_min": 288.71,
                 "temp_max": 292.15,
                 "pressure": 1015,
                 "humidity": 63
             },
             "visibility": 10000,
             "wind": {
                 "speed": 2.57,
                 "deg": 230
             },
             "clouds": {
                 "all": 1
             },
             "dt": 1612577101,
             "sys": {
                 "type": 1,
                 "id": 4922,
                 "country": "US",
                 "sunrise": 1612526834,
                 "sunset": 1612566343
             },
             "timezone": -18000,
             "id": 4163971,
             "name": "Melbourne",
             "cod": 200
         }
        """
        let jsonData = str.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let weatherData: WeatherData = try decoder.decode(WeatherData.self, from: jsonData)
        XCTAssertTrue(weatherData.name == "Melbourne")

        self.testIfAllGood(with: weatherData)
    }
    
    
    func testIfAllGood(with weatherData: WeatherData) {
        XCTAssertNotNil(weatherData)
        ///testing all the properties
        TypeOfWeatherData.allValues.forEach {
            XCTAssertTrue(!weatherData.getData(type: $0).isEmpty)
        }
    }
    
    func testValidAPICall() {
        
      // Sydney 2147714
      let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=2147714&units=metric&APPID=6fb230ebd5acaa6946bf6d09830d27fc")
      let promise = expectation(description: "Status code: 200")
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let weatherData: WeatherData = try decoder.decode(WeatherData.self, from: data)
                    XCTAssertTrue(weatherData.name == "Sydney", weatherData.name)
                    self.testIfAllGood(with: weatherData)
                } catch {
                    XCTFail("Error: \(error.localizedDescription)")
                    return
                }
            } else {
                XCTFail("Error: No data received")
            }
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 10)
    }
    
    
    func testViewModel() {
        let bundle = Bundle(for: CityWeatherCell.self)
        guard let cell = bundle.loadNibNamed("CityWeatherCell", owner: nil)?.first as? CityWeatherCell else {
            return XCTFail("CustomView nib did not contain a CityWeatherCell")
         }
        
        
        let model1 = CityWeatherCellDataType.loadingFailed(City(id: 123, name: "Test"))
        cell.viewModel = model1
        XCTAssertTrue(cell.loader.isHidden)
        XCTAssertTrue(cell.cityName.text == "Test")
        XCTAssertTrue(cell.subtitleLabel.text == "failed")
        
        
        
        let model2 = CityWeatherCellDataType.loading(City(id: 123, name: "Test"))
        cell.viewModel = model2
        XCTAssertTrue(!cell.loader.isHidden)
        XCTAssertTrue(cell.cityName.text == "Test")
        XCTAssertTrue(cell.subtitleLabel.text == "loading...")
        
        let example = WeatherData.example
        let model3 = CityWeatherCellDataType.loaded(example)
        
        cell.viewModel = model3
        XCTAssertTrue(cell.loader.isHidden)
        XCTAssertTrue(cell.cityName.text == example.name)
        XCTAssertTrue(cell.subtitleLabel.text == example.getData(type: .temperature))
    }
}

