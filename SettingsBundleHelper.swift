//
//  SettingsBundleHelper.swift
//  transinfoFinal
//
//  Created by Pedro Santiago on 6/18/18.
//  Copyright © 2018 Universidad de puerto rico-Mayaguez. All rights reserved.
//

import Foundation


class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let Reset = "RESET_APP_KEY"
        static let BuildVersionKey = "build_preference"
        static let AppVersionKey = "version_preference"
    }
    class func whatIsSet(){
          // let settings = NSUserDefaults.init()

        
        let url = NSUserDefaults.standardUserDefaults().valueForKey("name_preference")
        print("Here you go",url)
      
        let userDefaults = NSUserDefaults.standardUserDefaults()
        print(userDefaults.boolForKey("enabled_preference"))
        print(userDefaults.stringForKey("name_preference"))
        
        
    }
    
//    func setDefaultsFromSettingsBundle() {
//        //Read PreferenceSpecifiers from Root.plist in Settings.Bundle
//        if let settingsURL = Bundle.main.url(forResource: "Root", withExtension: "plist", subdirectory: "Settings.bundle"),
//            let settingsPlist = NSDictionary(contentsOf: settingsURL),
//            let preferences = settingsPlist["PreferenceSpecifiers"] as? [NSDictionary] {
//            
//            for prefSpecification in preferences {
//                
//                if let key = prefSpecification["Key"] as? String, let value = prefSpecification["DefaultValue"] {
//                    
//                    //If key doesn't exists in userDefaults then register it, else keep original value
//                    if UserDefaults.standard.value(forKey: key) == nil {
//                        
//                        UserDefaults.standard.set(value, forKey: key)
//                        NSLog("registerDefaultsFromSettingsBundle: Set following to UserDefaults - (key: \(key), value: \(value), type: \(type(of: value)))")
//                    }
//                }
//            }
//        } else {
//            NSLog("registerDefaultsFromSettingsBundle: Could not find Settings.bundle")
//        }
//    }
}