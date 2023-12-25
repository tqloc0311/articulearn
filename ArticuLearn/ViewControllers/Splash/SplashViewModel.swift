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
            .flatMap { [unowned self] _ in return self.fetchLessons() }
//            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()
        
        return Output(goNext: goNext)
    }
    
    private func fetchLessons() -> Single<Void> {
        return Single.create { single in
            Task {
                let _ = await LessonRepository.shared.fetchLessons()
                single(.success(()))
            }
            
            return Disposables.create()
        }
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
