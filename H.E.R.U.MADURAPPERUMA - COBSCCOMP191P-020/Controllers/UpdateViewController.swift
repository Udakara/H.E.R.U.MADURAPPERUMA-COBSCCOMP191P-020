//
//  UpdateViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/25/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class UpdateViewController: UIViewController {
    
    private var user: User? {
        didSet {
            tempLbl.text = "\(user!.temperature)°C"
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Update Details"
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.textColor = .black
        return label
    }()
    
    private let notificTile: UIButton = {
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
        
        return tile
    }()
    
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
    
    private let tmpText: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        return textField
    }()
    
    private let tempLbl: UILabel = {
        let label = UILabel()
        label.text = "0°C"
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private lazy var tempTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .tileColor
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        
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
        
        tile.addSubview(tmpText)
        tmpText.anchor(top: timeAgo.bottomAnchor, paddingTop: 40, width: 100)
        tmpText.centerX(inView: tile)
        
        let tempBtn = UIButton()
        tempBtn.setTitle("UPDATE", for: .normal)
        tempBtn.setTitleColor(.black, for: .normal)
        tempBtn.backgroundColor = .tileArrow
        tempBtn.layer.borderColor = UIColor.black.cgColor
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.cornerRadius = 5.0
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tempBtn.addTextSpacing(2)
        tempBtn.addTarget(self, action: #selector(handleTempUpdate), for: .touchUpInside)
        tile.addSubview(tempBtn)
        tempBtn.anchor(top: tmpText.bottomAnchor, paddingTop: 35, width: 120, height: 40)
        tempBtn.centerX(inView: tile)
        
        return tile
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        sv.contentSize = CGSize(width: screensize.width - 2.0, height: screensize.height)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.fetchUserData()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Selectors
    
    @objc func showNotifications() {

    }
    
    @objc func showNewSurvey() {
        let vc = SurveyViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTempUpdate() {
        guard let temp = tmpText.text else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let temperatureValue = Float(temp)
        
        if temperatureValue == nil {
            let alert = UIAlertController(title: "Temprature is Required!", message: "Please enter your body temprature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if (temperatureValue! < 34.0) || (temperatureValue! > 47.0)  {
            let alert = UIAlertController(title: "Invalid Temprature!", message: "Please insert valid Temprature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        self.view.endEditing(true)
        let values = [
            "temperature": temp,
            "tempDate": [".sv": "timestamp"]
        ] as [String : Any]
        self.uploadUserTemperature(uid: currentUid, values: values)
        self.tmpText.text = ""
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
            self.configUI()
        }
    }
    
    // MARK: - Helper Functions
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .systemGray6
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 1.0, paddingLeft: 1.0, paddingBottom: -1.0, paddingRight: -1.0)
        
        scrollView.addSubview(notificTile)
        
        if (user?.role ?? "") as String == "Admin" {
            notificTile.anchor(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        }
        
        scrollView.addSubview(surveyTile)
        surveyTile.anchor(top: notificTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        
        scrollView.addSubview(tempTile)
        tempTile.anchor(top: surveyTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16, height: 300)
    }
    
    func configNavBar() {
        //navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    func uploadUserTemperature(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if error == nil {
                self.tempLbl.text = "\(values["temperature"] as? String ?? "0")°C"
            }
        }
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
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
