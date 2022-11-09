//
//  WeatherManager.swift
//  Weather_App
//
//  Created by Mayk on 9/27/22.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    private let APIKey: String = "6de610c0a9e87cdaf1b93a295e60492d"
    let numberOfDays: Int = 16
    
// MARK: - Current Weather
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKey)&units=metric&lang=es") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        print("Current: \(decodeData)")
        return decodeData
    }
    
// MARK: - Daily Forecast
    
    func getDailyForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> DailyResponse {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitude)&lon=\(longitude)&cnt=\(numberOfDays)&appid=\(APIKey)&units=metric&lang=es") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weathear data")}
        
        let decodeData = try JSONDecoder().decode(DailyResponse.self, from: data)
        print("Daily: \(decodeData)")
        return decodeData
    }
}
