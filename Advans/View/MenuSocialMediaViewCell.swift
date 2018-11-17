//
//  MenuSocialMediaView.swift
//  Advans
//
//  Created by alex on 14/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class MenuSocialMediaViewCell : UICollectionViewCell {
    
    var btns = [SocialMenu]()
    private let collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    private let cellId = "cell"
    var socialMediaController : SocialMediaController?
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        setupLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ButtonMenuSocialViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant : 7),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant : -7),
        ])
    }
    
    @objc func handleMenu(_ button: UIButton){
        for row in btns.indices {
            if (row == button.tag) {
                btns[row].selected = true
            } else {
                btns[row].selected = false
            }
        }
        socialMediaController?.handleMenu(index: button.tag)
        let sections = IndexSet.init(integer: 0)
        collectionView.reloadSections(sections)
    }
}

extension MenuSocialMediaViewCell : UICollectionViewDataSource , UICollectionViewDelegate  , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return btns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId , for: indexPath) as! ButtonMenuSocialViewCell
        cell.button.setImage(UIImage(named: btns[indexPath.row].icono), for: .normal)
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(handleMenu(_:)), for: .touchUpInside)
        
        if btns[indexPath.row].selected == true {
            cell.button.backgroundColor = .mainPurple
            cell.button.tintColor = .white
        } else {
            cell.button.backgroundColor = .white
            cell.button.tintColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(btns.count)
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
