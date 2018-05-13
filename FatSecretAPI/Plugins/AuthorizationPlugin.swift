//
//  AuthorizationPlugin.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 13/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import Moya

internal struct AuthorizationPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let endpoint = Endpoint(url: target.baseURL.absoluteString, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
        
        let query = sortedPercentEncodedQuery(fromEndpoint: endpoint)
        let signatureString = signatureBaseString(fromElements: target.method.rawValue, target.baseURL.absoluteString, query)
        let oauthSignature = oauthSignatureForSignatureBaseString(signatureString)
        let requestParams = requestParameters(forEndpoint: endpoint, withOAuthSignature: oauthSignature)
        let updatedEndpoint = endpoint.replacing(task: .requestParameters(parameters: requestParams, encoding: URLEncoding.queryString))
        
        do {
            return try updatedEndpoint.urlRequest()
        } catch {
            fatalError("Could not create URLRequest")
        }
    }
}

internal extension AuthorizationPlugin {
    func sortedPercentEncodedQuery(fromEndpoint endpoint: Endpoint) -> String {
        guard case let .requestParameters(parameters, _) = endpoint.task else {
            fatalError("Unsupported Task type, .requestParameters Task is required")
        }
        
        let sortedParameters = Dictionary(uniqueKeysWithValues: parameters.sorted(by: { $0.key < $1.key }))
        let updatedEndpoint = endpoint.replacing(task: .requestParameters(parameters: sortedParameters, encoding: URLEncoding.queryString))
        
        guard let encodedQuery = URLComponents(string: updatedEndpoint.url)?.percentEncodedQuery else {
            fatalError("Could not create URL from provided string")
        }
        
        return encodedQuery
    }
    
    func signatureBaseString(fromElements elements: String...) -> String {
        var signatureString = ""
        elements.enumerated().forEach { (index, element) in
            if index == elements.endIndex - 1 {
                signatureString.append(element)
            } else {
                signatureString.append(element.appending("&"))
            }
        }
        return signatureString
    }
    
    func requestParameters(forEndpoint endpoint: Endpoint, withOAuthSignature signature: String) -> [String: Any] {
        guard case var .requestParameters(parameters, _) = endpoint.task else {
            fatalError("Unsupported Task type, .requestParameters Task is required")
        }
        
        parameters["oauth_signature"] = signature
        return parameters
    }
    
    func oauthSignatureForSignatureBaseString(_ string: String) -> String {
        fatalError("MISSING IMPLEMENTATION OF HMAC SHA1 ALGORITHM")
    }

}
