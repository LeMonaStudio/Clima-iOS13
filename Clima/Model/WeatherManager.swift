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
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherData(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseData(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseData(_ safeData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: safeData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionID: id, name: name, temperature: temp)
            return weather
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}
