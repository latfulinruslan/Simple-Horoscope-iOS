//
//  Model.swift
//  Horoscope
//
//  Created by Ruslan Latfulin on 13.01.2019.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import Foundation

class ZodiacSign{
    var yesterday: String?
    var today: String?
    var tomorrow: String?
}

var userSign: String? {
    set {
        UserDefaults.standard.set(newValue, forKey: "UserSign")
        UserDefaults.standard.synchronize()
    }
    get {
       return UserDefaults.standard.object(forKey: "UserSign") as? String
    }
}
class Model {
    static let shared = Model()
    
    var ZodiacSigns: [ZodiacSign] = []
    
    var yesterdayDate: String?
    var todayDate: String?
    var tomorrowDate: String?
    // Aries, Taurus, Gemini, Cancer, Leo, Virgo, Libra, Scorpio, Sagittarius, Capricorn, Aquarius and Pisces.
    let staticZodiacSigns: [String] = ["aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces"]
    
    // Овен , Телец , Близнецы , Рак , Лев , Дева , Весы , Скорпион , Стрелец , Козерог , Водолей и Рыбы .
    let staticZodiacSignsRus: [String] = ["Овен", "Телец", "Близнецы", "Рак", "Лев", "Дева", "Весы", "Скорпион", "Стрелец", "Козерог", "Водолей", "Рыбы"]
    
    let zodiacSignType: [String] = ["common"]
    let zodiacSignTypeRus: [String] = ["Общий"]
    
    //получение пути к файлу
    func getPathForXML(type: String) -> String {
        var path: String = ""
        switch type {
        case "common":
            path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/common.xml"
        default:
            return ""
        }
        print(path)
        if FileManager.default.fileExists(atPath: path) {
            return path
        } else {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }
        return path
    }
    
    //загрузить файл
    
    //распарсить файл
    
}
