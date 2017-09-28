//
//  CheckDownloadedDataInteractorImpl.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/29/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

class CheckExecutedOnceInteractorImpl: CheckExecutedOnceInteractor {
    
    func check(key: String) -> Bool {
        
        let defaults = UserDefaults.standard
        
        var isAlreadyExecuted = false
        
        if let _ = defaults.string(forKey: key) {
            isAlreadyExecuted = true
        }
        
        return isAlreadyExecuted
    }
    
}
