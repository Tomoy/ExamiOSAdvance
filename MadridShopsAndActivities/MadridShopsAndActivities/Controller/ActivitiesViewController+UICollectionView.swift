//
//  ActivitiesViewController+UICollectionView.swift
//  MadridShopsAndActivities
//
//  Created by Tomás Ignacio Moyano on 9/26/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import UIKit

extension ActivitiesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell.identifier, for: indexPath) as! ActivityCollectionViewCell
        
        let activityCD:ActivityCD = fetchedResultsController.object(at: indexPath)
        cell.updateInFo(model: activityCD)
        
        let activityAnnotation = ActivityAnnotation(activityCD: activityCD)
        mapView.addAnnotation(activityAnnotation)
        
        return cell
    }
}
