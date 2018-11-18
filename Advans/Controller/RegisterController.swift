//
//  RegisterController.swift
//  Advans
//
//  Created by alex on 8/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    private let global = Global()
    var containerViewBottomAnchor : NSLayoutConstraint?
    
    var registers = [
        Register( id : 0 , placeholder : "Languaje" , value : "Espanol"),
        Register( id : 1 , placeholder : "Name" , value : ""),
        Register( id : 2 , placeholder : "UserName" , value : ""),
        Register( id : 3 , placeholder : "Password" , value : "")
    ]
    
    private let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(hadlePev), for: .touchUpInside)
        return button
    }()
    
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(hadleNext), for: .touchUpInside)
        return button
    }()
    
    lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = registers.count
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .mainPink
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(RegisterView.self , forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        setupKeyboardObservers()
    }
    
    fileprivate func setupButtonControls(){
        pageControl.numberOfPages = registers.count
        let bottonControlsStackView = UIStackView(arrangedSubviews: [previousButton , pageControl , nextButton])
        bottonControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottonControlsStackView.distribution = .fillEqually
        //bottonControlsStackView.axis = .vertical
        view.addSubview(bottonControlsStackView)
        
        containerViewBottomAnchor = bottonControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        bottonControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottonControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottonControlsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func hadleNext(){
        //print("tryng to advance to next")
        let nextIndex = min(pageControl.currentPage + 1 , registers.count - 1)
        let indexPath = IndexPath(item : nextIndex , section : 0)
        if (nextIndex == 3){
            nextButton.setTitle("Save", for: .normal)
        }
        if (nextIndex >= 1){
            previousButton.setTitle("Pev", for: .normal)
        }
        if ((pageControl.currentPage + 1 ) == 4){
            self.hadleSave()
        }
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func hadlePev(){
        //print("tryng to advance to next")
        let pevIndex = max(pageControl.currentPage - 1 , 0)
        let indexPath = IndexPath(item : pevIndex , section : 0)
        if ( pevIndex == 0){
            previousButton.setTitle("Back", for: .normal)
        }
        if (pevIndex <= 2){
            nextButton.setTitle("Next", for: .normal)
        }
        if ((pageControl.currentPage - 1) == -1 ){
            self.hadleLogin()
        }
        pageControl.currentPage = pevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return registers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! RegisterView
        cell.registerController = self
        let register = registers[indexPath.item]
        cell.register = register
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        //print(x , view.frame.width , x / view.frame.width )
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        registers[pageControl.currentPage].value = textField.text ?? ""
    }
    
    @objc func hadleSave(){
        DispatchQueue.main.async{
            let url : String = self.global.URL + "user"
            let para : Parameters = [
                "nombre" :  self.registers[1].value ,
                "usuario" : self.registers[2].value  ,
                "password" : self.registers[3].value ,
                "idioma" : self.registers[0].value
            ]
            Alamofire.request(
                url ,
                method: .post  ,
                parameters: para ,
                encoding: JSONEncoding.default ,
                headers: self.global.HEADERS
                ).responseJSON(completionHandler: { (response) in
                    switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        print(json)
                        if ( json["status"].stringValue == "success" ) {
                            self.hadleLogin()
                        } else {
                            let myAlert = self.global.alert(title: "msj", message: json["msj"].stringValue ) as UIAlertController
                            self.present(myAlert, animated: true, completion: nil)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
        }
    }
    
    private func hadleLogin(){
        let loginController = LoginController()
        self.present(loginController, animated: true, completion: nil)
    }
    
    func setupKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(hadleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hadleKeyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hadleKeyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboarDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        containerViewBottomAnchor?.constant = -keyboardViewEndFrame.height
        UIView.animate(withDuration: keyboarDuration) {
            self.view.layoutIfNeeded()
        }
    }
}
