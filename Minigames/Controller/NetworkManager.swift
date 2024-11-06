//
//  NetworkManager.swift


import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()

    private var path = "https://api.weatherapi.com/v1/current.json?key=cd0613f193cf432d89b200358240611&q="
    
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
