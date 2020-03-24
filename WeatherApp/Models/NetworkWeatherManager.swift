//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Eugene St on 22.03.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit
import CoreLocation

class NetworkWeatherManager {
  
  enum RequestType {
    case cityName(city: String)
    case coordinate(lattitude: CLLocationDegrees, longtitude: CLLocationDegrees)
    
  }
  
  var onCompletion: ((CurrentWeather) -> Void)?
  
  func fetchCurrentWeather(for requestType: RequestType) {
    
    var urlString = ""
    
    switch requestType {
    case .cityName(let city):
      urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&apikey=\(apiKey)"
    case .coordinate(let lattitude, let longtitude):
      urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lattitude)&lon=\(longtitude)&units=metric&apikey=\(apiKey)"
    }
    performRequest(withUrlString: urlString)
  }
  
  fileprivate func performRequest(withUrlString urlString: String) {
    guard let url = URL(string: urlString) else { return }
    
    let session = URLSession(configuration: .default)
    
    // Set address from where we what to get data
    let task = session.dataTask(with: url) { data, response, error in
      if let data = data {
        
        guard let currentWeather = self.parseJSON(withData: data) else { return }
        self.onCompletion?(currentWeather)
      }
    }
    task.resume()
  }
  
  fileprivate func parseJSON(withData data: Data) -> CurrentWeather?{
    let decoder = JSONDecoder()
    
    do {
      let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
      // используем guard потому что инициализатор может вернуть нил
      guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
        return nil
        // либо можно вызвать Fatal Error или обработать ошибку
      }
      return currentWeather
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    return nil
  }
}





