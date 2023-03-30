//
//  WeatherManager.swift
//  Clima
//
//  Created by Musa Lawrence on 3/29/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?APPID=63fd9418bd6b65de65c95923cbf93248&units=metric"
    
    func fetchWeatherData(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseData(safeData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseData(safeData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: safeData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: id, name: name, temperature: temp)
            print(weather.temperatureString)
            
        } catch {
            print(error)
        }
    }
}
