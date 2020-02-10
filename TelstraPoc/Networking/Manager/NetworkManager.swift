//
//  NetworkManager.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noResposeData
    case unableToDecode
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static let productAPIKey = ""
    let router = Router<ProductApi>()
    
    func getNewFacts(page: Int, completion: @escaping (_ movie: ProductList?,_ error: String?)->()){
        
        router.request(.newFacts(page: page)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noResposeData.rawValue)
                        return
                    }
                    if let dict = self.convertToDictionary(text: String(decoding: responseData, as: UTF8.self)){
                        ObjectMapper.objectmapper.map(dict: dict)
                        DispatchQueue.main.async{
                            completion(ObjectMapper.objectmapper.productList , nil)
                        }
                    }else{
                        DispatchQueue.main.async{
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                        
                    }
                case .failure(let networkFailureError):
                    
                    DispatchQueue.main.async{
                        completion(nil, networkFailureError)
                    }
                    
                }
            }
        }
    }
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
