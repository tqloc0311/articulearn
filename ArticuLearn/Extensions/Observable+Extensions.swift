//
//  Observable+Extensions.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func unwrap<T>() -> Observable<T> where Element == T? {
        return self.filter { $0 != nil }.map { $0! }
    }
    
    func asOptional<T>() -> Observable<T?> where Element == T {
        return self.map { item -> T? in return item }
    }
}
