//
//  CustomerRiderDetailsModel.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import Foundation

struct RiderExtraInfoModel: Codable, Identifiable{
    var id = UUID()
    var riderDetails: RiderDetailsModel
    var stationsClosestToUser: Int
    var DifferenceUserDriverStation: Int
    
    static func example() -> RiderExtraInfoModel {
        let example = RiderExtraInfoModel(riderDetails: RiderDetailsModel.example(), stationsClosestToUser: 0, DifferenceUserDriverStation: 0)
        return example
    }
    
}

struct riderStateCityInfoModel: Codable, Hashable, Equatable, Identifiable{
    var id = UUID()
    var state: String
    var city: [String]
}

struct riderStateCityInfoStore{
    static var stateCityData: [riderStateCityInfoModel] = [riderStateCityInfoModel(state: "", city: [""])]
    
    static func getData(data: [riderStateCityInfoModel]){
        stateCityData = data
    }
}
