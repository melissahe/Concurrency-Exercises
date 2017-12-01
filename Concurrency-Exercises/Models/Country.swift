//
//  Country.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class Country {
    let name: String
    let countryCode: String
    let capital: String
    let region: String
    let subRegion: String
    let population: Int
    let currencyCode: String
    let currencySymbol: String
    let currencyName: String
    let languages: [String]
    
    init(name: String, countryCode: String, capital: String, region: String, subRegion: String, population: Int, currencyCode: String, currencySymbol: String, currencyName: String, languages: [String]) {
        self.name = name
        self.countryCode = countryCode
        self.capital = capital
        self.region = region
        self.subRegion = subRegion
        self.population = population
        self.currencyCode = currencyCode
        self.currencySymbol = currencySymbol
        self.currencyName = currencyName
        self.languages = languages
    }
    
    convenience init?(from countryDict: [String : Any]) {
        
        guard let name = countryDict["name"] as? String else {
            print("Error: name did not work")
            return nil
        }
        
        guard let countryCode = countryDict["alpha2Code"] as? String else {
            print("Error: country code did not work")
            return nil
        }
        
        guard let capital = countryDict["capital"] as? String else {
            print("Error: capital did not work")
            return nil
        }
        
        guard let region = countryDict["region"] as? String else {
            print("Error: region did not work")
            return nil
        }
        
        guard let subRegion = countryDict["subregion"] as? String else {
            print("Error: subregion did not work")
            return nil
        }
        
        guard let population = countryDict["population"] as? Int else {
            print("Error: population did not work")
            return nil
        }
        
        guard let currencyDictArray = countryDict["currencies"] as? [[String : Any]] else {
            print("Error: cannot get currency dict")
            return nil
        }
        
        let currencyCode = currencyDictArray[0]["code"] as? String ?? "No currency code"
        
        let currencySymbol = currencyDictArray[0]["symbol"] as? String ?? ""
        
        guard let currencyName = currencyDictArray[0]["name"] as? String else {
            print("Error: cannot get currency name")
            return nil
        }
        
        guard let languageDictArray = countryDict["languages"] as? [[String : Any]] else {
            print("Error: cannot get language dict")
            return nil
        }
        
        var languages: [String] = []

        for languageDict in languageDictArray {
            guard let language = languageDict["name"] as? String else {
                print("Error: cannot get language")
                return nil
            }
            languages.append(language)
        }
        
         self.init(name: name, countryCode: countryCode, capital: capital, region: region, subRegion: subRegion, population: population, currencyCode: currencyCode, currencySymbol: currencySymbol, currencyName: currencyName, languages: languages)
    }
    
}
