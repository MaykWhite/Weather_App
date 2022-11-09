//
//  ResponseDataModel.swift
//  Weather_App
//
//  Created by Mayk on 9/27/22.
//

import Foundation

// MARK: - Current Resonse
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

// MARK: - Daily Response

struct DailyResponse: Decodable {
    let cityDaily: CityDailyResponse
    let listDaily: [ListDailyResponse]
    
    enum CodingKeys: String, CodingKey {
        case cityDaily = "city"
        case listDaily = "list"
    }
}

struct CityDailyResponse: Codable {
    let timezoneDaily: Double
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case timezoneDaily = "timezone"
        case city = "name"
    }
}

struct ListDailyResponse: Codable {
    let dateDaily: Date
    let tempDaily: TempDailyResponse
    let humidityDaily: Int
    let weatherDaily: [WeatherDailyResponse]
    
    enum CodingKeys: String, CodingKey {
        case dateDaily = "dt"
        case tempDaily = "temp"
        case humidityDaily = "humidity"
        case weatherDaily = "weather"
    }
}

struct TempDailyResponse: Codable {
    let dayTemperatureDaily: Double
    let minTemperatureDaily: Double
    let maxTemperatureDaily: Double
    
    enum CodingKeys: String, CodingKey {
        case dayTemperatureDaily = "day"
        case minTemperatureDaily = "min"
        case maxTemperatureDaily = "max"
    }
}

struct WeatherDailyResponse: Codable {
    let descriptionDaily: String
    let iconURLStringDaily: String
    
    enum CodingKeys: String, CodingKey {
        case descriptionDaily = "description"
        case iconURLStringDaily = "icon"
    }
}
