//
//  Provider.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 13/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import RxSwift
import Moya

internal protocol Provider {
    var api: FatSecretApi { get }
    var networkingScheduler: ConcurrentDispatchQueueScheduler { get }
}

internal extension Provider {
    func provide<T, U: TargetType>(_ endpoint: U) -> Observable<ResourceResponse<T>> {
        return api.requestFromEndpoint(MultiTarget(endpoint))
            .map { (response) -> ResourceResponse<T> in
                do {
                    let item = try JSONDecoder().decode(T.self, from: response.data)
                    return .wrap(item: item, source: .network)
                } catch let error {
                    fatalError("\(error) - failed to serialize response")
                }
            }
            .subscribeOn(networkingScheduler)
            .observeOn(MainScheduler.instance)
    }
    
    func provide<T, U: TargetType>(_ endpoint: U) -> Observable<ResourceCollectionResponse<T>> {
        return api.requestFromEndpoint(MultiTarget(endpoint))
            .map { (response) -> ResourceCollectionResponse<T> in
                do {
                    let items = try JSONDecoder().decode([T].self, from: response.data)
                    return .wrap(items: items, source: .network)
                } catch let error {
                    fatalError("\(error) - failed to serialize response")
                }
            }
            .subscribeOn(networkingScheduler)
            .observeOn(MainScheduler.instance)
    }
}
