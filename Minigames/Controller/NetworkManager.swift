//
//  NetworkManager.swift


import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private lazy var urlComponent:URLComponents = {
        var component = URLComponents()
        component.host = "api.themoviedb.org"
        component.scheme = "https"
        component.queryItems = [
            URLQueryItem(name: "api_key", value: "24f34852da71416cabd162945240809")
        ]
        
        return component
    }()
    private var path = "https://api.weatherapi.com/v1/current.json?key=24f34852da71416cabd162945240809&q="
    
    func loadWeather(locationPath:String, complition: @escaping (Weather)-> Void) {
        guard let url = URL(string: path+locationPath+"&aqi=no") else {return}
        AF.request(url).responseDecodable(of: Weather.self) { result in
            if let weather = try? result.result.get() {
                DispatchQueue.main.async {
                    complition(weather)
                }
            }
        }
        
        
    }
}
