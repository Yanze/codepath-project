//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by yanze on 3/2/17.
//  Copyright © 2017 yanzeliu. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
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
    
    
    
}
