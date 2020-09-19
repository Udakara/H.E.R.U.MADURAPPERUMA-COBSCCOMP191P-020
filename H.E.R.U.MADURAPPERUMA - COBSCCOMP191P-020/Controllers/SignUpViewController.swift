//
//  SignUpViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/28/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth
import GeoFire

class SignUpViewController: UIViewController {

    private var location = LocationHandler.shared.locationManager.location
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back_black"), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Create an Account"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var firstNameContainerView: UIView = {
        let view = UIView().inputContainerView(textField: firstNameTextField )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var lastNameContainerView: UIView = {
        let view = UIView().inputContainerView(textField: lastNameTextField )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(textField: emailTextField )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var roleContainerView: UIView = {
        let view = UIView().inputContainerView(textField: roleTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let firstNameTextField: UITextField = {
        let firstName =  UITextField().textField(withPlaceholder: "First Name", isSecureTextEntry: false)
        return firstName
        
    }()
    
    private let lastNameTextField: UITextField = {
        let lastName =  UITextField().textField(withPlaceholder: "Last Name", isSecureTextEntry: false)
        return lastName
    }()
    
    private let emailTextField: UITextField = {
        let email =  UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
        return email
    }()
    
    private let roleTextField: UITextField = {
        let role =  UITextField().textField(withPlaceholder: "Role", isSecureTextEntry: false)
        return role
    }()
    
    private let passwordTextField: UITextField = {
        let password =  UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
        return password
    }()
    
    private let signupButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Create an Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        button.backgroundColor = .tileArrow
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
    
    private let signinPageButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray])
        button.addTarget(self, action: #selector(showSignInPage), for: .touchUpInside)
        button.setAttributedTitle(buttonTitle, for: .normal)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        sv.contentSize = CGSize(width: screensize.width - 2.0, height: screensize.height + 2.0)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @objc func handleSignUp() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        guard let role = roleTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Faild to signup user with error \(error)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = [
                "lastName": lastName,
                "firstName": firstName,
                "email": email,
                "role": role,
            ] as [String : Any]
            
            let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)
            
            guard let location = self.location else { return }
                
            geoFire.setLocation(location, forKey: uid, withCompletionBlock: { (error) in
                self.uploadUserDataAndShowHomeController(uid: uid, values: values)
            })
        
            self.uploadUserDataAndShowHomeController(uid: uid, values: values)
        }
    }
    
    @objc func handleGoBack() {
       navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTOC() {
       //
    }
    
    @objc func showSignInPage() {
       let view = SignInViewController()
       navigationController?.popViewController(animated: true)
       navigationController?.pushViewController(view, animated: true)
    }
    
    func uploadUserDataAndShowHomeController(uid: String, values: [String: Any]) {
        print("here",uid);
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            
            guard let controller = keyWindow?.rootViewController as? MainTabBarViewController else { return }
            controller.configTabBar()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func configUI() {
        configNavBar()
        
        view.backgroundColor = .backgroundColor
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 40, height: 40)
        view.addSubview(titleLbl)
        titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 1.0, paddingLeft: 1.0, paddingBottom: -1.0, paddingRight: -1.0)
        
        let stack = UIStackView(arrangedSubviews: [firstNameContainerView, lastNameContainerView, emailContainerView, roleContainerView, passwordContainerView, signupButton, termsAndConditionsButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        scrollView.addSubview(stack)
        stack.anchor(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16)
        
        scrollView.addSubview(signinPageButton)
        signinPageButton.anchor(top: termsAndConditionsButton.bottomAnchor, paddingTop: 30)
        signinPageButton.centerX(inView: view)
        
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