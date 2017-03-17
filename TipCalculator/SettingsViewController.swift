//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by yanze on 3/2/17.
//  Copyright © 2017 yanzeliu. All rights reserved.
//

import UIKit
import MessageUI
import Instabug

class SettingsViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var isDarkTheme: UISwitch!
    @IBOutlet weak var reportBugImgView: UIImageView!
    @IBOutlet weak var askingPayBack: UIButton!
    @IBOutlet weak var reportBug: UIButton!
    @IBOutlet weak var darkThemeLabel: UILabel!
    @IBOutlet weak var tipPercentageControl: UISegmentedControl!
    let tipPercentages = [0.1, 0.15, 0.2, 0.25]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        tableView.allowsSelection = false
        reportBugImgViewCornerRadius()
        Helpers.sharedInstance.toggleColorTheme(view: view, navigationController: navigationController!, tableView: tableView)
        togglecomponentsBgc()
        
        if let index = RecentCalculateData.instance.tipPercentageIndex {
            tipPercentageControl.selectedSegmentIndex = index
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Helpers.sharedInstance.toggleColorTheme(view: view, navigationController: navigationController!, tableView: tableView)
        togglecomponentsBgc()
        if let index = RecentCalculateData.instance.tipPercentageIndex {
            tipPercentageControl.selectedSegmentIndex = index
        }
    }
    
    @IBAction func tipSegmentController(_ sender: UISegmentedControl) {
        RecentCalculateData.instance.tipPercentageIndex = tipPercentageControl.selectedSegmentIndex
    }
    
    
    func setupTheme() {
        navigationItem.title = "Settings"
        guard let isDarkthem = UserDefaults.standard.object(forKey: "isDarkTheme") as? Bool else {
            return
        }
        isDarkthem ? isDarkTheme.setOn(true, animated: true) : isDarkTheme.setOn(false, animated: true)
    }
    
    func reportBugImgViewCornerRadius() {
        reportBugImgView.layer.cornerRadius = 5
        reportBugImgView.clipsToBounds = true
    }
    
    func createTextMessage() {
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.messageComposeDelegate = self
            
            var amountShouldPay = RecentCalculateData.instance.totalPerPersonToPay
            if amountShouldPay == nil {
                amountShouldPay = "0"
            }
            let needToPay = String(format: "%.2f", Float(amountShouldPay!)!)
            controller.body = "Hi, this is a friendly reminder: Don't forget to pay back $\(needToPay) to your friend."
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendingTextMessage(_ sender: UIButton) {
        createTextMessage()
    }
    
    
    @IBAction func reportBug(_ sender: UIButton) {
        Instabug.invoke(with: IBGInvocationMode.newBug)
    }
    
    @IBAction func switchToDarkTheme(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if sender.isOn {
            defaults.set(true, forKey: "isDarkTheme")
        }
        else {
            defaults.set(false, forKey: "isDarkTheme")
        }
        Helpers.sharedInstance.toggleColorTheme(view: view, navigationController: navigationController!, tableView: tableView)
        togglecomponentsBgc()
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let isDarkthem = UserDefaults.standard.object(forKey: "isDarkTheme") as? Bool else {
            return
        }
        if isDarkthem {
            cell.backgroundColor = UIColor.darkGray
        }
        else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    func togglecomponentsBgc() {
        guard let isDarkthem = UserDefaults.standard.object(forKey: "isDarkTheme") as? Bool else {
            return
        }
        if isDarkthem {
            askingPayBack.setTitleColor(.white, for: .normal)
            reportBug.setTitleColor(.white, for: .normal)
            darkThemeLabel.textColor = .white
            tipPercentageControl.backgroundColor = .clear
            tipPercentageControl.tintColor = .white
        }
        else {
            askingPayBack.setTitleColor(.darkGray, for: .normal)
            reportBug.setTitleColor(.darkGray, for: .normal)
            darkThemeLabel.textColor = .darkGray
            tipPercentageControl.backgroundColor = .white
            tipPercentageControl.tintColor = .darkGray
        }
    }
    

    
    
}
