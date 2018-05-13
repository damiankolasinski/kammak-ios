//
//  FoodsProvider.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 13/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import RxSwift

internal class FoodsProvider: Provider {
    
    let networkingScheduler: ConcurrentDispatchQueueScheduler
    let api: FatSecretApi
    
    init(api: FatSecretApi) {
        self.api = api
        self.networkingScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    }
}

internal extension FoodsProvider {
    func getFoodForId(_ id: Int) -> Observable<ResourceResponse<Food>> {
        return provide(Foods.get(id: id))
    }
}

