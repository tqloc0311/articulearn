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
        let configured = input.trigger
            .asObservable()
            .flatMap { [unowned self] _ in self.fetchLessons() }
            .asDriverOnErrorJustComplete()
        
        return Output(configured: configured)
    }
    
    private func fetchLessons() -> Observable<Void> {
        return Observable.create { observer in
            Task {
                do {
                    let _ = try await LessonRepository.shared.fetchLessons()
                    observer.onNext(())
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
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
        let configured: Driver<Void>
    }
}
