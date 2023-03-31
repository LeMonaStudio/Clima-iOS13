//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Musa Lawrence on 3/30/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}
