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
    
    static func setBillAmount(billAmount: Double) {
        UserDefaults.standard.set(billAmount, forKey: "billAmount")
        
        let timestamp = NSDate().timeIntervalSince1970 * 1000
        UserDefaults.standard.set(timestamp, forKey: "timestamp")
    }
    
    static func getBillAmount() -> Double {
        let timestamp = UserDefaults.standard.double(forKey: "timestamp")
        let currentTimestamp = NSDate().timeIntervalSince1970 * 1000
        let difference = (currentTimestamp - timestamp) / 3600
        if(difference > 600) {
            UserDefaults.standard.set(0, forKey: "billAmount")
        }
        
        return UserDefaults.standard.double(forKey: "billAmount")
    }
    
    
}
