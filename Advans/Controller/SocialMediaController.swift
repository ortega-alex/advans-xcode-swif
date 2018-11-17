//
//  SocialMediaController.swift
//  Advans
//
//  Created by alex on 14/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class SocialMediaController: UICollectionViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        collectionView.backgroundColor = .purple
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
}

extension SocialMediaController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 80)
    }
}
