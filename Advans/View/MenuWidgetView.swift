//
//  MenuWidgetView.swift
//  Advans
//
//  Created by alex on 15/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class MenuWidgetView : UIView {
    
    var socialMediaController : SocialMediaController? {
        didSet {
            guard let social = socialMediaController else { return }
            backButton.addTarget(social, action: #selector(social.handleBack), for: .touchUpInside)
            nextButton.addTarget(social, action: #selector(social.handleNext), for: .touchUpInside)
        }
    }
    
    private let backButton : UIButton = {
        let btn = UIButton(type: .system)
        //btn.customizeIco(icon: "back")
        btn.customize(color: .white , text: "back")
        btn.tintColor = .black
        return btn
    }()
    
    private let nextButton : UIButton = {
        let btn = UIButton(type: .system)
        //btn.customizeIco(icon: "next")
        btn.customize(color: .white , text: "next")
        btn.tintColor = .black
        return btn
    }()
    
    lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        //pc.numberOfPages = btns.count
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .mainPink
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        let bottonControlsStackView = UIStackView(arrangedSubviews: [backButton , pageControl , nextButton])
        bottonControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottonControlsStackView.distribution = .fillProportionally
        
        addSubview(bottonControlsStackView)
        NSLayoutConstraint.activate([
            bottonControlsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottonControlsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bottonControlsStackView.widthAnchor.constraint(equalTo: widthAnchor),
            bottonControlsStackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
