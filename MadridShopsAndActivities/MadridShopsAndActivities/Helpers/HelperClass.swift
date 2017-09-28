//
//  HelperClass.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/26/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

class HelperClass {

    static func showOneOptionAlert(title:String, message:String, okButtonTitle:String, presenter:UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: okButtonTitle, style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("Dismiss AlertView")
        }
        
        alertController.addAction(okAction)
        presenter.present(alertController, animated: true, completion: nil)
    }
    
}
