//
//  ViewController.swift
//  Horoscope
//
//  Created by Ruslan Latfulin on 13.01.2019.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //change user zodiac sign
    @IBAction func pushUserSignAction(_ sender: Any) {
//        navigationController?.title = "Choose your zodiac sign"
        let nc = storyboard?.instantiateViewController(withIdentifier: "UserSignSID") as! UINavigationController
        
        present(nc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ErrorWhenXMLLoading"), object: nil, queue: nil) { (notification) in
            let errorName = notification.userInfo?["errorName"]
            print(errorName)
            
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Что-то пошло не так!", message: "Возможны ошибки с интернет соединением.", preferredStyle: .alert)
                let alertButtonOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertController.addAction(alertButtonOK)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        if userSign == nil {
            let nc = storyboard?.instantiateViewController(withIdentifier: "UserSignSID") as! UINavigationController
            present(nc, animated: true, completion: nil)
        }
        print(userSign)
    }
}


extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.zodiacSignType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! CollectionViewCell
        
        cell.labelName.text = Model.shared.zodiacSignTypeRus[indexPath.row]
        
        return cell
    }
    
    
}

