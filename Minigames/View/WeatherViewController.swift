//
//  WeatherViewController.swift
//  Minigames
//
//  Created by Ерош Айтжанов on 08.09.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func conf(location: String) {
        NetworkManager.shared.loadWeather(locationPath: location) { data in
            self.cityLabel.text = data.location.name + ", " + data.location.region
            self.degreeLabel.text = String(data.current.tempC) + "°C" + " " + self.emojiForWeatherCondition(code: data.current.condition.code)
        }
    }
    
    // Location
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("started")
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        var loc = String(format: "%.4f", lat) + "," + String(format: "%.4f", long)
        conf(location: loc)
    }
    // Location above
    
    func setupUI() {
        view.addSubview(cityLabel)
        view.addSubview(degreeLabel)
    
        NSLayoutConstraint.activate([
            // Layout the main stack view
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            degreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            degreeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            
        
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        setupLocation()
        
        // Do any additional setup after loading the view.
    }
    
    func emojiForWeatherCondition(code: Int) -> String {
        switch code {
        case 1000:
            return "☀️"  // Sunny
        case 1003:
            return "🌤"  // Partly cloudy
        case 1006, 1009:
            return "☁️"  // Cloudy or Overcast
        case 1030, 1135, 1147:
            return "🌫"  // Mist, Fog, or Freezing fog
        case 1063, 1180, 1183, 1240:
            return "🌦"  // Patchy rain or light rain
        case 1066, 1210, 1213, 1255:
            return "🌨"  // Patchy snow or light snow
        case 1069, 1072, 1204, 1249:
            return "🌨❄️"  // Patchy sleet or ice pellets
        case 1087, 1273:
            return "⛈"  // Thundery outbreaks
        case 1117, 1219, 1225, 1258:
            return "❄️"  // Blizzard or heavy snow
        case 1150, 1153, 1168:
            return "🌧💧"  // Light drizzle or freezing drizzle
        case 1192, 1195, 1243:
            return "🌧"  // Heavy rain or showers
        case 1276:
            return "🌩"  // Heavy rain with thunder
        case 1282:
            return "🌩❄️"  // Heavy snow with thunder
        default:
            return " "  // Default for unknown weather conditions
        }
    }
    
}
