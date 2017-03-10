//
//  Helpers.swift
//  TipCalculator
//
//  Created by yanze on 3/3/17.
//  Copyright © 2017 yanzeliu. All rights reserved.
//

import UIKit

class Helpers: NSObject {
    static let sharedInstance = Helpers()
    
    func setDarkTheme(view: UIView, navigationController: UINavigationController, tableView: UITableView?) {
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barTintColor = .darkGray
        
        view.backgroundColor = .darkGray
        tableView?.backgroundColor = .darkGray
        
    }
    
    func resetThemeColor(view: UIView, navigationController: UINavigationController,tableView: UITableView?) {
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        
        navigationController.navigationBar.tintColor = .darkGray
        
        navigationController.navigationBar.barTintColor = .white
        
        view.backgroundColor = .white
        tableView?.backgroundColor = .white
    
        
    }
    
    func toggleColorTheme(view: UIView, navigationController: UINavigationController, tableView: UITableView?) {
        DispatchQueue.main.async {
            guard let isDarktheme = UserDefaults.standard.object(forKey: "isDarkTheme") as? Bool else {
                return
            }
            isDarktheme ? self.setDarkTheme(view: view, navigationController: navigationController, tableView: tableView) : self.resetThemeColor(view: view, navigationController: navigationController, tableView: tableView)
        }
    }
    
    
}
