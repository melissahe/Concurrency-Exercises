//
//  CountryDetailViewController.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    //Country
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subRegionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    //Weather
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var country: Country!
    var weatherImageURLString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        //Country
        nameLabel.text = country.name
        capitalLabel.text = (country.capital != "") ? country.capital : "No capital available"
        regionLabel.text = country.region
        subRegionLabel.text = country.subRegion
        populationLabel.text = country.population.description
        currencyNameLabel.text = "\(country.currencySymbol), \(country.currencySymbol), \(country.currencyName)"
        
        //Weather
        self.weatherStateLabel.text = ""
        self.currentTempLabel.text = ""
        self.minTempLabel.text = ""
        self.maxTempLabel.text = ""
        
        
        WeatherAPIClient.manager.getWeatherInfo(
            from: country.capital,
            completionHandler: { (weather) in
                guard let weather = weather else {
                    self.weatherStateLabel.text = "No weather data available"
                    return
                }
                

                    self.weatherStateLabel.text = weather.weatherStateName
                    self.currentTempLabel.text = weather.currentTemp.description
                    self.minTempLabel.text = weather.minTemp.description
                    self.maxTempLabel.text = weather.maxTemp.description

                //Weather Image
                let urlString = "https://www.metaweather.com/static/img/weather/png/\(weather.weatherStateAbbr).png"
                ImageAPIClient.manager.getImages(
                    from: urlString,
                    completionHandler: { (onlineWeatherImage) in
                        self.weatherImageView.image = onlineWeatherImage
                },
                    errorHandler: {print($0)})
        },
            errorHandler: { (appError) in
                switch appError {
                case .badURL:
                    print("bad url for weather")
                case .badStatusCode:
                    print("bad status code for weather")
                case .couldNotParseJSON(rawError: let error):
                    print("weather: \(error)")
                default:
                    print(appError)
                }
        })
    
        loadImages()
    }
    
    func loadImages() {
        //Country
        let urlString = "http://www.geognos.com/api/en/countries/flag/\(country.countryCode).png"
        ImageAPIClient.manager.getImages(
            from: urlString,
            completionHandler: { (onlineFlagImage) in
                self.countryFlagImageView.image = onlineFlagImage
        },
            errorHandler: {print($0)})
    
    }

}
