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

    var safeArea: UILayoutGuide!
    
    var user: User? {
        didSet {
            titleLbl.text = "\(user!.firstName) \(user!.lastName)"
            firstNameTF.text = user!.firstName
            lastNameTF.text = user!.lastName
            indexTF.text = user!.index
            countryTF.text = user!.country
            tempLbl.text = "\(user!.temperature)°C"
        }
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
    
    private let avatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 50;
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    
    private let bioLbl: UILabel = {
        let label = UILabel()
        label.text = "Acme user since Aug 2020 at Matara, Sri Lanka"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let tempLbl: UILabel = {
        let label = UILabel()
        label.text = "0°C"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let firstNameTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "First Name"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let lastNameTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Last Name"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let indexTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Index"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let countryTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Country"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tileArrow
        button.setTitle("UPDATE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        button.addTextSpacing(2)
        button.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        scroll.contentSize = CGSize(width: screensize.width, height: screensize.height)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var mainTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .backgroundColor
        
        tile.addSubview(updateButton)
        updateButton.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, height: 60)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .backgroundColor
        tile.addSubview(separatorView)
        separatorView.anchor(left: tile.leftAnchor, bottom: updateButton.topAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        tile.addSubview(scrollView)
        scrollView.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: separatorView.topAnchor, right: tile.rightAnchor)
        
        scrollView.addSubview(avatar)
        avatar.anchor(top: scrollView.topAnchor, paddingTop: 30, width: 100, height: 100)
        avatar.centerX(inView: scrollView)
        
        scrollView.addSubview(tempLbl)
        tempLbl.anchor(top: avatar.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 10, paddingLeft: 70, paddingRight: 70)
        tempLbl.centerX(inView: scrollView)
        
        let stack = UIStackView(arrangedSubviews: [firstNameTF, lastNameTF, indexTF, countryTF])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 30
        scrollView.addSubview(stack)
        stack.anchor(top: tempLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        return tile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        fetchUserData()
        configUI()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleUpdate() {
        guard let firstName = firstNameTF.text else { return }
        guard let lastName = lastNameTF.text else { return }
        guard let index = indexTF.text else { return }
        guard let country = countryTF.text else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        if firstName.isEmpty {
            let alert = UIAlertController(title: "First name field is empty", message: "Please enter your first name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if lastName.isEmpty  {
            let alert = UIAlertController(title: "Last Name field is empty", message: "Please enter your last name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if index.isEmpty  {
            let alert = UIAlertController(title: "Index field is empty", message: "Please enter your index", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if country.isEmpty  {
            let alert = UIAlertController(title: "Country field is empty", message: "Please enter your country", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        self.view.endEditing(true)
        let values = [
            "firstName": firstName,
            "lastName": lastName,
            "index": index,
            "country": country,
            "profileDate": [".sv": "timestamp"]
        ] as [String : Any]
        self.uploadUserProfile(uid: currentUid, values: values)
        
    }

    func configUI() {
        configNavBar()
        view.backgroundColor = .backgroundColor
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        view.addSubview(backButton)
        backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
        view.addSubview(mainTile)
        mainTile.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }
    
    func uploadUserProfile(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if error == nil {
                let alert = UIAlertController(title: "Success!", message: "successfully updated your profile", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }


}
