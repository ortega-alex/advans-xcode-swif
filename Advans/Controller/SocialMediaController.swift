//
//  SocialMediaController.swift
//  Advans
//
//  Created by alex on 14/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class SocialMediaController: UICollectionViewController {
    
    var btns : [SocialMenu] = [
        SocialMenu(icono: "imagen", selected: false) ,
        SocialMenu(icono: "video", selected: false) ,
        SocialMenu(icono: "filled", selected: false) ,
        SocialMenu(icono: "camara", selected: false) ,
        SocialMenu(icono: "galeria", selected: false)
    ]
    private let cellId = "cellId"
    
    private lazy var menuCell : MenuSocialMediaViewCell = {
        let menu = MenuSocialMediaViewCell()
        menu.backgroundColor = .white
        menu.socialMediaController = self
        menu.btns = self.btns
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    private lazy var menuWidget : MenuWidgetView = {
        let vw = MenuWidgetView()
        vw.pageControl.numberOfPages = self.btns.count
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.socialMediaController = self
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.isPagingEnabled = true
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        let addImage = UIImage(named : "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(handleHome))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.title = "SOCIAL MEDIA"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //line que divide el nav con el view
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationController?.navigationBar.tintColor = .black
        
        collectionView.backgroundColor = .white
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        view.addSubview(menuCell)
        NSLayoutConstraint.activate([
            menuCell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuCell.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuCell.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuCell.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        view.addSubview(menuWidget)
        NSLayoutConstraint.activate([
            menuWidget.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuWidget.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuWidget.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuWidget.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleMenu(index: Int){
        print("controller" , index)
    }
    
    @objc fileprivate func handleHome(){
        print("home")
    }
    
    @objc func handleBack(){
        print("back")
    }
    
    @objc func handleNext(){
        print("next")
    }
}

extension SocialMediaController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return btns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: (view.frame.height - 250))
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        menuWidget.pageControl.currentPage = Int(x / view.frame.width)
    }
}
