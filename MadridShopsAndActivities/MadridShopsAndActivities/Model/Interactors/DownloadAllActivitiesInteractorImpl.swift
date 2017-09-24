//
//  DownloadAllActivitiesImpl.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

class DownloadAllActivitiesInteractorImpl: DownloadAllActivities {
    
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        
        let session = URLSession.shared
        let urlString = kActivitiesUrl
        
        let task = session.dataTask(with: URL(string: urlString)!) {
            (data: Data?, response: URLResponse?, error:Error?) in
            
            //Send response in main thread because we are in a background thread and this affects the UI
            OperationQueue.main.addOperation {
                
                if error == nil {
                    //Success
                    let activities = parseActivities(data: data!)
                    onSuccess(activities)
                    
                } else {
                    if let myError = onError {
                        myError(error!)
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func execute(onSuccess: @escaping (Activities) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
}
