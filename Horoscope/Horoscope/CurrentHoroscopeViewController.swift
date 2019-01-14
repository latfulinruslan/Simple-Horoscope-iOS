//
//  CurrentHoroscopeViewController.swift
//  Horoscope
//
//  Created by Ruslan Latfulin on 1/14/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class CurrentHoroscopeViewController: UIViewController {

    
    @IBOutlet weak var userZodiacSignLabel: UILabel!
    @IBOutlet weak var horoscopeLabel: UILabel!
    
    var userSign: String?
    var horoscope: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if userSign != nil {
            userZodiacSignLabel.text = userSign
        } else {
            userZodiacSignLabel.text = "lox"
        }
        if horoscope != nil {
            horoscopeLabel.text = horoscope
        } else {
            userZodiacSignLabel.text = "lox"
        }
        
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
