//
//  ImageAPIClient.swift
//  Concurrency-Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImages(from urlString: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlString) else {
            errorHandler(.badURL)
            return
        }
        
        NetworkHelper.manager.getData(
            from: url,
            completionHandler: { (data: Data) in
                
                guard let image = UIImage(data: data) else {
                    errorHandler(.cannotInitializeImage)
                    return
                    
                }
                
                DispatchQueue.main.async {
                    completionHandler(image)
                }
                
        },
            errorHandler: errorHandler)
    }
}
