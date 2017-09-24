//
//  DownloadAllInteractor.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

typealias errorClosure = ((Error) -> Void)?

protocol DownloadAllShops {
    //Downloads all shops and returns success (Shops) or Error
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Shops) -> Void)
    
}

protocol DownloadAllActivities {
    //Downloads all activities and returns success (Activities) or Error
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Activities) -> Void)
}
