//
//  StorageHelper.swift
//  Prework
//
//  Created by Berk Burak Tasdemir on 2/2/21.
//
import UIKit

struct StorageHelper {
    static func setDefaultRate(rate: Double) {
        UserDefaults.standard.set(rate, forKey: "defaultRate")
    }
    
    static func getDefaultRate() -> Double {
        return UserDefaults.standard.double(forKey: "defaultRate")
    }
    
    static func setNightMode(nightMode: Bool) {
        UserDefaults.standard.set(nightMode, forKey: "nightMode")
    }
    
    static func getNightMode() -> Bool{
        return UserDefaults.standard.bool(forKey: "nightMode")
    }
}
