//
//  TemperatureUpdateViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/26/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit

class TemperatureUpdateViewController: UIViewController {
    var safeArea: UILayoutGuide!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Update Your body temperature"
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.textColor = .black
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        viewUI()
        // Do any additional setup after loading the view.
    }
    
    private func viewUI(){
        configNavBar()
        view.backgroundColor = .systemGray4
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        titleLabel.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        view.addSubview(backButton)
        backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
    }
    
    @objc func handleGoBack() {
        print("here")
        self.navigationController?.popToRootViewController(animated: true)
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
