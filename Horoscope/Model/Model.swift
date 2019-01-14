//
//  Model.swift
//  Horoscope
//
//  Created by Ruslan Latfulin on 13.01.2019.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import Foundation
import UIKit

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

func isFirstStart() -> Bool{
    let defaults = UserDefaults.standard
    
    if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
        print("App already launched : \(isAppAlreadyLaunchedOnce)")
        return false
    }else{
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return true
    }
}

func getfileCreatedDate(theFile: String) -> Date {
    
    var theCreationDate = Date()
    do{
        let aFileAttributes = try FileManager.default.attributesOfItem(atPath: theFile) as [FileAttributeKey:Any]
        theCreationDate = aFileAttributes[FileAttributeKey.creationDate] as! Date
        
    } catch let theError as Error{
        print("file not found \(theError)")
    }
    return theCreationDate
}









class Model: NSObject, XMLParserDelegate {
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
    let zodiacSignTypeRus: [String] = ["Общий", "Здоровье", "Бизнес", "Любовный", "Эротический", ""]
    
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
    func loadXML(type: String){
        var forLoad:String = ""
        switch type {
        case "common":
            forLoad = "https://ignio.com/r/export/utf/xml/daily/com.xml"
        default:
            return
        }
        
        let urlForLoad = URL(string: forLoad)
        let filePath = getPathForXML(type: type)
        
        let fileDate = getfileCreatedDate(theFile: filePath)
        
        var errorGlobal: String?
        
        if ((isFirstStart()) || (abs(round(fileDate.timeIntervalSinceNow)) > 86400) ){
            let session = URLSession(configuration: .default)
            
            let task = session.downloadTask(with: urlForLoad!) { (urlFile, response, error) in
                if urlFile != nil {
                    do {
                        try FileManager.default.removeItem(at: URL(fileURLWithPath: filePath))
                    } catch let errorRemove as Error {
                        print("error when remove \(errorRemove)")
                        errorGlobal = errorRemove.localizedDescription
                    }
                    
                    do {
                        try FileManager.default.copyItem(at: urlFile!, to: URL(fileURLWithPath: filePath))
                    } catch let errorCopy as Error {
                        print("error when copy \(errorCopy)")
                        errorGlobal = errorCopy.localizedDescription
                    }
                    
                } else {
                    errorGlobal = error?.localizedDescription
                }
                if let errorGlobal = errorGlobal {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ErrorWhenXMLLoading"), object: self, userInfo: ["ErrorName": errorGlobal])
                }
            }
            
            task.resume()
            
        }
        
        parseXML(type: type)
    }
    
    //распарсить файл
    func parseXML(type: String) {
        ZodiacSigns = []
        let parser = XMLParser(contentsOf: URL(fileURLWithPath: getPathForXML(type: type)))
        parser?.delegate = self
        parser?.parse()
    }
    
    
    var currentZodiacSign: ZodiacSign?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        
        if elementName == "date"{
            if let currentDateString = attributeDict["today"]{
                todayDate = currentDateString
            }
        }
        
        if staticZodiacSigns.contains(elementName) {
            currentZodiacSign = ZodiacSign()
        }
    }

    
    var currentCharacters: String = ""
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        currentCharacters += string
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
     
        if elementName == "yesterday"{
            currentZodiacSign?.yesterday = currentCharacters
            currentCharacters = ""
        }
        
        if elementName == "today"{
            currentZodiacSign?.today = currentCharacters
            currentCharacters = ""
        }
        
        if elementName == "tomorrow" {
            currentZodiacSign?.tomorrow = currentCharacters
            currentCharacters = ""
        }
        
        if staticZodiacSigns.contains(elementName) {
            ZodiacSigns.append(currentZodiacSign!)
            currentCharacters = ""
        }
    }
    
}
