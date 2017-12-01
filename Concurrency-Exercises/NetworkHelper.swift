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
    let urlSession = URLSession(configuration: .default)
    func getData(from url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (AppError) -> Void) {
        
        let request = URLRequest(url: url)
        
        //grab data using global thread
        DispatchQueue.global(qos: .userInitiated).async {
            self.urlSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                DispatchQueue.main.async {
                    guard let data = data else {
                        errorHandler(.noDataReceived)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        errorHandler(.badStatusCode)
                        return
                    }
                    
                    if let error = error {
                        errorHandler(.other(rawError: error))
                        return
                    }
                    
                    completionHandler(data)
                }
                
                }.resume()
        }
    }
}
