//
//  AlamofireService.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import Alamofire
import SwiftUI



class AlamofireReq: ObservableObject{
        
    func Req<T: Decodable>(_ type: T.Type , Curl: String ,body: Any, method: HTTPMethod, completionHandler: @escaping (Result<T, Error>)->Void){

        guard let url = URL(string: Curl) else {
            return;
        }
        
        AF.request(url, method: method, parameters: body as? Parameters, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: type.self) {
            response in
                
                print(response.debugDescription)
                
            if let data = response.data {
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(type, from: data)
                    completionHandler(Result.success(result))
                }catch{
                    print(error)
                    completionHandler(Result.failure(error))
                }
            }
            if let err = response.error {
                completionHandler(Result.failure(err))
                print(err)
            }
        }
    }
    
}
