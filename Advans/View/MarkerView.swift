//
//  MarkerView.swift
//  Advans
//
//  Created by alex on 29/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class MarkerView : UICollectionViewCell {
    
    var number : String? {
        didSet{
            guard let n = number else { return }
            numberButton.setTitle( n , for: .normal)
            if n == "/" {
                numberButton.isHidden = true
            }
        }
    }
    
    var markerController : MarkerController? {
        didSet{
            numberButton.addTarget(markerController, action: #selector(markerController?.hadleTouchNumber(_:)), for: .touchUpInside)
        }
    }
    
    private let numberButton : UIButton = {
        let btn = UIButton()
        btn.customize(color: .black, text: "")
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        addSubview(numberButton)
        NSLayoutConstraint.activate([
            numberButton.centerXAnchor.constraint(equalTo: centerXAnchor) ,
            numberButton.centerYAnchor.constraint(equalTo: centerYAnchor) ,
            numberButton.widthAnchor.constraint(equalTo: widthAnchor , constant : -10) ,
            numberButton.heightAnchor.constraint(equalTo: heightAnchor , constant : -5)
        ])
    }
}
