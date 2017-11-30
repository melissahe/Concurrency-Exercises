//
//  NetworkHelper.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    func getData(from urlString: String, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        
    }
}
