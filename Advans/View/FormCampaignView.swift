//
//  FormCampaigView.swift
//  Advans
//
//  Created by alex on 26/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import DownPicker
import UITextView_Placeholder

class FormCampaignView : UIView {
    
    private var phoneDownPicker: DownPicker!
    private var nameDownPicker: DownPicker!
    private var noteDownPicker: DownPicker!
    private var option1DownPicker: DownPicker!
    private var option2DownPicker: DownPicker!
    private var option3DownPicker: DownPicker!
    private var option4DownPicker: DownPicker!
    var call = Call()
    
    var archive : Archive? {
        didSet {
            guard let arch = archive else { return }
            nameCampaignTextField.text = arch.name
            let heder : NSMutableArray = []
            for h in arch.headers {
                heder.add(h.text)
            }
            self.nameDownPicker = DownPicker(textField: self.nameTextField, withData: heder as? [Any])
            self.nameDownPicker.setPlaceholder("Selected name")
            self.nameDownPicker.tag = 0
            self.nameDownPicker.addTarget(self, action: #selector(hadleOnChange(_:)), for: UIControl.Event.valueChanged)
            
            self.phoneDownPicker = DownPicker(textField: self.phoneTextField, withData: heder as? [Any])
            self.phoneDownPicker.setPlaceholder("Selected phone")
            self.phoneDownPicker.tag = 1
            self.phoneDownPicker.addTarget(self, action: #selector(hadleOnChange(_:)), for: UIControl.Event.valueChanged)
            
            self.noteDownPicker = DownPicker(textField: self.noteTextField, withData: heder as? [Any])
            self.noteDownPicker.setPlaceholder("Selected nota")
            self.noteDownPicker.tag = 2
            self.noteDownPicker.addTarget(self, action: #selector(hadleOnChange(_:)), for: UIControl.Event.valueChanged)
            
            self.option1DownPicker = DownPicker(textField: self.option1TextField, withData: heder as? [Any])
            self.option1DownPicker.setPlaceholder("Optional")
            self.option1DownPicker.tag = 3
            self.option1DownPicker.addTarget(self, action: #selector(hadleOnChange(_:)), for: UIControl.Event.valueChanged)
            
            self.option2DownPicker = DownPicker(textField: self.option2TextField, withData: heder as? [Any])
            self.option2DownPicker.setPlaceholder("Optional")
            self.option2DownPicker.tag = 4
            self.option2DownPicker.addTarget(self, action: #selector(hadleOnChange(_:)), for: UIControl.Event.valueChanged)
            
            self.option3DownPicker = DownPicker(textField: self.option3TextField, withData: heder as? [Any])
            self.option3DownPicker.setPlaceholder("Optional")
            self.option3DownPicker.tag = 5
            self.option3DownPicker.addTarget(self, action: #selector(hadleOnChange(_:)), for: UIControl.Event.valueChanged)
            
            self.option4DownPicker = DownPicker(textField: self.option4TextField, withData: heder as? [Any])
            self.option4DownPicker.setPlaceholder("Optional")
            self.option4DownPicker.tag = 6
            self.option4DownPicker.addTarget(self, action: #selector(hadleOnChange(_:)), for: UIControl.Event.valueChanged)
        }
    }
    
    var formCampaignController : FormCampaignController? {
        didSet {
            btnSaveButton.addTarget(formCampaignController, action: #selector(formCampaignController?.hadleSave), for: .touchUpInside)
        }
    }
    
    private let nameCampaignLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Campaign Name:")
        return lb
    }()
    
    private let nameCampaignTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let nameLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Nombre:")
        return lb
    }()
    
    private let nameTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let phoneLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Phone:")
        return lb
    }()
    
    private let phoneTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let noteLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Note:")
        return lb
    }()
    
    private let noteTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let field1Label : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Name:")
        return lb
    }()
    
    private let field1TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private let option1TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let field2Label : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Name:")
        return lb
    }()
    
    private let field2TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private let option2TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let field3Label : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Name:")
        return lb
    }()
    
    private let field3TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private let option3TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let field4Label : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Name:")
        return lb
    }()
    
