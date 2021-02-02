//
//  SettingsViewController.swift
//  Prework
//
//  Created by Berk Burak Tasdemir on 2/2/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var nightModeSwitch: UISwitch!
    
    private var nightMode: Bool = false {
        didSet {
            overrideUserInterfaceStyle = self.nightMode ? .dark : .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        nightMode = StorageHelper.getNightMode()
        
        nightModeSwitch.isOn = nightMode
        
        nightModeSwitch.addTarget(self, action: #selector(SettingsViewController.switchTapped(_:)), for: .valueChanged)
        
        rateTextField.keyboardType = .decimalPad
        rateTextField.clearButtonMode = .whileEditing
        rateTextField.text = String(format: "%.2f", StorageHelper.getDefaultRate() * 100)
        
        nightModeSwitch.onTintColor = .systemBlue
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let defaultRate = Double(self.rateTextField.text ?? "0") {
            StorageHelper.setDefaultRate(rate: (defaultRate / 100))
        }
        
        StorageHelper.setNightMode(nightMode: self.nightMode)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func switchTapped(_ nightSwitch: UISwitch) {
        self.nightMode = nightSwitch.isOn
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
