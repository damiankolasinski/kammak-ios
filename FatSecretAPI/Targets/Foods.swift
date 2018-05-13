//
//  Foods.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 13/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import Moya

enum Foods {
    
    /// Returns detailed nutritional information for the specified food.
    case get(id: Int)
}

extension Foods: TargetType {
    var baseURL: URL {
        return FatSecretApi.baseURL
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["": ""], encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
