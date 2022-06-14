//
//  NearestRiderVM.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import Foundation


class NearestRiderVM: ObservableObject {
    @Published var nearestRiderArrya: [RiderExtraInfoModel] = [RiderExtraInfoModel.example()]
    @Published var isLoading = true
    let alamofireReq = AlamofireReq()
    
    func getRiderDetails(complition: @escaping (Bool) -> Void) {
        let encodingDataModel = [RiderDetailsModel.example()]
        alamofireReq.Req(type(of: encodingDataModel), Curl: "\(URLModel().riderInfo)", body: "", method: .get) { responce in
            switch responce{
            case .failure(let error):
                print(error)
                complition(false)
            case .success(let successData):
                self.sortNearestDriver(data: successData) { sortedData in
                    self.nearestRiderArrya = sortedData
                    self.isLoading = false
                }
                complition(true)
            }
        }
    }
    
    func sortNearestDriver(data: [RiderDetailsModel], complition: @escaping (([RiderExtraInfoModel])) -> Void){
        getDirverWithUserStationCode(riderDetails: data) { riderInfo in
            let sorted = riderInfo.sorted(by:
                                            {(first: RiderExtraInfoModel, second: RiderExtraInfoModel) -> Bool in
                first.DifferenceUserDriverStation < second.DifferenceUserDriverStation
            })
            print(sorted)
            complition(sorted)
        }
    }
    
    func getDirverWithUserStationCode(riderDetails: [RiderDetailsModel], complition: @escaping (([RiderExtraInfoModel]) -> Void)){
        var riderExtaInfoList: [RiderExtraInfoModel]? = nil
        var stateCityInfo: [riderStateCityInfoModel]? = nil
        let userStation = UserStoredData.userData?.stationCode ?? 0
        for i in riderDetails {
            
            // adding info for sorting
            let closestStation = getClosestStation(arrayInt: i.stationPath , target: userStation)
            let stationDifference = abs(closestStation - userStation)
            if riderExtaInfoList == nil {
                riderExtaInfoList = [RiderExtraInfoModel(riderDetails: i, stationsClosestToUser: closestStation, DifferenceUserDriverStation: stationDifference)]
            }else{
                riderExtaInfoList?.append(RiderExtraInfoModel(riderDetails: i, stationsClosestToUser: closestStation, DifferenceUserDriverStation: stationDifference))
            }
            
            //state and city
            if stateCityInfo != nil {
                var isStatePeresent = false
                stateLoop: for var j in stateCityInfo! {
                    if j.state == i.state {
                        isStatePeresent = true
                        var isCityPresent = false
                        cityLoop: for k in j.city {
                            if k == i.city{
                                isCityPresent = true
                                break cityLoop
                            }
                        }
                        if !isCityPresent { j.city = j.city + [(i.city )] } //becaus append will not work here }
                        break stateLoop
                    }
                }
                if !isStatePeresent { stateCityInfo?.append(riderStateCityInfoModel(state: i.state , city: [(i.city )])) }
                
            }else{
                stateCityInfo = [riderStateCityInfoModel(state: i.state , city: [(i.city )])]
            }
        }
        //state city DeBug Code
            //        var state: [String] = [""]
            //        var city: [[String]] = [[""]]
            //        for i in stateCityInfo! {
            //            state.append(i.state)
            //            city.append(i.city)
            //        }
            //        for i in state {
            //            print(i)
            //        }
            //        print(";asdjkflkasdjf")
            //        for i in city {
            //            print(i)
            //        }
                    //riderStateCityInfo.setdata(data: stateCityInfo)
        riderStateCityInfoStore.getData(data: stateCityInfo!) //forecly unwrapping because for loop allwas going to declarte it 
        complition(riderExtaInfoList!)
    }
    
    func getClosestStation(arrayInt: [Int], target: Int) -> Int {
        let arrayCount = arrayInt.count
        var left = 0
        var right = arrayCount - 1
        while (left <= right) {
            let mid = left + (right - left) / 2;
                if (arrayInt[mid] == target) {
                  return arrayInt[mid];
                } else if (arrayInt[mid] < target) {
                  left = mid + 1;
                } else {
                  right = mid - 1;
                }
        }
        var leftAMin: Int?
        var rightAMin: Int?
        if ( 0 <= left && left < arrayCount-1 ){
            leftAMin = abs(arrayInt[left] - arrayInt[left+1])
        }else if (0 <= right-1 && right < arrayCount){
            rightAMin = abs(arrayInt[right] - arrayInt[right-1])
        }
        if leftAMin == nil && rightAMin != nil {
            return rightAMin!
        }else if rightAMin == nil && leftAMin != nil {
            return leftAMin!
        }else{
            return min(leftAMin!, rightAMin!)

        }

    }
}
