//
//  MenuController.swift
//  Advans
//
//  Created by alex on 24/10/18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

class MenuController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    let menus : [Menu] = [
        Menu(id : 0 , logoName : "call" , text : "Cargar Leads" , color : "g") ,
        Menu(id : 1 , logoName : "msm" , text : "Crear Campania de SMS" , color : "b") ,
        Menu(id : 2 , logoName : "globe" , text : "Medios de comunicacion social" , color : "bl") ,
        Menu(id : 3 , logoName : "people" , text : "Vcard y Perfil" , color : "p") ,
        Menu(id : 4 , logoName : "video" , text : "Tutoriales" , color : "y")
    ]
    var campaings = [Campaign]()
    
    private let imageTitleView : UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "title")
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = imageTitleView
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        navigationController?.navigationBar.barTintColor  = .white
        
        let image = UIImage(named: "menu")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image , style: .plain, target: self, action: #selector(hadleMenu))
        navigationItem.rightBarButtonItem?.tintColor = .black
                
        collectionView?.backgroundColor = .white
        collectionView?.register(MenuView.self , forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    @objc private func hadleMenu(){
        let campaignController = CampaignController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigateController = UINavigationController(rootViewController: campaignController)
        self.present(navigateController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MenuView
        let menu = menus[indexPath.item]
        cell.menu = menu
        cell.menuController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    @objc func hadleMenuSelected(_ button : UIButton){
        print("menu selecated" , button.tag)
        if (button.tag == 0) {
            let newCampaignController = NewCampaignController()
            let navigateController = UINavigationController(rootViewController: newCampaignController)
            self.present(navigateController, animated: true, completion: nil)
        }
        
        if (button.tag == 1) {
            let campaignSmsController = CampaignSmsController(collectionViewLayout: UICollectionViewFlowLayout())
            campaignSmsController.campaigns = self.campaings
            self.present(campaignSmsController, animated: true, completion: nil)
        }
    }
}
