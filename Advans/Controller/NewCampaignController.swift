//
//  NewCampaignController.swift
//  Advans
//
//  Created by alex on 25/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class NewCampaignController : UIViewController , UIDocumentPickerDelegate  {
    
    private var call = Call()
    lazy var newCampaignView : NewCampaignView = {
        let view = NewCampaignView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.newCampaignController = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        
        let image = UIImage(named: "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain , target: self, action: #selector(hadleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        view.backgroundColor = .white
        view.addSubview(newCampaignView)
    }
    
    @objc private func hadleCancel(){
        let campaignController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigateController = UINavigationController(rootViewController: campaignController)
        self.present(navigateController, animated: true, completion: nil)
    }
    
    @objc func hadleArchive() {
        print("archivo")
        let documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.text"], in: UIDocumentPickerMode.import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            // This is what it should be
            print(urls)
        }
    }
    
    @objc func hadleCreate(){
        print("create name: " , self.newCampaignView.nameTextField.text as Any)
        let markerController = MarkerController(collectionViewLayout: UICollectionViewFlowLayout())
        self.call.name = self.newCampaignView.nameTextField.text
        markerController.call = self.call
        navigationController?.pushViewController(markerController, animated: true)
    }
    
    @objc func hadleInserArchive(){
        let formCampaignController = FormCampaignController()
        navigationController?.pushViewController(formCampaignController, animated: true)
    }
}
