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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupUI() {
        
        loadImages()
    }
    
    func loadImages() {
        //to do
    }

}
