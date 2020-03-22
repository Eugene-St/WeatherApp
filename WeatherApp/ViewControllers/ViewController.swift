//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eugene St on 22.03.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var feelsLikeTemperature: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  @IBAction func searchPressed(_ sender: UIButton) {
    showAlertController(withTitle: "Enter city name", message: nil, style: .alert)
  }
  
}

