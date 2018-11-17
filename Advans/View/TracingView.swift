//
//  TracingView.swift
//  Advans
//
//  Created by alex on 30/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class TracingView : UICollectionViewCell {
    
    var call : Call? {
        didSet{
            guard let c = call else { return }
            smsUISwitch.isOn = c.sms!
            callButton.setTitle(c.phone, for: .normal)
        }
    }
    
    private let notaLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text : "Nota:" )
        return lb
    }()
    
    private let notaTextView : UITextView = {
        let tv = UITextView()
        tv.customize()
        return tv
    }()
    
    private let ayudaButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon : "ayuda")
        return btn
    }()
    
    private let smsLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text : "SMS:" )
        return lb
    }()
    
    private let smsUISwitch : UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = .mainGreen
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    private let verificacionButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.customizeIco(icon : "verificacion")
        return btn
    }()
    
    private let smsTextView : UITextView = {
        let tv = UITextView()
        tv.customize()
        tv.placeholder = "Edit this text message and it will be sent to each lead 'No Answer' after you called. Write *name* where you want each of the customers name on the text"
        tv.placeholderColor = .lightGray
        return tv
    }()
    
    private let dateLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text : "Reminder:" )
        return lb
    }()
    
    lazy var textDatePicker : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    let datePicker = UIDatePicker()
    
    private let status0Button : UIButton = {
        let btn = UIButton()
        btn.customize(color: .black , text: "Do no call")
        return btn
    }()
    
    private let status1Button : UIButton = {
        let btn = UIButton()
        btn.customize(color: .mainBlue , text: "Sold")
        return btn
    }()
    
    private let status2Button : UIButton = {
        let btn = UIButton()
        btn.customize(color: .mainPurple , text: "No answer")
        return btn
    }()
    
    private let status3Button : UIButton = {
        let btn = UIButton()
        btn.customize(color: .mainYellow , text: "Call later")
        return btn
    }()
    
    private let callButton : UIButton = {
        let btn = UIButton()
        btn.customize(color: .mainGreen , text: "22222")
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        setupLayout()
        showDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        addSubview(notaLabel)
        NSLayoutConstraint.activate([
            notaLabel.topAnchor.constraint(equalTo: topAnchor),
            notaLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            notaLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            notaLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(notaTextView)
        NSLayoutConstraint.activate([
            notaTextView.topAnchor.constraint(equalTo: notaLabel.bottomAnchor , constant : 1),
            notaTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            notaTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            notaTextView.heightAnchor.constraint(equalToConstant: 80)
            ])
        
        let view = UIView()
        view.addSubview(smsUISwitch)
        
        NSLayoutConstraint.activate([
            smsUISwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smsUISwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        let bottonControlsStackView = UIStackView(arrangedSubviews: [ayudaButton , smsLabel , view , verificacionButton])
        bottonControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottonControlsStackView.distribution = .fillEqually
        
        addSubview(bottonControlsStackView)
        NSLayoutConstraint.activate([
            bottonControlsStackView.topAnchor.constraint(equalTo: notaTextView.bottomAnchor , constant : 5),
            bottonControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            bottonControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            bottonControlsStackView.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(smsTextView)
        NSLayoutConstraint.activate([
            smsTextView.topAnchor.constraint(equalTo: bottonControlsStackView.bottomAnchor , constant : 5),
            smsTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            smsTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            smsTextView.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: smsTextView.bottomAnchor , constant : 1),
            dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            dateLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(textDatePicker)
        NSLayoutConstraint.activate([
            textDatePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor , constant : 1),
            textDatePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            textDatePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            textDatePicker.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(status0Button)
        NSLayoutConstraint.activate([
            status0Button.topAnchor.constraint(equalTo: textDatePicker.bottomAnchor , constant : 1),
            status0Button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            status0Button.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2) ,
            status0Button.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(status1Button)
        NSLayoutConstraint.activate([
            status1Button.topAnchor.constraint(equalTo: textDatePicker.bottomAnchor , constant : 1),
            status1Button.leadingAnchor.constraint(equalTo: status0Button.trailingAnchor , constant : 2),
            status1Button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            status1Button.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(status2Button)
        NSLayoutConstraint.activate([
            status2Button.topAnchor.constraint(equalTo: status1Button.bottomAnchor , constant : 1),
            status2Button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            status2Button.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2) ,
            status2Button.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(status3Button)
        NSLayoutConstraint.activate([
            status3Button.topAnchor.constraint(equalTo: status1Button.bottomAnchor , constant : 1),
            status3Button.leadingAnchor.constraint(equalTo: status2Button.trailingAnchor , constant : 2),
            status3Button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            status3Button.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(callButton)
        NSLayoutConstraint.activate([
            callButton.topAnchor.constraint(equalTo: status3Button.bottomAnchor , constant : 5),
            callButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            callButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            callButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        textDatePicker.inputAccessoryView = toolbar
        textDatePicker.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textDatePicker.text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        endEditing(true)
    }
}

