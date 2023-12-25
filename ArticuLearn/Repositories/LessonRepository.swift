//
//  LessonRepository.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation

protocol LessonProvider {
    func fetchLessons() async -> [Lesson]
}

class LocalLessonProvider: LessonProvider {
    func fetchLessons() async -> [Lesson] {
        if let path = Bundle.main.path(forResource: "lessons", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Array<[String: AnyObject]> {
                    var lessons: [Lesson] = []
                    
                    for record in jsonResult {
                        let id = record["_id"] as? String ?? ""
                        let title = record["title"] as? String ?? ""
                        let content = record["story"] as? String ?? ""
                        
                        let lesson = Lesson(id: id, title: title, content: content)
                        lessons.append(lesson)
                    }
                    
                    return lessons
                } else {
                    Log.log(type: .error, message: "The data is not in valid format.")
                    return []
                }
            } catch {
                Log.log(type: .error, message: error.localizedDescription)
                return []
            }
        } else {
            Log.log(type: .error, message: "The `lessons.json` file does not exist")
            return []
        }
    }
}

class LessonRepository {
    
    static let shared = LessonRepository()
    
    private let lessonProvider: LessonProvider
    private(set) var lessons: [Lesson] = []
    
    init(lessonProvider: LessonProvider = LocalLessonProvider()) {
        self.lessonProvider = lessonProvider
    }
    
    func fetchLessons() async -> [Lesson] {
        lessons = await lessonProvider.fetchLessons()
        return lessons
    }
}
