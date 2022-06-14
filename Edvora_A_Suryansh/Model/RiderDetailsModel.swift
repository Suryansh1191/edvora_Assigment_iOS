//
//  RiderDetailsModel.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import Foundation


struct RiderDetailsModel: Codable, Identifiable {
    var id: Int
    let originStationCode: Int
    let stationPath: [Int]
    let destinationStationCode: Int
    let date: String
    let mapURL: String?
    let state, city: String
    
    
    static func example() -> RiderDetailsModel{
        let example = RiderDetailsModel(id: 0, originStationCode: 0, stationPath: [0], destinationStationCode: 0, date: "", mapURL: "", state: "", city: "")
        return example
    }

    enum CodingKeys: String, CodingKey {
        case id
        case originStationCode = "origin_station_code"
        case stationPath = "station_path"
        case destinationStationCode = "destination_station_code"
        case date
        case mapURL = "map_url"
        case state, city
    }
}


