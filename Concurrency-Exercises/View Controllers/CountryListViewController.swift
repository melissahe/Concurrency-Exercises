//
//  ViewController.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {

    //Table View Variables
    @IBOutlet weak var countryTableView: UITableView!
    var countries: [Country] = [] {
        didSet {
            countryTableView.reloadData()
        }
    }
    
    //Search Bar Variables
    @IBOutlet weak var countrySearchBar: UISearchBar!
    var filteringIsOn: Bool = false
    var searchTerm = "" {
        didSet {
            filteringIsOn = (searchTerm != "") ? true : false
            
            searchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
            
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countrySearchBar.delegate = self
        loadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func loadData() {
        let urlString = (!filteringIsOn) ? "https://restcountries.eu/rest/v2/" : "https://restcountries.eu/rest/v2/name/\(searchTerm)"
        
        CountryAPIClient.manager.getCountries(
            from: urlString,
            completionHandler: { (onlineCountries) in
                self.countries = onlineCountries
                
        }, errorHandler: { (appError) in
            switch appError {
            case .badStatusCode:
                print("Error: bad status code")
                return
            case .badURL:
                print("Error: could not convert into url")
                DispatchQueue.main.async {
                    //lazy lol
                    self.countrySearchBar.text = "could not convert into url"
                }
                return
            case .couldNotParseJSON(let error):
                print("Error: could not parse json, \(error)")
                return
            case .noDataReceived:
                print("Error: no data received")
                return
            default:
                print(appError)
                return
            }
        })
    }
    
}

//Table View Methods
extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let currentCountry = countries[indexPath.row]
        
        if let countryCell = cell as? CountryTableViewCell {
            countryCell.countryFlagImageView.image = nil
            countryCell.nameLabel.text = currentCountry.name
            countryCell.capitalLabel.text = currentCountry.capital
            countryCell.populationLabel.text = currentCountry.population.description
            countryCell.countryFlagImageView.image = #imageLiteral(resourceName: "placeholder_flag")
            
            let imageURL = "http://www.geognos.com/api/en/countries/flag/\(currentCountry.countryCode).png"
            
            ImageAPIClient.manager.getImages(
                from: imageURL,
                completionHandler: { (onlineImage) in
                    countryCell.countryFlagImageView.image = onlineImage
                    countryCell.setNeedsLayout()
            },
                errorHandler: { (appError) in
                    switch appError {
                    case .badURL:
                        print("Error: cannot initialize image url")
                        return
                    case .cannotInitializeImage:
                        print("Error: cannot initialize image from url")
                        return
                    case .badStatusCode:
                        print("Error: bad status code for image url")
                    default:
                        print(appError)
                        return
                    }
            })
            
            return countryCell
        }
        
        return cell
    }
}

//Search Bar Methods
extension CountryListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        if searchText == searchTerm {
            return
        }
        
        searchTerm = searchText
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" && searchTerm != searchText {
            searchTerm = ""
        }
    }
}

