//
//  User.swift
//  H.E.R.U.MADURAPPERUMA - COBSCCOMP191P-020
//
//  Created by Ruhith on 6/27/1399 AP.
//  Copyright © 1399 NIBM. All rights reserved.
//

import CoreLocation

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let role: String
    var location: CLLocation?
    let uid: String
    let temperature: String
    var surveyResult: Int
    let index: String
    let country: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.role = dictionary["role"] as? String ?? ""
        self.temperature = dictionary["temperature"] as? String ?? "0"
        self.surveyResult = dictionary["surveyResult"] as? Int ?? 0
        self.index = dictionary["index"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? ""
    }
}
