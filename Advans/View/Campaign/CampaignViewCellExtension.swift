//
//  CampaignViewCellExtension.swift
//  Advans
//
//  Created by alex on 17/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

extension CampaignViewCell : UICollectionViewDataSource , UICollectionViewDelegate  , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return call_states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CampaignStatusViewCell
        cell.campaignViewCell = self
        cell.campaignController = self.campaignController
        cell.backgroundColor = .white
        cell.call_state = call_states[indexPath.row]
        cell.statusButton.setTitle( String(describing: index ) , for: .normal)
        if (call_states[indexPath.row].selectd == nil || call_states[indexPath.row].selectd == false){
            cell.statusButton.layer.borderColor = UIColor.white.cgColor
        } else {
            cell.statusButton.layer.borderColor = UIColor.red.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(call_states.count)
        return CGSize(width: width , height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
