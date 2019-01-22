//
//  UserSignViewController.swift
//  Horoscope
//
//  Created by Ruslan Latfulin on 13.01.2019.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class UserSignViewController: UIViewController {

    var selectedItem: Int = 0
    
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userSign == nil{
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.title = "Current sign: \(userSign!)"
        }

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userSign = Model.shared.staticZodiacSigns[indexPath.row]
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserSignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.staticZodiacSigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserSignCell", for: indexPath) as! CollectionViewCell
        
        cell.imageZodiacSign.image = UIImage(named: Model.shared.staticZodiacSigns[indexPath.row])
        cell.labelName.text = Model.shared.staticZodiacSignsRus[indexPath.row]
        return cell
    }
    
    
}
