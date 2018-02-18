//
//  ErrorHandleable.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import Foundation

public typealias HandleAction<T> = (T) throws -> ()

public protocol ErrorHandleable: class {
    func `throw`(_: Error, finally: @escaping (Bool) -> Void)
    func `catch`(action: @escaping HandleAction<Error>) -> ErrorHandleable
}


