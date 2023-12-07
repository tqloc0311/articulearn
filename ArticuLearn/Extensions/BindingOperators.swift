//
//  BindingOperators.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Two way binding shorthand

infix operator <~> : DefaultPrecedence

public func <~><T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property.bind(to: relay)
    
    return Disposables.create(bindToUIDisposable, bindToRelay)
}

public func <~><T: Comparable>(a: BehaviorRelay<T>, b: BehaviorRelay<T>) -> Disposable {
    let bindAtoB = a.observeOn(MainScheduler.asyncInstance).distinctUntilChanged().bind(to: b)
    let bindBtoA = b.observeOn(MainScheduler.asyncInstance).distinctUntilChanged().bind(to: a)
    
    return Disposables.create(bindAtoB, bindBtoA)
}

extension Optional: Comparable where Wrapped: Comparable {
    public static func < (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool {
        switch (lhs, rhs) {
        case (.some(let leftValue), .some(let rightValue)):
            return leftValue < rightValue
        case (.none, _):
            return true
        default:
            return false
        }
    }
}


public func <~><T>(relay: BehaviorRelay<T>, property: ControlProperty<T>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property.bind(to: relay)
    
    return Disposables.create(bindToUIDisposable, bindToRelay)
}

// MARK: - One way binding shorthand

infix operator ~>: DefaultPrecedence

/// Observale
public func ~><T, R>(source: Observable<T>, binder: (Observable<T>) -> R) -> R {
    return source.bind(to: binder)
}

public func ~><T>(source: Observable<T>, binder: Binder<T>) -> Disposable {
    return source.bind(to: binder)
}

public func ~><T>(source: Observable<T>, relay: BehaviorRelay<T>) -> Disposable {
    return source.bind(to: relay)
}

public func ~><T>(source: BehaviorRelay<T>, relay: BehaviorRelay<T>) -> Disposable {
    return source.bind(to: relay)
}

public func ~><T>(source: Observable<T>, relay: PublishRelay<T>) -> Disposable {
    return source.bind(to: relay)
}

public func ~><T>(source: PublishRelay<T>, relay: PublishRelay<T>) -> Disposable {
    return source.bind(to: relay)
}

/// Single
public func ~><T>(source: Single<T>, relay: BehaviorRelay<T>) -> Disposable {
    return source.subscribe(onSuccess: relay.accept)
}

public func ~><T>(source: Single<T>, relay: PublishRelay<T>) -> Disposable {
    return source.subscribe(onSuccess: relay.accept)
}

/// Driver
public func ~><T>(source: Driver<T>, relay: BehaviorRelay<T>) -> Disposable {
    return source.drive(onNext: relay.accept)
}

public func ~><T>(source: Driver<T>, binder: Binder<T>) -> Disposable {
    return source.drive(onNext: binder.onNext)
}

public func ~><T>(source: Observable<T>, property: ControlProperty<T>) -> Disposable {
    return source.bind(to: property)
}

public func ~><T>(source: BehaviorRelay<T>, relay: PublishRelay<T>) -> Disposable {
    return source.bind(to: relay)
}

/// BehaviorRelay
public func ~><T>(relay: BehaviorRelay<T>, observer: Binder<T>) -> Disposable {
    return relay.bind(to: observer)
}

public func ~><T>(relay: BehaviorRelay<T>, property: ControlProperty<T>) -> Disposable {
    return relay.bind(to: property)
}

public func ~><T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    return relay.bind(to: property)
}

/// ControlEvent
public func ~><T>(event: ControlEvent<T>, relay: BehaviorRelay<T>) -> Disposable {
    return event.bind(to: relay)
}

// MARK: - Add to dispose bag shorthand

precedencegroup DisposablePrecedence {
    lowerThan: DefaultPrecedence
}

infix operator =>: DisposablePrecedence

public func =>(disposable: Disposable?, bag: DisposeBag?) {
    if let d = disposable, let b = bag {
        d.disposed(by: b)
    }
}
