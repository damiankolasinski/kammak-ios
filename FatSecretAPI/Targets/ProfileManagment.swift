//
//  ProfileManagment.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 12/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import Foundation
import Moya

/// Enum representing FatSecret API endpoints related to profile managment
enum ProfileManagment {
    
    /// Creates new user profile
    case create
}

extension ProfileManagment: TargetType {
    var baseURL: URL {
        return FatSecretApi.baseURL
    }
    
    var path: String {
        return "placeholder"
    }
    
    var method: Moya.Method {
        return .post
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
