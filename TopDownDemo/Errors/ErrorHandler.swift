//
//  ErrorHandler.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import Foundation


public class ErrorHandler: ErrorHandleable {
    private var parent: ErrorHandler?
    private let action: HandleAction<Error>
    
    convenience init(action: @escaping HandleAction<Error> = { throw $0 }) {
        self.init(action: action, parent: nil)
    }
    
    private init(action: @escaping HandleAction<Error>, parent: ErrorHandler? = nil) {
        self.action = action
        self.parent = parent
    }
    
    public func `throw`(_ error: Error, finally: @escaping (Bool) -> Void) {
        `throw`(error, previous: [], finally: finally)
    }
    
    private func `throw`(_ error: Error, previous: [ErrorHandler], finally: ((Bool) -> Void)? = nil) {
        if let parent = parent {
            parent.`throw`(error, previous: previous + [self], finally: finally)
            return
        }
        serve(error, next: AnyCollection(previous.reversed()), finally: finally)
    }
    
    private func serve(_ error: Error, next: AnyCollection<ErrorHandler>, finally: ((Bool) -> Void)? = nil) {
        do {
            try action(error)
            finally?(true)
        } catch {
            if let nextHandler = next.first {
                nextHandler.serve(error, next: next.dropFirst(), finally: finally)
            } else {
                finally?(false)
            }
        }
    }
    
    public func `catch`(action: @escaping HandleAction<Error>) -> ErrorHandleable {
        return ErrorHandler(action: action, parent: self)
    }
}
