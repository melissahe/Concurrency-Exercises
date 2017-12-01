//
//  Weather.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class Weather {
    let weatherStateName: String
    let weatherStateAbbr: String
    let minTemp: Double
    let maxTemp: Double
    let currentTemp: Double
    
    init(weatherStateName: String, weatherStateAbbr: String, minTemp: Double, maxTemp: Double, currentTemp: Double) {
        self.weatherStateName = weatherStateName
        self.weatherStateAbbr = weatherStateAbbr
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.currentTemp = currentTemp
    }
    
    convenience init?(from weatherDict: [String : Any]) {
        guard let weatherStateName = weatherDict["weather_state_name"] as? String else {
            print("Error: could not get weather name")
            return nil
        }
        
        guard let weatherStateAbbr = weatherDict["weather_state_abbr"] as? String else {
            print("Error: could not get weather name")
            return nil
        }
        
        guard let minTemp = weatherDict["min_temp"] as? Double else {
            print("Error: could not get min temp")
            return nil
        }
        
        guard let maxTemp = weatherDict["max_temp"] as? Double else {
            print("Error: could not get max temp")
            return nil
        }
        
        guard let currentTemp = weatherDict["the_temp"] as? Double else {
            print("Error: could not get current temp")
            return nil
        }
        
        self.init(weatherStateName: weatherStateName, weatherStateAbbr: weatherStateAbbr, minTemp: minTemp, maxTemp: maxTemp, currentTemp: currentTemp)
    }
}
