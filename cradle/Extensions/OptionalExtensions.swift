//
//  OptionalExtensions.swift
//  cradle
//
//  Created by Damian Kolasiński on 03/05/2018.
//  Copyright © 2018 DamianKolasinski. All rights reserved.
//

import Foundation

extension Optional {
    
    func orDefault(_ default: @autoclosure () -> Wrapped) -> Wrapped {
        switch self {
        case .some(let wrapped):
            return wrapped
        case .none:
            return `default`()
        }
    }
    
    var isSome: Bool {
        switch self {
        case .some :
            return true
        case .none:
            return false
        }
    }
    
    var isNone: Bool {
        return !isSome
    }
}
