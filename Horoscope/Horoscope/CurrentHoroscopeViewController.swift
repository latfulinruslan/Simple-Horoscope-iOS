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
    var horoscopeIndex: Int?
    var currentDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) { (notification) in
            print("notification catch")
            if let tempInd = self.horoscopeIndex {
                self.horoscope = Model.shared.ZodiacSigns[tempInd].today
                self.userSign = Model.shared.staticZodiacSignsRus[tempInd]
            }
            
            
                if self.userSign != nil {
                    self.userZodiacSignLabel.text = self.userSign
                } else {
                    self.userZodiacSignLabel.text = "user"
                }
                if self.horoscope != nil {
                    self.horoscopeLabel.text = self.horoscope
                } else {
                    self.userZodiacSignLabel.text = "content"
                }
            
        }
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tempIndex = horoscopeIndex{

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            currentDate = dateFormatter.string(from: Date())
            
            if currentDate == Model.shared.todayDate {
                horoscope = Model.shared.ZodiacSigns[tempIndex].today
            }
            if currentDate == Model.shared.tomorrowDate {
                horoscope = Model.shared.ZodiacSigns[tempIndex].tomorrow
            }
            
            userSign = Model.shared.staticZodiacSignsRus[tempIndex]
            
            userZodiacSignLabel.text = userSign! + "\n \(currentDate!)"
            horoscopeLabel.text = horoscope
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
