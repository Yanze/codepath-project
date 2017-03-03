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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        (UserDefaults.standard.object(forKey: "isDarkTheme") as? Bool)! ? isDarkTheme.setOn(true, animated: true) : isDarkTheme.setOn(false, animated: true)
    }
    
    func createTextMessage() {
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.messageComposeDelegate = self
            
            var amountShouldPay = RecentCalculateData.instance.totalPerPersonToPay
            if amountShouldPay == nil {
                amountShouldPay = "0"
            }
            
            controller.body = "Hi, You should give back $\(amountShouldPay!) to your friend(example message)"
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
            sender.setOn(true, animated: true)
            defaults.set(true, forKey: "isDarkTheme")
            return
        }
        else {
            sender.setOn(false, animated: true)
            defaults.set(false, forKey: "isDarkTheme")
        }
        
    }
    
    
    
    
}
