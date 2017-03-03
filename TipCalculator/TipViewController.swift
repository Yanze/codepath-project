//
//  ViewController.swift
//  TipCalculator
//
//  Created by yanze on 3/1/17.
//  Copyright © 2017 yanzeliu. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var checkAmountTextField: UITextField!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalToPayLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var tipPercentageControl: UISegmentedControl!
    @IBOutlet weak var numOfPeopleSlider: UISlider!
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPPerson: UILabel!
    
    @IBOutlet weak var settingButton: UIBarButtonItem!
    
    
    let tipPercentages = [0.1, 0.15, 0.2, 0.25]

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAmountTextField.becomeFirstResponder()
        loadData()
        animateTextfieldBgc()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.object(forKey: "isDarkTheme") as! Bool  ? setDarkTheme() : resetTheme()
    }
    
    func setDarkTheme() {
        view.backgroundColor = .darkGray
        checkAmountTextField.textColor = .white
        numOfPeopleLabel.textColor = .white
        tipAmountLabel.textColor = .white
        totalToPayLabel.textColor = .white
        totalPerPersonLabel.textColor = .white
        tipPercentageControl.backgroundColor = .clear
        tipPercentageControl.tintColor = .white
        
        imgView.image = imgView.image!.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = .white
        
        tipLabel.textColor = .white
        totalLabel.textColor = .white
        totalPPerson.textColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        settingButton.image = settingButton.image?.withRenderingMode(.alwaysTemplate)
        settingButton.tintColor = .white

    }
    
    func resetTheme() {
        view.backgroundColor = .white
        checkAmountTextField.textColor = .black
        numOfPeopleLabel.textColor = .black
        tipAmountLabel.textColor = .black
        totalToPayLabel.textColor = .black
        totalPerPersonLabel.textColor = .black
        tipPercentageControl.backgroundColor = .clear
        tipPercentageControl.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        
        imgView.image = imgView.image!.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = .black
        
        tipLabel.textColor = .black
        totalLabel.textColor = .black
        totalPPerson.textColor = .black
        
        navigationController?.navigationBar.barTintColor = .white
//        UINavigationBar.appearance().tintColor = .darkGray
        settingButton.image = settingButton.image?.withRenderingMode(.alwaysTemplate)
        settingButton.tintColor = .darkGray
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        
        guard let amount = defaults.object(forKey: "checkAmount") else {
            return
        }
        
        guard let tipPercentage = defaults.object(forKey: "tipPercentageIndex") else {
            return
        }
        
        guard let numPeople = defaults.object(forKey: "numberOfPeople") else {
            return
        }
        guard let saveddAt = defaults.object(forKey: "savedAt") else {
            return
        }
        
        let currentTime = Int(NSDate().timeIntervalSince1970)
        let willDiscardinMins = 10
        if ((currentTime - Int(saveddAt as! Double))/60) > willDiscardinMins {
            checkAmountTextField.text = ""
            numOfPeopleLabel.text = "1"
            tipPercentageControl.selectedSegmentIndex = 0
            numOfPeopleSlider.setValue(1.0, animated: true)
            removedDataFromUserDefaults()
        }
        else {
            checkAmountTextField.text = String(describing: amount)
            numOfPeopleLabel.text = String(describing: numPeople)
            tipPercentageControl.selectedSegmentIndex = tipPercentage as! Int
            numOfPeopleSlider.setValue(Float(numPeople as! Int), animated: true)
            
            let tips = (amount as! Double) * tipPercentages[(tipPercentage as! Int)]
            tipAmountLabel.text = String(format: "$%.2f", tips)
            
            let total = (amount as! Double) + tips
            totalToPayLabel.text = String(format: "$%.2f", total)
            
            let totalPerPerson = total / (numPeople as! Double)
            RecentCalculateData.instance.totalPerPersonToPay = String(format: "$%.2f", totalPerPerson)
            totalPerPersonLabel.text = String(format: "$%.2f", totalPerPerson)
            
        }
    }
    
    func removedDataFromUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "checkAmount")
        defaults.removeObject(forKey: "tipPercentageIndex")
        defaults.removeObject(forKey: "numberOfPeople")
        defaults.removeObject(forKey: "savedAt")
    }
    
    func animateTextfieldBgc() {
        switch tipPercentageControl.selectedSegmentIndex {
        case 0:
            checkAmountTextField.backgroundColor = UIColor(red: 249/255, green: 174/255, blue: 197/255, alpha: 1)
            checkAmountTextField.textColor = .white
        case 1:
            checkAmountTextField.backgroundColor = UIColor(red: 246/255, green: 120/255, blue: 167/255, alpha: 1)
            checkAmountTextField.textColor = .white
        case 2:
            checkAmountTextField.backgroundColor = UIColor(red: 234/255, green: 79/255, blue: 136/255, alpha: 1)
            checkAmountTextField.textColor = .white
        case 3:
            checkAmountTextField.backgroundColor = UIColor(red: 230/255, green: 64/255, blue: 114/255, alpha: 1)
            checkAmountTextField.textColor = .white
        default:
            checkAmountTextField.backgroundColor = .white
            checkAmountTextField.textColor = .black
        }
    }
  
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTips(_ sender: AnyObject) {
        
        let checkAmount = Double(checkAmountTextField.text!) ?? 0
        let numOfPeople = Int(numOfPeopleSlider.value)

        let tip = checkAmount * tipPercentages[tipPercentageControl.selectedSegmentIndex]
        let totalToPay = checkAmount + tip
        
        let totalPerPerson = (tip + checkAmount) / Double(numOfPeople)

        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalToPayLabel.text = String(format: "$%.2f", totalToPay)
        
        totalPerPersonLabel.text = String(format: "$%.2f", totalPerPerson)
        numOfPeopleLabel.text = String(numOfPeople)
        
        animateTextfieldBgc()
        
        RecentCalculateData.instance.checkAmount = Float(checkAmountTextField.text!)
        RecentCalculateData.instance.tipPercentageIndex = tipPercentageControl.selectedSegmentIndex
        RecentCalculateData.instance.numberOfPeople = Int(numOfPeopleSlider.value)
        
    }
    
    func saveRecentValuesIntoUserDefault(checkAmount: String, tipPercentageIndex: String, numberOfPeople: String) {
        let defaults = UserDefaults.standard
        defaults.set(checkAmount, forKey: "checkAmount")
        defaults.set(tipPercentageIndex, forKey: "tipPercentageIndex")
        defaults.set(numberOfPeople, forKey: "numberOfPeople")
        defaults.synchronize()
        
    }

}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}

