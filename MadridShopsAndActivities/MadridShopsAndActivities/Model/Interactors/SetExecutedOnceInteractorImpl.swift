//
//  SetExecutedOnceImplInteractor.swift
//  MadridShops
//
//  Created by Tomás Ignacio Moyano on 9/18/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

class SetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    
    func set(key: String) {
        let defaults = UserDefaults.standard
        defaults.set(kSaved, forKey: key)
        
        defaults.synchronize()
    }
}
