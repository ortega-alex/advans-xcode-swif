//
//  ManualTracingController.swift
//  Advans
//
//  Created by alex on 31/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class ManualTracingController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var call = Call()
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let footerId = "footerId"
    private lazy var comtinueButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customize(color: .white, text: "Don't save and conyinue")
        btn.preservesSuperviewLayoutMargins = true
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(hadleContinue), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TracingView.self , forCellWithReuseIdentifier: cellId)
        collectionView.register(ManualTracingView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter , withReuseIdentifier: footerId)
        collectionView?.isPagingEnabled = true
        
        //fuerza el color det titulo
        navigationItem.title = call.name
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //line que divide el nav con el view
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationController?.navigationBar.tintColor = .black
        collectionView.backgroundColor = .white
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TracingView
        cell.backgroundColor = .white
        cell.call = self.call
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 447)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ManualTracingView
            header.backgroundColor = .white
            header.call = call
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            footer.backgroundColor = .white
            footer.addSubview(comtinueButton)
            NSLayoutConstraint.activate([
                comtinueButton.topAnchor.constraint(equalTo: footer.topAnchor),
                comtinueButton.leadingAnchor.constraint(equalTo: footer.leadingAnchor , constant : 10),
                comtinueButton.trailingAnchor.constraint(equalTo: footer.trailingAnchor , constant : -10) ,
                comtinueButton.heightAnchor.constraint(equalTo: footer.heightAnchor)
                ])
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 177)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 50)
    }
    
    @objc private func hadleContinue(){
        print("salir y continuar")
        let campaignController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigateController = UINavigationController(rootViewController: campaignController)
        self.present(navigateController, animated: true, completion: nil)
    }
}
