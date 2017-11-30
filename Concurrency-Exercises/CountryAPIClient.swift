//
//  CountryAPIClient.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class CountryAPIClient {
    private init() {}
    static let manager = CountryAPIClient()
    func getCountries(from urlString: String, completionHandler: @escaping ([Country]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlString) else {
            errorHandler(.badURL)
            return
        }
        
        NetworkHelper.manager.getData(
            from: url,
            completionHandler: { (data: Data) in
                var countries: [Country] = []
                do {
                    guard let countryDictArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
                        errorHandler(.couldNotParseJSON)
                        return
                    }
                    
                    for countryDict in countryDictArray {
                        guard let country = Country(from: countryDict) else {
                            print("Error: could not initialize country")
                            return
                        }
                        
                        countries.append(country)
                    }
                } catch let error {
                    errorHandler(.other(rawError: error))
                }
                
                DispatchQueue.main.async {
                    completionHandler(countries)
                }
        },
            errorHandler: errorHandler)
    }
}
