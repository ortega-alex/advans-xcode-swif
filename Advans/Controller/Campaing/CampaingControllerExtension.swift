//
//  CampaingControllerExtension.swift
//  Advans
//
//  Created by alex on 17/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

extension CampaignController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CampaignViewCell
        let campaign = campaigns[indexPath.row]
        cell.campaignController = self
        cell.campaign = campaign
        cell.index = indexPath.row
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 135)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let off = self.collectionView.contentOffset.y
        self.btnFoalt.frame = CGRect(x: ((self.collectionView.frame.size.width / 2) - 30) , y: off + (self.collectionView.frame.size.height - 80) , width: self.btnFoalt.frame.size.width , height: self.btnFoalt.frame.size.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
