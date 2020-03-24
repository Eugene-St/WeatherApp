//
//  ViewController+alertController.swift
//  WeatherApp
//
//  Created by Eugene St on 22.03.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

extension ViewController {
  func showAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    alert.addTextField { tf in
      let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
      tf.placeholder = cities.randomElement()
    }
    
    let search = UIAlertAction(title: "Search", style: .default) { action in
      let textField = alert.textFields?.first
      guard let cityName = textField?.text else { return }
      if cityName != "" {
//        NetworkWeatherManager.fetchCurrentWeather(for: cityName)
        let city = cityName.split(separator: " ").joined(separator: "%20")
        completionHandler(city)
        
      }
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alert.addAction(search)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
    
  }
}
