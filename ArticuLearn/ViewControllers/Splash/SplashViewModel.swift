//
//  SplashViewModel.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import RxSwift
import RxCocoa

class SplashViewModel: ViewModel {
    
    func transform(input: Input) -> Output {
        let goNext = input.trigger
            .asObservable()
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()
        
        return Output(goNext: goNext)
    }
    
}

// MARK: Input & Output

extension SplashViewModel {
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let goNext: Driver<Void>
    }
}
