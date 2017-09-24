//
//  DownloadAllShopsInteractorImpl.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorImpl: DownloadAllShops {
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        
        let session = URLSession.shared
        let urlString = kShopsUrl
        
        let task = session.dataTask(with: URL(string: urlString)!) {
            (data: Data?, response: URLResponse?, error:Error?) in
            
            //Send response in main thread because we are in a background thread and this affects the UI
            OperationQueue.main.addOperation {
                
                if error == nil {
                    //Success
                    let shops = parseShops(data: data!)
                    onSuccess(shops)
                    
                } else {
                    if let myError = onError {
                        myError(error!)
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
}
