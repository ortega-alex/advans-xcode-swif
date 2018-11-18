//
//  Extensions.swift
//  Advans
//
//  Created by alex on 16/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    static var mainGreen = UIColor(red: 6/255, green: 215/255, blue: 156/255, alpha: 1)
    static var mainBlack = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
    static var mainBlue = UIColor(red: 57/255, green: 139/255, blue: 247/255, alpha: 1)
    static var mainPurple = UIColor(red: 116/255, green: 90/255, blue: 242/255, alpha: 1)
    static var mainYellow = UIColor(red: 255/255, green: 178/255, blue: 43/255, alpha: 1)
    static var mainLightGray = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    
    /*convenience init (r : CGFloat , g : CGFloat , b : CGFloat){
     self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
     }*/
}

extension UIViewController {
    class func displaySpinner(onView : UIView , text : String? ) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        //spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai : UIActivityIndicatorView = {
            let a = UIActivityIndicatorView.init(style: .whiteLarge)
            a.startAnimating()
            a.translatesAutoresizingMaskIntoConstraints = false
            a.color = .black
            //a.center = spinnerView.center
            return a
        }()
        
        let titleLabel : UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "LOADING"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            spinnerView.addSubview(titleLabel)
            titleLabel.text = text
            
            NSLayoutConstraint.activate([
                ai.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor ) ,
                ai.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor, constant: -100)
                ])
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: ai.bottomAnchor , constant : 5 ) ,
                titleLabel.leadingAnchor.constraint(equalTo: spinnerView.leadingAnchor , constant: 10 ),
                titleLabel.trailingAnchor.constraint(equalTo: spinnerView.trailingAnchor , constant: -10) ,
                titleLabel.heightAnchor.constraint(equalToConstant: 16)
                ])
            
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension UIButton {
    
    func customize(color: UIColor , text : String) {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitle(text, for: .normal)
        backgroundColor = color
        layer.cornerRadius = 10
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = .white
        titleLabel?.textAlignment = .center
    }
    
    func customizeIco(icon : String ){
        setImage(UIImage(named: icon), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        tintColor = .black
    }
    
    func customizeColor(color: UIColor){
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        backgroundColor = color
        tintColor = color
        layer.cornerRadius = 10
        layer.masksToBounds = true
        preservesSuperviewLayoutMargins = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
        titleLabel?.textAlignment = .center
    }
}

extension UITextField {
    func customize(){
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 18)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        textAlignment = .center
        textColor = .black
        layer.borderColor = UIColor.mainLightGray.cgColor
        layer.borderWidth = 1
    }
}

extension UITextView {
    func customize(){
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 18)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        textAlignment = .center
        textColor = .black
        layer.borderColor = UIColor.mainLightGray.cgColor
        layer.borderWidth = 1
    }
}

extension UILabel {
    func customize(text : String ){
        self.text = text
        font = UIFont.boldSystemFont(ofSize: 16)
        textColor = .black
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func customizeSize(size : CGFloat ){
        font = UIFont.systemFont(ofSize: size)
        textColor = .white
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