    private let field4TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private let option4TextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    private let smsUISwitch : UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = .mainGreen
        sw.addTarget(self, action: #selector(hadleSmsSwitch(_:)), for: UIControl.Event.valueChanged)
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    private let textareaLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text:  "SMS:")
        return lb
    }()
    
    private let textareaTextView : UITextView = {
        let tv = UITextView()
        tv.customize()
        tv.placeholderColor = .lightGray
        tv.placeholder = "Edit this text message and it will be sent to each lead 'No Answer' after you called. Write *name* where you want each of the customers name on the text"
        return tv
    }()
    
    private let btnSaveButton : UIButton = {
        let btn = UIButton()
        btn.customize(color: .black, text: "SAVE")
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        
        addSubview(nameCampaignLabel)
        NSLayoutConstraint.activate([
            nameCampaignLabel.topAnchor.constraint(equalTo: topAnchor),
            nameCampaignLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            nameCampaignLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            nameCampaignLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(nameCampaignTextField)
        NSLayoutConstraint.activate([
            nameCampaignTextField.topAnchor.constraint(equalTo: nameCampaignLabel.bottomAnchor , constant : 1),
            nameCampaignTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            nameCampaignTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            nameCampaignTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameCampaignTextField.bottomAnchor , constant : 3),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            nameLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(phoneLabel)
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor , constant : 3),
            phoneLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            phoneLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            phoneLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(phoneTextField)
        NSLayoutConstraint.activate([
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 1),
            phoneTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            phoneTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            phoneTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(noteLabel)
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor , constant : 3),
            noteLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            noteLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            noteLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(noteTextField)
        NSLayoutConstraint.activate([
            noteTextField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 1),
            noteTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            noteTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            noteTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(field1Label)
        NSLayoutConstraint.activate([
            field1Label.topAnchor.constraint(equalTo: noteTextField.bottomAnchor , constant : 3),
            field1Label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field1Label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            field1Label.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(field1TextField)
        NSLayoutConstraint.activate([
            field1TextField.topAnchor.constraint(equalTo: field1Label.bottomAnchor, constant: 1),
            field1TextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field1TextField.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2) ,
            field1TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(option1TextField)
        NSLayoutConstraint.activate([
            option1TextField.topAnchor.constraint(equalTo: field1Label.bottomAnchor, constant: 1),
            option1TextField.leadingAnchor.constraint(equalTo: centerXAnchor , constant : 2),
            option1TextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            option1TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(field2Label)
        NSLayoutConstraint.activate([
            field2Label.topAnchor.constraint(equalTo: option1TextField.bottomAnchor , constant : 3),
            field2Label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field2Label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            field2Label.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(field2TextField)
        NSLayoutConstraint.activate([
            field2TextField.topAnchor.constraint(equalTo: field2Label.bottomAnchor, constant: 1),
            field2TextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field2TextField.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2) ,
            field2TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(option2TextField)
        NSLayoutConstraint.activate([
            option2TextField.topAnchor.constraint(equalTo: field2Label.bottomAnchor, constant: 1),
            option2TextField.leadingAnchor.constraint(equalTo: centerXAnchor , constant : 2),
            option2TextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            option2TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(field3Label)
        NSLayoutConstraint.activate([
            field3Label.topAnchor.constraint(equalTo: option2TextField.bottomAnchor , constant : 3),
            field3Label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field3Label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            field3Label.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(field3TextField)
        NSLayoutConstraint.activate([
            field3TextField.topAnchor.constraint(equalTo: field3Label.bottomAnchor, constant: 1),
            field3TextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field3TextField.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2) ,
            field3TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(option3TextField)
        NSLayoutConstraint.activate([
            option3TextField.topAnchor.constraint(equalTo: field3Label.bottomAnchor, constant: 1),
            option3TextField.leadingAnchor.constraint(equalTo: centerXAnchor , constant : 2),
            option3TextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            option3TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(field4Label)
        NSLayoutConstraint.activate([
            field4Label.topAnchor.constraint(equalTo: option3TextField.bottomAnchor , constant : 3),
            field4Label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field4Label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            field4Label.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(field4TextField)
        NSLayoutConstraint.activate([
            field4TextField.topAnchor.constraint(equalTo: field4Label.bottomAnchor, constant: 1),
            field4TextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            field4TextField.trailingAnchor.constraint(equalTo: centerXAnchor , constant : -2) ,
            field4TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(option4TextField)
        NSLayoutConstraint.activate([
            option4TextField.topAnchor.constraint(equalTo: field4Label.bottomAnchor, constant: 1),
            option4TextField.leadingAnchor.constraint(equalTo: centerXAnchor , constant : 2),
            option4TextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            option4TextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(smsUISwitch)
        NSLayoutConstraint.activate([
            smsUISwitch.topAnchor.constraint(equalTo: option4TextField.bottomAnchor, constant: 5) ,
            smsUISwitch.centerXAnchor.constraint(equalTo: centerXAnchor , constant : 25) ,
            smsUISwitch.widthAnchor.constraint(equalToConstant: 100) ,
            smsUISwitch.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        addSubview(textareaLabel)
        NSLayoutConstraint.activate([
            textareaLabel.topAnchor.constraint(equalTo: smsUISwitch.bottomAnchor),
            textareaLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            textareaLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            textareaLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
        
        addSubview(textareaTextView)
        NSLayoutConstraint.activate([
            textareaTextView.topAnchor.constraint(equalTo: textareaLabel.bottomAnchor, constant: 1),
            textareaTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            textareaTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            textareaTextView.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        addSubview(btnSaveButton)
        NSLayoutConstraint.activate([
            btnSaveButton.topAnchor.constraint(equalTo: textareaTextView.bottomAnchor, constant: 5),
            btnSaveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor , constant : 10),
            btnSaveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor , constant : -10) ,
            btnSaveButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    @objc func hadleOnChange(_ textField: UITextField){
        print("text" , textField.text as Any , textField.tag)
        if (textField.tag == 0) {
            call.name = textField.text!
        }
        if (textField.tag == 1) {
            call.phone = textField.text!
        }
        if (textField.tag == 2) {
            //call.notes = textField.text!
            call.notes?.append(textField.text!)
        }
        
        if (textField.tag == 3) {
            field1TextField.isUserInteractionEnabled = true
            field1TextField.text = textField.text!
            call.field1 = textField.text!
        }
        
        if (textField.tag == 4) {
            field2TextField.isUserInteractionEnabled = true
            field2TextField.text = textField.text!
            call.field2 = textField.text!
        }
        
        if (textField.tag == 5) {
            field3TextField.isUserInteractionEnabled = true
            field3TextField.text = textField.text!
            call.field3 = textField.text!
        }
        
        if (textField.tag == 6) {
            field4TextField.isUserInteractionEnabled = true
            field4TextField.text = textField.text!
            call.field4 = textField.text!
        }
    }
    
    @objc private func hadleSmsSwitch(_ smsSwitch: UISwitch){
        print("switch" , smsSwitch.isOn)
        //call.sms = (smsSwitch == true) ? "Y" : "N"
        call.sms = smsSwitch.isOn
    }
}
