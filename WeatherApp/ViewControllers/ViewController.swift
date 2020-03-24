//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eugene St on 22.03.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  // MARK: - IB Outlets
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var feelsLikeTemperature: UILabel!
  
  // MARK: Public property
  let networkManager = NetworkWeatherManager()
  lazy var locationManager: CLLocationManager = {
    let lm = CLLocationManager()
    
    lm.delegate = self
    lm.desiredAccuracy = kCLLocationAccuracyKilometer
    lm.requestWhenInUseAuthorization()
    
    return lm
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkManager.onCompletion = { [weak self] currentWeather in // Weak self используем для того
      //что бы не было утечки памяти когда закрываем экран
      guard let self = self else { return }
      self.updateInterfaceWith(weather: currentWeather)
    }
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.requestLocation()
    }
  }
  
  // MARK: - IB Actions
  @IBAction func searchPressed(_ sender: UIButton) {
    showAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self] city in
      self?.networkManager.fetchCurrentWeather(for: .cityName(city: city))
    }
  }
  
  // MARK: - Private methods
  private func updateInterfaceWith(weather: CurrentWeather) {
    DispatchQueue.main.async {
      self.cityLabel.text = weather.cityName
      self.temperatureLabel.text = weather.temperatureString
      self.feelsLikeTemperature.text = weather.feelsLikeTemperatureString
      self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
    }
  }
}

// MARK: - CLLocation Manager Delegate
extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    let lattitude = location.coordinate.latitude
    let longtitude = location.coordinate.longitude
    
    networkManager.fetchCurrentWeather(for: .coordinate(lattitude: lattitude, longtitude: longtitude))
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
  
}
