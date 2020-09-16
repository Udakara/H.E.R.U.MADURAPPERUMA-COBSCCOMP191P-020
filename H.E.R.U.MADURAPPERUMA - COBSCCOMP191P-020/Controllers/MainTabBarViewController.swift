//
//  MainTabBarViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/25/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .systemGray4
        configTabBar()        // Do any additional setup after loading the view.
    }
    
    func configTabBar() {
        let homeController = UINavigationController(rootViewController: HomeViewController())
        homeController.tabBarItem.image = UIImage(systemName: "house.fill")
        homeController.tabBarItem.title = "Home"
        
        let updateController = UINavigationController(rootViewController: UpdateViewController())
        updateController.tabBarItem.image = UIImage(systemName: "pencil")
        updateController.tabBarItem.title = "Update"
        
        let settingsController = UINavigationController(rootViewController: SettingsViewController())
        settingsController.tabBarItem.image = UIImage(systemName: "wrench.fill")
        settingsController.tabBarItem.title = "Settings"
        
        viewControllers = [homeController, updateController, settingsController]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
