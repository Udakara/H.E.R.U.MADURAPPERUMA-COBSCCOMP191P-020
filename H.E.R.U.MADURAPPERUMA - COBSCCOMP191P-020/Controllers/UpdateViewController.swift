//
//  UpdateViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/25/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Update Details"
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.textColor = .black
        return label
    }()
    
    // Notifications tile
    
    private let notificationsTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .tileColor
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        tile.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
        
        let title = UILabel()
        title.text = "Create Notifications"
        title.font = UIFont(name: "Avenir-Medium", size: 18)
        title.textColor = UIColor.black
        tile.addSubview(title)
        title.anchor(left: tile.leftAnchor, paddingLeft: 20)
        title.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        arrow.tintColor = .black
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
        arrow.centerY(inView: tile)
        
        return tile    }()
    
    
    // New survey tile
    
    private let surveyTile: UIButton = {
        let tileView = UIButton()
        tileView.backgroundColor = .tileColor
        tileView.layer.cornerRadius = 5
        tileView.layer.masksToBounds = true
        tileView.addTarget(self, action: #selector(showNewSurvey), for: .touchUpInside)
               
        let title = UILabel()
        title.text = "New Survey"
        title.font = UIFont(name: "Avenir-Medium", size: 18)
        title.textColor = UIColor.black
        tileView.addSubview(title)
        title.anchor(left: tileView.leftAnchor, paddingLeft: 20)
        title.centerY(inView: tileView)
               
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        arrow.tintColor = .black
        arrow.layer.masksToBounds = true
        tileView.addSubview(arrow)
        arrow.anchor(right: tileView.rightAnchor, paddingRight: 20, width: 14, height: 24)
        arrow.centerY(inView: tileView)
               
        return tileView
    }()
    
    
    
    //new temperature tile
    
    private let temperatureTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .tileColor
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        
        let tempLbl = UILabel()
        tempLbl.text = "35"
        tempLbl.font = UIFont.systemFont(ofSize: 30)
        tile.addSubview(tempLbl)
        tempLbl.anchor(top: tile.topAnchor, paddingTop: 40)
        tempLbl.centerX(inView: tile)
        
        let timeAgo = UILabel()
        timeAgo.text = "Last Update: 1 Day ago"
        timeAgo.font = UIFont.systemFont(ofSize: 12)
        timeAgo.textColor = .darkGray
        tile.addSubview(timeAgo)
        timeAgo.anchor(top: tempLbl.bottomAnchor, paddingTop: 20)
        timeAgo.centerX(inView: tile)
        
        let tempInput = UITextField()
        tempInput.borderStyle = .roundedRect
        tempInput.layer.borderColor = UIColor.black.cgColor
        tempInput.layer.borderWidth = 0.5
        tempInput.layer.cornerRadius = 5.0
        tempInput.layer.masksToBounds = true
        tile.addSubview(tempInput)
        tempInput.anchor(top: timeAgo.bottomAnchor, paddingTop: 40, width: 100)
        tempInput.centerX(inView: tile)
        
        let tempBtn = UIButton()
        tempBtn.setTitle("UPDATE", for: .normal)
        tempBtn.setTitleColor(.black, for: .normal)
        tempBtn.backgroundColor = .tileArrow
        tempBtn.layer.borderColor = UIColor.black.cgColor
        tempBtn.layer.borderWidth = 1
        tempBtn.layer.cornerRadius = 6.0
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tempBtn.addTextSpacing(2)
        tile.addSubview(tempBtn)
        tempBtn.anchor(top: tempInput.bottomAnchor, paddingTop: 35, width: 120, height: 40)
        tempBtn.centerX(inView: tile)
        
        return tile
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        view.addSubview(notificationsTile)
        notificationsTile.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        // survey tile
        
        view.addSubview(surveyTile)
        surveyTile.anchor(top: notificationsTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        
        //temperatire tile
        
        view.addSubview(temperatureTile)
        temperatureTile.anchor(top: surveyTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16, height: 300)
    }
    
    
    func configNavBar() {
            //navigationController?.navigationBar.barTintColor = .lightGray
            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.barStyle = .default
        }
        
        // MARK: - Selectors
        
        @objc func showNotifications() {
            let nav = UINavigationController(rootViewController: SafeTipsViewController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)

        }
    
    @objc func showTemperatureUpdate() {
        let viewController = TemperatureUpdateViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
        
        @objc func showNewSurvey() {
            let viewController = SurveyViewController()
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: false)
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
