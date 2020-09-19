//
//  FullMapViewController.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/29/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth

class FullMapViewController: UIViewController {

    private let mapView = MKMapView()
        private let locationManager = LocationHandler.shared.locationManager
        var safeArea: UILayoutGuide!
        
        private let topNav: UIView = {
            let mv = UIView()
            mv.backgroundColor = .backgroundColor
            
            let backButton = UIButton()
            let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
            backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
            backButton.tintColor = .black
            backButton.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
            mv.addSubview(backButton)
            backButton.anchor(left: mv.leftAnchor, paddingLeft: 16, width: 38, height: 38)
            backButton.centerY(inView: mv)
            
            let titleLbl = UILabel()
            titleLbl.text = "Full map View"
            titleLbl.font = UIFont(name: "Avenir-Light", size: 20)
            titleLbl.textColor = .black
            titleLbl.adjustsFontSizeToFitWidth = true
            mv.addSubview(titleLbl)
            titleLbl.centerY(inView: mv)
            titleLbl.centerX(inView: mv)
            
            return mv
        }()
        
        private let mapTile: UIView = {
            let tile = UIView()
            tile.backgroundColor = .white
            return tile
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            safeArea = view.layoutMarginsGuide
            configUI()
            fetchOtherUsers()
        }
        
        // MARK: - Selectors
        
        @objc func handleGoBack() {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        // MARK: - API
        
        func fetchOtherUsers() {
            guard let location = locationManager?.location else { return }
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            
            Service.shared.fetchUsersLocation(location: location) { (user) in
                guard let coordinate = user.location?.coordinate else { return }
                let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)
                
                let temp = Float(user.temperature)!
                let result = user.surveyResult
                
                var usersVisible: Bool {
                    
                    return self.mapView.annotations.contains { (annotation) -> Bool in
                        guard let userAnno = annotation as? UserAnnotation else { return false }
                        
                        if userAnno.uid == user.uid {
                            if temp >= 38.0 && result >= 3 {
                                userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                                return true
                            }
                        }
                        
                        return false
                    }
                }
                
                if !usersVisible {
                    if user.uid != currentUid {
                        if temp >= 38.0 && result >= 3 {
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            }
        }

        
        // MARK: - Helper Functions
        
        func configUI() {
            view.backgroundColor = .systemGray6
            configNavBar()
            view.addSubview(topNav)
            topNav.anchor(top: safeArea.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 70)
            view.addSubview(mapTile)
            mapTile.anchor(top: topNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
            configMapView()
        }
        
        func configMapView() {
            mapTile.addSubview(mapView)
            mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 70)
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            mapView.delegate = self
            mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(UserAnnotation.self))
        }
        
        func configNavBar() {
            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.barStyle = .default
        }

    }

    // MARK: - MKMapViewDelegate

    extension FullMapViewController: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? UserAnnotation {
                let identifier = NSStringFromClass(UserAnnotation.self)
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
                if let markerAnnotationView = view as? MKMarkerAnnotationView {
                    markerAnnotationView.animatesWhenAdded = true
                    markerAnnotationView.canShowCallout = false
                    markerAnnotationView.markerTintColor = .red
                }
                return view
            }
            return nil
        }
    }

    // MARK: - LocationServices

    extension FullMapViewController {
        
        func enableLocationServices() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager?.requestWhenInUseAuthorization()
            case .restricted, .denied:
                break
            case .authorizedWhenInUse:
                locationManager?.requestAlwaysAuthorization()
            case .authorizedAlways:
                locationManager?.startUpdatingLocation()
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            default:
                break
            }
        }
}
