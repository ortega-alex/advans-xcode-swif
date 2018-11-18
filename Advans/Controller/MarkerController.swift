//
//  MarkerController.swift
//  Advans
//
//  Created by alex on 29/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class MarkerController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var call = Call()
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let footerId = "footerId"
    var numbers = ["1","2","3","4","5","6","7","8","9","*","0","#","/","+","/"]
    var name : String?
    
    private let numberLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 40)
        lb.textColor = .black
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let saveButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .black
        btn.setTitle("SAVE", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white , for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(hadleSavebutton), for: .touchUpInside)
        return btn
    }()
    
    private let deleteButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(named:"back1"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(hadleClearTextLabel), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MarkerView.self , forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter , withReuseIdentifier: footerId)
        collectionView?.isPagingEnabled = true
        
        //line que divide el nav con el view
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        navigationItem.leftBarButtonItem?.tintColor = .black
        print(call.name as Any)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MarkerView
        cell.backgroundColor = .white
        cell.number = numbers[indexPath.item]
        cell.markerController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) , height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
            header.backgroundColor = .white
            header.addSubview(numberLabel)
            //x y w h
            NSLayoutConstraint.activate([
                numberLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor) ,
                numberLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 10),
                numberLabel.widthAnchor.constraint(equalTo: header.widthAnchor, constant: -75),
                numberLabel.heightAnchor.constraint(equalToConstant: 50)
                ])
            
            header.addSubview(deleteButton)
            //x y w h
            NSLayoutConstraint.activate([
                deleteButton.bottomAnchor.constraint(equalTo: header.bottomAnchor) ,
                deleteButton.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -20),
                deleteButton.widthAnchor.constraint(equalToConstant: 40),
                deleteButton.heightAnchor.constraint(equalToConstant: 50)
                ])
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            footer.backgroundColor = .white
            footer.addSubview(saveButton)
            //x y w h
            NSLayoutConstraint.activate([
                saveButton.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
                saveButton.bottomAnchor.constraint(equalTo: footer.bottomAnchor) ,
                saveButton.widthAnchor.constraint(equalTo: footer.widthAnchor, constant: -10),
                saveButton.heightAnchor.constraint(equalToConstant: 50)
                ])
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 60)
    }
    
    @objc func hadleTouchNumber(_ button: UIButton){
        print("touch" , button.titleLabel!.text as Any)
        if (numberLabel.text == nil) {
            numberLabel.text = (button.titleLabel?.text)!
        } else {
            let text = numberLabel.text
            let title : String = (button.titleLabel?.text)!
            numberLabel.text = text! + title
        }
    }
    
    @objc func hadleClearTextLabel(){
        numberLabel.text = nil
    }
    
    @objc func hadleSavebutton(){
        print(numberLabel.text as Any)
        self.call.phone = numberLabel.text
        let manualTracingController = ManualTracingController(collectionViewLayout: UICollectionViewFlowLayout())
        self.call.sms = (call.sms != nil) ? call.sms : false
        print(call)
        manualTracingController.call = self.call
        let navigareController = UINavigationController(rootViewController: manualTracingController)
        self.present(navigareController, animated: true, completion: nil)
    }
}
