//
//  UserDefaults.swift
//  testgame2
//
//  Created by Samuel Polgar on 2/5/2022.
////

import Combine
import Foundation

private var cancellables = [String:AnyCancellable]()

extension Published {
    init(wrappedValue value: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            UserDefaults.standard.set(val, forKey: key)
        }
    }
}
