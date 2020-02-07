//
//  ProductEndPoint.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum ProductApi {
    case newFacts(page:Int)
}

extension ProductApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .newFacts:
            return "facts.json"
        }
    }
    
    var httpMethod: HTTPMethod {
         return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newFacts( _):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
         return nil
    }
    
    
    
}
