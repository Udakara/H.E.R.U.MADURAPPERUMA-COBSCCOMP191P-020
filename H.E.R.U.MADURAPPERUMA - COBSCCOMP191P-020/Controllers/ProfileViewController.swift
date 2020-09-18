//
//  ProfileViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/27/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    // MARK: - Properties
    
    var safeArea: UILayoutGuide!
    
    var user: User? {
        didSet { titleLbl.text = "\(user!.firstName) \(user!.lastName)" }
    }
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Update Profile"
        label.font = UIFont(name: "Avenir-Light", size: 26)
        label.textColor = .black
        return label
    }()
    
    private let blankView: UIView = {
        let blank = UIView()
        blank.backgroundColor = .white
        return blank
    }()
    
   private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.image = UIImage(named: "SQ01")
        imageView.layer.cornerRadius = imageView.frame.width / 2;
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let nameTextField: UITextField = {
           return UITextField().textField(withPlaceholder: "name", isSecureTextEntry: false)
       }()
    
    private lazy var firstNameContainerView: UIView = {
        let view = UIView().inputContainerView(textField: nameTextField )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let indexTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "index", isSecureTextEntry: false)
    }()
    
    private lazy var indexContainerView: UIView = {
        let view = UIView().inputContainerView(textField: indexTextField  )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        fetchUserData()
        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func configUI() {
        configNavBar()
        view.backgroundColor = .white
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        view.addSubview(backButton)
        backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
//        view.addSubview(blankView)
//        blankView.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, paddingTop: 20)
        view.addSubview(logoImageView)
        logoImageView.anchor(top: titleLbl.bottomAnchor, paddingTop: 100, width: 140, height: 140)
        logoImageView.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [firstNameContainerView,indexContainerView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16)
        
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - API
    
    func fetchUserData() {
        print("here")
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        print(currentUid)
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }


}
