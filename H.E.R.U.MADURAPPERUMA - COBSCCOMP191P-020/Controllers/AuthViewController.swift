//
//  AuthViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/27/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "NIBM COVID19"
        label.font = UIFont(name: "Avenir-Light", size: 25)
        label.textColor = UIColor.black
        
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.image = UIImage(named: "stopCorona")
        imageView.layer.cornerRadius = imageView.frame.width / 2;
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let signupPageButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Create an Account", for: .normal)
        button.backgroundColor = .tileArrow
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(showSignUpPage), for: .touchUpInside)
        
        return button
    }()
    
    private let signinPageButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        button.addTarget(self, action: #selector(showSignInPage), for: .touchUpInside)
        button.setAttributedTitle(buttonTitle, for: .normal)
        
        return button
    }()
    
    private let termsAndConditionsButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "By signing up, you agree with the ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        attributedText.append(NSAttributedString(string: "Terms of Service", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        attributedText.append(NSAttributedString(string: " and ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        attributedText.append(NSAttributedString(string: "Privacy Policy.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleTOC), for: .touchUpInside)
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = NSTextAlignment.center
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func showSignInPage() {
        let view = SignInViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func showSignUpPage() {
        let view = SignUpViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func handleTOC() {
        //
    }
    
    // MARK: - Helper Function
    
    func configUI() {
        configNavBar()
        
        view.backgroundColor = .backgroundColor
        view.addSubview(titleLbl)
        titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: titleLbl.bottomAnchor, paddingTop: 100, width: 140, height: 140)
        logoImageView.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [signupPageButton, signinPageButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(termsAndConditionsButton)
        termsAndConditionsButton.centerX(inView: view)
        termsAndConditionsButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16,  height: 50)
        
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
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
