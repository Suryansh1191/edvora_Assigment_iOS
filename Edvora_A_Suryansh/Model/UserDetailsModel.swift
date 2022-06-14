//
//  UserDetailsModel.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import Foundation


struct UserDetailseModel: Codable {
    let stationCode: Int
    let name: String
    let url: String
    
    static func example()->UserDetailseModel {
        let example = UserDetailseModel(stationCode: 0, name: "", url: "")
        return example
    }

    enum CodingKeys: String, CodingKey {
        case stationCode = "station_code"
        case name, url
    }
}

struct UserStoredData {
    static var userData: UserDetailseModel? = nil
    
    static func setdata(UserData: UserDetailseModel){
        UserStoredData.userData = UserData
    }
}


