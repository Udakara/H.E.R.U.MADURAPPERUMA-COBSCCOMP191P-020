//
//  ResultViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/26/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResultViewController: UIViewController {

    var result: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        setupView()
    }
    
    func showRating() {
        var rating = ""
        var color = UIColor.black
        guard let percent = result else { return }
        if percent < 5 {
            rating = "VERY LOW"
            color = UIColor.green
        } else if percent <= 25 {
            rating = "LOW"
            color = UIColor.darkGray
        }  else if percent <= 50 {
            rating = "MEDIUM"
            color = UIColor.yellow
        } else if percent <= 75 {
            rating = "HIGH"
            color = UIColor.orange
        } else if percent <= 100 {
            rating = "VERY HIGH"
            color = UIColor.red
        }
        lblRating.text = "\(rating)"
        lblRating.textColor=color
        updateResult()
    }
    
    @objc func btnGoBackAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupView() {
        
        self.view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive=true
        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblTitle.widthAnchor.constraint(equalToConstant: 250).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 80).isActive=true
        
        self.view.addSubview(lblScore)
        lblScore.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 0).isActive=true
        lblScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblScore.widthAnchor.constraint(equalToConstant: 150).isActive=true
        lblScore.heightAnchor.constraint(equalToConstant: 60).isActive=true
        lblScore.text = "\(result!)%"
        
        self.view.addSubview(lblRating)
        lblRating.topAnchor.constraint(equalTo: lblScore.bottomAnchor, constant: 40).isActive=true
        lblRating.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblRating.widthAnchor.constraint(equalToConstant: 150).isActive=true
        lblRating.heightAnchor.constraint(equalToConstant: 60).isActive=true
        showRating()
        
        self.view.addSubview(btnGoBack)
        btnGoBack.topAnchor.constraint(equalTo: lblRating.bottomAnchor, constant: 40).isActive=true
        btnGoBack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnGoBack.widthAnchor.constraint(equalToConstant: 150).isActive=true
        btnGoBack.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnGoBack.addTarget(self, action: #selector(btnGoBackAction), for: .touchUpInside)
    }
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text="Risk Level"
        lbl.textColor=UIColor.darkGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 42)
        lbl.numberOfLines=2
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblScore: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblRating: UILabel = {
        let lbl=UILabel()
        lbl.text="LOW"
        lbl.textColor=UIColor.black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
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
    
    func updateResult() {
        guard let result = result else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let values = [
            "surveyResult": result,
            "surveyDate": [".sv": "timestamp"]
        ] as [String : Any]
        
        self.uploadResult(uid: currentUid, values: values)
    }
    
    func uploadResult(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if error == nil {
                print("No error")
            }else {
                print(error?.localizedDescription as Any)
            }
        }
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
