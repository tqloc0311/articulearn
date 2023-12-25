//
//  LessonRepository.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation

protocol LessonProvider {
    func fetchLessons() async throws -> [Lesson]
}

class LocalLessonProvider: LessonProvider {
    func fetchLessons() async throws -> [Lesson] {
        guard let path = Bundle.main.path(forResource: "lessons", ofType: "json") else {
            throw LessonProviderError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            return try decoder.decode([Lesson].self, from: data)
        } catch {
            throw LessonProviderError.jsonParsingError(error)
        }
    }
}

enum LessonProviderError: Error {
    case fileNotFound
    case jsonParsingError(Error)
}

class LessonRepository {
    static let shared = LessonRepository()

    private let lessonProvider: LessonProvider
    private(set) var lessons: [Lesson] = []

    init(lessonProvider: LessonProvider = LocalLessonProvider()) {
        self.lessonProvider = lessonProvider
    }

    func fetchLessons() async throws -> [Lesson] {
        lessons = try await lessonProvider.fetchLessons()
        return lessons
    }
}
