//
//  CoroutineProtocol.swift
//  SwiftCoroutine
//
//  Created by Alex Belozierov on 07.03.2020.
//  Copyright © 2020 Alex Belozierov. All rights reserved.
//

@usableFromInline protocol CoroutineProtocol: class {
    
    typealias State = Coroutine.State
    typealias StackSize = Coroutine.StackSize
    
    var state: State { get }
    
    func resume() throws
    func suspend() throws
    
    func await<T>(_ callback: (@escaping (T) -> Void) -> Void) throws -> T
    
}

extension CoroutineProtocol {
    
    func await<T>(_ callback: (@escaping (T) -> Void) -> Void) throws -> T {
        fatalError()
    }
    
    func performAsCurrent<T>(_ block: () -> T) -> T {
        let wrapper = ThreadCoroutineWrapper.current
        let caller = wrapper.coroutine
        wrapper.coroutine = self
        defer { wrapper.coroutine = caller }
        return block()
    }
    
}
