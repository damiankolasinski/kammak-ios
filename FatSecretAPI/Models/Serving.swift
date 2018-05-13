//
//  Serving.swift
//  FatSecretAPI
//
//  Created by Damian Kolasiński on 13/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import Foundation

public struct Serving: Decodable {
    public let id: Int
    public let description: String
    public let amount: Double
    public let metricUnit: String
}
