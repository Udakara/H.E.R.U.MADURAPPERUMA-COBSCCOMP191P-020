//
//  ThirdSafeActionViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/30/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit

class ThirdSafeActionViewController: UIViewController {
        
            private let titleLabel: UILabel = {
                let label = UILabel()
                label.text = "Safe Actions"
                label.font = UIFont(name: "Avenir-Light", size: 28)
                label.font=UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
                label.textColor = .black
                
                return label
            }()
            
            private lazy var WelcomeImgView: UIImageView = {
                let imageview = UIImageView()
                imageview.frame = CGRect(x: 0, y: 0, width: 439, height:500)
                imageview.image = UIImage(named:"safeAction3")
                imageview.layer.masksToBounds = true
                return imageview
                
            }()
        
        
        private let warningLabel: UILabel = {
                   let warningLabel = UILabel()
                   warningLabel.text = "Fallow Guidlines"
                   warningLabel.font=UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
                   warningLabel.textColor = .black
                   
                   return warningLabel
               }()
        
        private let questionOneLabel: UILabel = {
                      let questionOneLabel = UILabel()
                      questionOneLabel.text = "always fallow guidlines provided by the goverment"
                      questionOneLabel.font = UIFont(name: "Avenir-Light", size: 18)
                      questionOneLabel.textColor = .black
                      return questionOneLabel
                  }()
    
        let nextButton: UIButton = {
               let button = UIButton(type: .system)
               let attributedTitle = NSMutableAttributedString(string: "Home", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint])
               button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
               button.setAttributedTitle(attributedTitle, for: .normal)
               return button
        }()
    
         let btnGoBack: UIButton = {
             let btn = UIButton()
             btn.setTitle("Go Back", for: .normal)
             btn.setTitleColor(.white, for: .normal)
             btn.backgroundColor = .black
             btn.layer.cornerRadius = 5
             btn.clipsToBounds = true
             btn.translatesAutoresizingMaskIntoConstraints = false
             return btn
         }()
        

            
            
            // MARK: - Lifecycale
            
            override func viewDidLoad() {
                super.viewDidLoad()
                configUI()
            }
    
            @objc func handleGoBack() {
                      navigationController?.popViewController(animated: true)
                   }
        
            @objc func handleNext() {
                       let vc = HomeViewController()
                        navigationController?.pushViewController(vc, animated: false)
                   }
            @objc func btnGoBackAction() {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
             //MARk:- helper Function
            func configUI(){
                configNavBar()
                view.backgroundColor = .backgroundColor
        
                
                view.addSubview(titleLabel)
                titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
                titleLabel.centerX(inView: view)
                
                view.addSubview(WelcomeImgView)
                WelcomeImgView.anchor(top: titleLabel.bottomAnchor, paddingTop: 30, width: 300, height: 270)
                WelcomeImgView.centerX(inView: view)
                
               
                view.addSubview(warningLabel)
                warningLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 380)
                warningLabel.centerX(inView: view)
                
                
                view.addSubview(questionOneLabel)
                questionOneLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 410)
                questionOneLabel.centerX(inView: view)
                
                self.view.addSubview(btnGoBack)
                btnGoBack.topAnchor.constraint(equalTo: questionOneLabel.bottomAnchor, constant: 40).isActive=true
                btnGoBack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
                btnGoBack.widthAnchor.constraint(equalToConstant: 150).isActive=true
                btnGoBack.heightAnchor.constraint(equalToConstant: 50).isActive=true
                btnGoBack.addTarget(self, action: #selector(btnGoBackAction), for: .touchUpInside)
                
    }
    
    
            func configNavBar(){
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
