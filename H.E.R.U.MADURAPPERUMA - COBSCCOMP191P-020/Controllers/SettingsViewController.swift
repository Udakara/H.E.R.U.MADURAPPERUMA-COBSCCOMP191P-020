//
//  SettingsViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/25/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide!
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.textColor = .black
        return label
    }()
    
    private let profileTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .tileColor
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        tile.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        
        let title = UILabel()
        title.text = "Profile"
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
    
    private let contactTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .tileColor
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        tile.addTarget(self, action: #selector(showContact), for: .touchUpInside)
        
        let title = UILabel()
        title.text = "Contact Us/ About Us"
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
        
        return tile
    }()
    
    private let shareTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .tileColor
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        tile.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        
        let title = UILabel()
        title.text = "Share with friend"
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
        
        return tile
    }()
    
    private let blankView: UIView = {
        let blank = UIView()
        blank.backgroundColor = .backgroundColor
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        blank.addSubview(separatorView)
        separatorView.anchor(left: blank.leftAnchor, bottom: blank.bottomAnchor, right: blank.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return blank
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tileArrow
        button.setTitle("LOGOUT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        button.addTextSpacing(2)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
       signOut()
    }
    
    @objc func showProfile() {
        let vc = ProfileViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showContact() {
        let vc = ContactViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleShare() {
       print("Share!")
    }
    
    // MARK: - Helper Function

    func configUI() {
        configNavBar()
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [profileTile, contactTile, shareTile])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        
        view.addSubview(stack)
        stack.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 250)
        
        view.addSubview(logoutButton)
        logoutButton.anchor(left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, height: 60)
        
        view.addSubview(blankView)
        blankView.anchor(top: stack.bottomAnchor, left: view.leftAnchor, bottom: logoutButton.topAnchor, right: view.rightAnchor)
        
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: AuthViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            print("sign out error!")
        }
    }

}

