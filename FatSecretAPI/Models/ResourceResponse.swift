//
//  ResourceResponse.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 13/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import Foundation

public enum ResourceResponseSource {
    case cache
    case network
}

public struct ResourceResponse<T: Decodable> {
    public var item: T?
    public var error: Error?
    public var source: ResourceResponseSource
    
    public static func wrap(item: T? = nil, error: Error? = nil, source: ResourceResponseSource) -> ResourceResponse<T> {
        return ResourceResponse(item: item, error: error, source: source)
    }
}

public struct ResourceCollectionResponse<T: Decodable> {
    public var items: [T]?
    public var error: Error?
    public let source: ResourceResponseSource
    
    public static func wrap(items: [T]? = nil, error: Error? = nil, source: ResourceResponseSource) -> ResourceCollectionResponse<T> {
        return ResourceCollectionResponse(items: items, error: error, source: source)
    }
}
