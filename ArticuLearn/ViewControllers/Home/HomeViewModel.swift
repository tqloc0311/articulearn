//
//  HomeViewModel.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel {
    
    // MARK: Public properties
    
    var numberOfLessons: Int {
        return rxLessons.value.count
    }
    
    func getLesson(at index: Int) -> Lesson? {
        return rxLessons.value[safe: index]
    }
    
    // MARK: Private properties
    
    private let rxLessons = BehaviorRelay<[Lesson]>(value: [])
    private let rxIsSpeaking = BehaviorRelay<Bool>(value: false)
    
    private lazy var textToSpeech: TextToSpeech = {
        let textToSpeech = TextToSpeech()
        textToSpeech.delegate = self
        return textToSpeech
    }()
    
    // MARK: Methods
    
    func transform(input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let error = errorTracker.asDriver()
        
        input.viewWillAppear
            .asObservable()
            .flatMap { [weak self] _ -> Observable<[Lesson]> in
                return self?.fetchLessons().trackError(errorTracker) ?? .empty()
            }
            .map { $0.shuffled() }
        ~> rxLessons
        => disposeBag
        
        let reloadCollectionViewIfNeeded = rxLessons
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let isSpeaking = rxIsSpeaking.asDriver()
        
        return Output(reloadCollectionViewIfNeeded: reloadCollectionViewIfNeeded,
                      isSpeaking: isSpeaking,
                      error: error)
    }
    
    private func fetchLessons() -> Single<[Lesson]> {
        return Single.create { single in
            Task {
                let lessons = await LessonRepository.shared.fetchLessons()
                single(.success(lessons))
            }
            
            return Disposables.create()
        }
    }
    
    // MARK: Public Methods
    
    func startListening(with lesson: Lesson) {
        if textToSpeech.isSpeaking {
            textToSpeech.stop()
        } else {
            textToSpeech.speak(lesson.title + ".\n\n\n" + lesson.content)
        }
    }
    
    func stopSpeaking() {
        textToSpeech.stop()
    }
}

// MARK: Input & Output

extension HomeViewModel {
    struct Input {
        let viewWillAppear: Driver<Void>
    }
    
    struct Output {
        let reloadCollectionViewIfNeeded: Driver<Void>
        let isSpeaking: Driver<Bool>
        let error: Driver<Error>
    }
}

// MARK: TextToSpeechDelegate

extension HomeViewModel: TextToSpeechDelegate {
    func textToSpeechIsSpeaking(isSpeaking: Bool) {
        rxIsSpeaking.accept(isSpeaking)
    }
}
