//
//  WeatherAPiClient.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class WoeID {
    private init() {}
    static let manager = WoeID()
    func getWoeID(of city: String, completionHandler: @escaping (String?) -> Void, errorHandler: @escaping (AppError) -> Void) {
        
        let urlString = "https://www.metaweather.com/api/location/search/?query=\(city)"
        
        guard let url = URL(string: urlString) else {
            errorHandler(.badURL)
            return
        }
        
        NetworkHelper.manager.getData(
            from: url,
            completionHandler: { (data: Data) in
                do {
                    guard let cityDictArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
                        print("could not initialize [[String : Any]]")
                        return
                    }
                    
                    
                    //                    DispatchQueue.main.async {
                    guard let woeID = cityDictArray[0]["woeid"] as? String else {
                        
                        completionHandler(nil)
                        return
                    }
                    
                    
                    completionHandler(woeID)
                    //                    }
                    
                } catch let error {
                    errorHandler(.couldNotParseJSON(rawError: error))
                }
        },
            errorHandler: {errorHandler(.other(rawError: $0))}
        )
        
    }
}

class WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    func getWeatherInfo(from city: String, completionHandler: @escaping (Weather?) -> Void, errorHandler: @escaping (AppError) -> Void) {
        WoeID.manager.getWoeID(
            of: city,
            completionHandler: { (woeID) in
                guard let woeID = woeID else {
                    completionHandler(nil)
                    return
                }
                
                let urlString = "https://www.metaweather.com/api/location/\(woeID)"
                
                guard let url = URL(string: urlString) else {
                    errorHandler(.badURL)
                    return
                }
                
                NetworkHelper.manager.getData(
                    from: url,
                    completionHandler: { (data: Data) in
                        do {
                            guard let weeklyForecastDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                                print("Error: could not cast json as [String : Any]")
                                return
                            }
                            
                            guard let weatherDictArray = weeklyForecastDict["consolidated_weather"] as? [[String: Any]] else {
                                print("Error: could not cast as [[String: Any]]")
                                return
                            }
                            
                            guard let weather = Weather(from: weatherDictArray[0]) else {
                                print("Error: could not initialize weather")
                                return
                            }
                            
                            completionHandler(weather)
                            
                        } catch let error {
                            errorHandler(.other(rawError: error))
                        }
                        
                },
                    errorHandler: errorHandler)
        },
            errorHandler: errorHandler)
    }
}
