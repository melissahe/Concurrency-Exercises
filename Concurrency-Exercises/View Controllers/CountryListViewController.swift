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
    
    
    //Search Bar Variables
    @IBOutlet weak var countrySearchBar: UISearchBar!
    var filteringIsOn: Bool = false
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countrySearchBar.delegate = self
    }
    
    func loadData() {
        let urlString = ""
    }
    
}

