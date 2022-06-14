//
//  File.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import Foundation

class UserDataVM: ObservableObject{
    let alamofireReq = AlamofireReq()
    
    func InitUserdata(complition: @escaping (Bool) -> Void) {
       
            let encodingDataModel = UserDetailseModel.example()
        alamofireReq.Req(type(of: encodingDataModel), Curl: "\(URLModel().userInfo)", body: "", method: .get) { responce in
                switch responce{
                case .failure(let error):
                    print(error)
                    complition(false)
                case .success(let successData):
                    UserStoredData.setdata(UserData: successData)
                    complition(true)
                }
            }
    }
}
