//
//  NewCampaignSmsView.swift
//  Advans
//
//  Created by alex on 6/11/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class NewCampaignSmsView: UICollectionViewCell , UITextViewDelegate {
    
    var newCampaignSmsController : NewCampaignSmsController? {
        didSet{
            guard let smsController = newCampaignSmsController else { return }
            nameTextField.addTarget(smsController, action: #selector(smsController.textFieldChange(_:)), for: UIControl.Event.editingChanged)
            linkTextField.addTarget(smsController, action: #selector(smsController.textFieldChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    
    private let nameLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Name:")
        return lb
    }()
    
    private let nameTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.tag = 0
        return tf
    }()
    
    private let smsLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "SMS:")
        return lb
    }()
    
    private let smsTextView : UITextView = {
        let tv = UITextView()
        tv.customize()
        tv.placeholder = "Edit this text message and it will be sent to each lead 'No Answer' after you called. Write *name* where you want each of the customers name on the text"
        tv.placeholderColor = .lightGray
        return tv
    }()
    
    private let linkLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Link:")
        return lb
    }()
    
    private let linkTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        tf.tag = 1
        return tf
    }()
    
    private let timeLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Shipping schedule:")
        return lb
    }()
    
    private let timeTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    let timePicker = UIDatePicker()
    
    private let dateLabel : UILabel = {
        let lb = UILabel()
        lb.customize(text: "Stard Date:")
        return lb
    }()
    
    private let dateTextField : UITextField = {
        let tf = UITextField()
        tf.customize()
        return tf
    }()
    
    let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        setupLayout()
        showDatePicker()
        smsTextView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout(){
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(smsLabel)
        addSubview(smsTextView)
        addSubview(linkLabel)
        addSubview(linkTextField)
        addSubview(timeLabel)
        addSubview(timeTextField)
        addSubview(dateLabel)
        addSubview(dateTextField)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor) ,
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            smsLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 1),
            smsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            smsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            smsLabel.heightAnchor.constraint(equalToConstant: 16),
            smsTextView.topAnchor.constraint(equalTo: smsLabel.bottomAnchor, constant: 1),
            smsTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            smsTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            smsTextView.heightAnchor.constraint(equalToConstant: 100),
            linkLabel.topAnchor.constraint(equalTo: smsTextView.bottomAnchor, constant: 1) ,
            linkLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            linkLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            linkLabel.heightAnchor.constraint(equalToConstant: 16),
            linkTextField.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 1),
            linkTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            linkTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            linkTextField.heightAnchor.constraint(equalToConstant: 40),
            timeLabel.topAnchor.constraint(equalTo: linkTextField.bottomAnchor, constant: 1) ,
            timeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            timeLabel.heightAnchor.constraint(equalToConstant: 16),
            timeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 1),
            timeTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            timeTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            timeTextField.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 1) ,
            dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 16),
            dateTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 1),
            dateTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            dateTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        timePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = timePicker
    }
    
    @objc func donedatePicker(){
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "HH:mm:ss"
        timeTextField.text = formatterTime.string(from: timePicker.date)
        
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatterDate.string(from: datePicker.date)
        
        self.newCampaignSmsController?.campaignSms.start_time = timeTextField.text
        self.newCampaignSmsController?.campaignSms.start_date = dateTextField.text
        
        cancelDatePicker()
    }
    
    @objc func cancelDatePicker(){
        endEditing(true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        self.newCampaignSmsController?.campaignSms.sms_text = textView.text
    }
}
