//
//  ViewController.swift
//  Prework
//
//  Created by Berk Burak Tasdemir on 2/2/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateSlider: UISlider!
    private var billAmount: Double = 0 {
        didSet {
            calculateTip()
        }
    }
    
    private var rate: Double = 0 {
        didSet {
            rateLabel.text = String(format: "%.2f", self.rate * 100) + "%"
            calculateTip()
        }
    }
    
    private let controlRateArray: [Double] = [0.15, 0.18, 0.2]
    
    var defaultRate: Double? {
        didSet {
            self.rate = defaultRate ?? 0.15
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tip Calculator"
        
        self.billAmount = StorageHelper.getBillAmount()
        
        billAmountTextField.keyboardType = .decimalPad
        billAmountTextField.clearButtonMode = .whileEditing
        billAmountTextField.text = String(format: "%.2f", self.billAmount)
        
        billAmountTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        rateSlider.addTarget(self, action: #selector(ViewController.sliderDidChange(_:)), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        defaultRate = StorageHelper.getDefaultRate()
        self.rateSlider.value = Float(self.rate)
        
        billAmountTextField.becomeFirstResponder()
        
        overrideUserInterfaceStyle = StorageHelper.getNightMode() ? .dark : .light
    }
    
    private func calculateTip() {
        let tip = self.billAmount * self.rate
        let total = self.billAmount + tip
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @objc func sliderDidChange(_ slider: UISlider) {
        self.rate = Double(slider.value)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let billAmount = textField.text {
            self.billAmount = Double(billAmount) ?? 0
            StorageHelper.setBillAmount(billAmount: self.billAmount)
        }
    }

    @IBAction func controlPressed(_ sender: Any) {
        self.rate = controlRateArray[tipControl.selectedSegmentIndex]
        UIView.animate(withDuration: 0.3, animations: {
            self.rateSlider.setValue(Float(self.rate), animated:true)
        })
    }
}

