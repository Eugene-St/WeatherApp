//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Eugene St on 23.03.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

struct CurrentWeatherData: Codable {
  let name: String
  let main: Main
  let weather: [Weather]
}

struct Main: Codable {
  let temp: Double
  let feelsLike: Double
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
  }
}

struct Weather: Codable {
  let id: Int
}
