//
//  WeatherData.swift
//  Clima
//
//  Created by Musa Lawrence on 3/29/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
