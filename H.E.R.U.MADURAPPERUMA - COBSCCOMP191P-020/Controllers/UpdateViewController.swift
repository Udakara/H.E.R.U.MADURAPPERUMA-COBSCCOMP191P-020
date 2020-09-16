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
        let tileView = UIButton()
        tileView.backgroundColor = .systemGray3
        tileView.layer.cornerRadius = 5
        tileView.layer.masksToBounds = true
        tileView.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
        return tileView
    }()
    
    private let notificationsTileLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Notifications"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        label.backgroundColor = .systemGray3
        return label
    }()
    
    private let notificationsTileButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: boldConfig), for: .normal)
        button.backgroundColor = .systemGray
        return button
    }()
    
    // New survey tile
    
    private let surveyTileUIView: UIView = {
        let tileView = UIView()
        tileView.backgroundColor = .white
        tileView.layer.cornerRadius = 3
        tileView.layer.masksToBounds = true
        return tileView
    }()
    
    private let surveyTile: UIButton = {
        let tileBtn = UIButton()
        tileBtn.backgroundColor = .systemGray3
        tileBtn.layer.cornerRadius = 3
        tileBtn.layer.masksToBounds = true
        //tileBtn.addTarget(self, action: #selector(showNewSurvey), for: .touchUpInside)
        return tileBtn
    }()
    
    private let surveyTileLabel: UILabel = {
        let label = UILabel()
        label.text = "New Survey"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        //label.backgroundColor = .red
        return label
    }()
    
    private let surveyTileButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: boldConfig), for: .normal)
        button.backgroundColor = .systemGray
        //button.addTarget(self, action: #selector(showNewSurvey), for: .touchUpInside)
        return button
    }()
    
    
    
    //new temperature tile
    
    private let temperatureTile: UIButton = {
        let tileBtn = UIButton()
        tileBtn.backgroundColor = .systemGray3
        tileBtn.layer.cornerRadius = 3
        tileBtn.layer.masksToBounds = true
        //tileBtn.addTarget(self, action: #selector(showNewSurvey), for: .touchUpInside)
        return tileBtn
    }()
    
    private let temperatureTileLabel: UILabel = {
        let label = UILabel()
        label.text = "update temperature"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        //label.backgroundColor = .red
        return label
    }()
    
    private let temperatureTileButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: boldConfig), for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(showTemperatureUpdate), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .systemGray4
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        view.addSubview(notificationsTile)
        notificationsTile.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        
        view.addSubview(notificationsTileLabel)
        notificationsTileLabel.anchor(top: notificationsTile.topAnchor, left: notificationsTile.leftAnchor, paddingLeft: 25)
        notificationsTileLabel.centerY(inView: notificationsTile)
        
        view.addSubview(notificationsTileButton)
        notificationsTileButton.anchor(top: notificationsTile.topAnchor, right: notificationsTile.rightAnchor, width: 60)
        notificationsTileButton.centerY(inView: notificationsTile)
        
        // survey tile
        
        view.addSubview(surveyTile)
        surveyTile.anchor(top: notificationsTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)

        view.addSubview(surveyTileLabel)
        surveyTileLabel.anchor(top: surveyTile.topAnchor, left: surveyTile.leftAnchor, paddingLeft: 25)
        surveyTileLabel.centerY(inView: surveyTile)

        view.addSubview(surveyTileButton)
        surveyTileButton.anchor(top: surveyTile.topAnchor, right: surveyTile.rightAnchor, width: 60)
        surveyTileButton.centerY(inView: surveyTile)
        
        //temperatire tile
        
        view.addSubview(temperatureTile)
        temperatureTile.anchor(top: surveyTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        
        view.addSubview(temperatureTileLabel)
        temperatureTileLabel.anchor(top: temperatureTile.topAnchor, left: temperatureTile.leftAnchor, paddingLeft: 25)
        temperatureTileLabel.centerY(inView: temperatureTile)
        
        view.addSubview(temperatureTileButton)
        temperatureTileButton.anchor(top: temperatureTile.topAnchor, right: temperatureTile.rightAnchor, width: 60)
        temperatureTileButton.centerY(inView: temperatureTile)
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
        let vc = TemperatureUpdateViewController()
//        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
        @objc func showNewSurvey() {
    //        let nav = UINavigationController(rootViewController: SurveyViewController())
    //        nav.modalPresentationStyle = .fullScreen
    //        self.present(nav, animated: true, completion: nil)
//            let vc = SurveyViewController()
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: false)
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
