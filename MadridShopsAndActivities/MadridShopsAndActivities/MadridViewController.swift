//
//  ViewController.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/24/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

class MadridViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = parent?.restorationIdentifier
    }
}

