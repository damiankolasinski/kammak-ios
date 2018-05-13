//
//  FatSecretApi.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 12/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxMoya

struct FatSecretApi {
    
    static var baseURL: URL {
        return URL(string: "http://platform.fatsecret.com/rest/server.api")!
    }
    
    private var provider: MoyaProvider<MultiTarget> = {
        let authorizationplugin = AuthorizationPlugin()
        return MoyaProvider<MultiTarget>(plugins: [authorizationplugin], trackInflights: false)
    }()
}

internal extension FatSecretApi {
    func requestFromEndpoint(_ endpoint: MultiTarget) -> Observable<Response> {
        return provider.rx.request(endpoint).asObservable()
    }
}
