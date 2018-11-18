//
//  TracingController.swift
//  Advans
//
//  Created by alex on 30/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class TracingController : UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    var call : Call?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TracingView.self , forCellWithReuseIdentifier: cellId)
        collectionView?.isPagingEnabled = true
        
        navigationItem.title = call?.name
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //line que divide el nav con el view
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationController?.navigationBar.tintColor = .black
        
        collectionView.backgroundColor = .purple
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TracingView
        cell.backgroundColor = .white
        cell.call = call
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 447)
    }
}
