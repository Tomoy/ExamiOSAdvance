//
//  ConnectionChecker.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 10/1/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit
import FillableLoaders
import CoreData

protocol DataDownloadedDelgate {
    
    func dataIsDownloaded()
}

public class ConnectionCheckerAndDataDownloader {
    
    static let sharedInstance = ConnectionCheckerAndDataDownloader()
    var timer = Timer()
    var myLoader: WavesLoader?
    var context: NSManagedObjectContext?
    var caller: UIViewController?
    
    var delegate:DataDownloadedDelgate?
    
    private init() {
        
    }
    
    // Checks every 5 seconds if there is a connection until the user connects and then downloads the data
    func check(context:NSManagedObjectContext, caller:UIViewController) {
        
        self.context = context
        self.caller = caller
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.checkConnection), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func checkConnection() {
        //If there is a connection, stop timer and download the data
        if Reachability.isConnectedToNetwork(){
            
            timer.invalidate()
            //Create and show a custom loader while the data downloads
            createAndShowLoader()
            HelperClass.downloadAndStoreLocallyAllData(context: context!, callback: { (success:Bool, error:Error?) in
                
                if success {
                    //Remove loader when it is done
                    self.removeLoader()
                    
                    if let theDelegate = self.delegate {
                        theDelegate.dataIsDownloaded()
                    }

                } else {
                    HelperClass.showOneOptionAlert(title: kErrorAlertTitle, message: "\(kErrorDownloadingDataAlertMessage) \(error!.localizedDescription)", okButtonTitle: kGenericOkAlertButtonTitle, presenter: self.caller!)
                }
            })
            
        }else{
            //If there is no connection show alert, that connection is needed
            showNoInternetAlert()
        }
    }
    
    func createAndShowLoader() {
        
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: 50, y: 0))
        arrowPath.addLine(to: CGPoint(x: 70,y: 25))
        arrowPath.addLine(to: CGPoint(x: 60,y: 25))
        arrowPath.addLine(to: CGPoint(x: 60,y: 75))
        arrowPath.addLine(to: CGPoint(x: 40,y: 75))
        arrowPath.addLine(to: CGPoint(x: 40,y: 25))
        arrowPath.addLine(to: CGPoint(x: 30,y: 25))
        arrowPath.addLine(to: CGPoint(x: 50,y: 0))
        arrowPath.close()
        arrowPath.fill()
        
        let myPath = arrowPath.cgPath
        
        myLoader = WavesLoader.showLoader(with: myPath)
        caller!.view.addSubview(myLoader!)
    }
    
    func removeLoader() {
        myLoader!.removeLoader()
        myLoader!.removeFromSuperview()
    }
    
    func showNoInternetAlert() {
        
        HelperClass.showOneOptionAlert(title: kNoInternetAlertTitle, message: kNoConnectionAlertMessage, okButtonTitle: kGenericOkAlertButtonTitle, presenter: caller!)
    }
}
