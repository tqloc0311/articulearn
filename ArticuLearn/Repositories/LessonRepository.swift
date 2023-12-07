//
//  LessonRepository.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation

enum LessonFilter {
    case all
    case byLevelId(levelId: Int)
}

class LessonRepository {
    
    static let shared = LessonRepository()
    
    func fetchLevels() -> [Level] {
        return generateDummyLevels()
    }
    
    func fetchLesson(filter: LessonFilter) async -> [Lesson] {
        return generateDummyLessons()
    }
}

func generateDummyLessons() -> [Lesson] {
    let lessonContent = ["Introduction", "Greetings", "Daily Activities", "Family", "Travel", "Shopping", "Food", "Weather"]
    let levels = generateDummyLevels()
    
    var lessons: [Lesson] = []
    
    for (index, content) in lessonContent.enumerated() {
        let lesson = Lesson(id: index + 1, content: content, levelIds: [levels.randomElement()!.id])
        lessons.append(lesson)
    }
    
    return lessons
}

func generateDummyLevels() -> [Level] {
    let levelTitles = ["A1", "A2", "B1", "B2", "C1", "C2"]
    
    var levels: [Level] = []
    
    for (index, title) in levelTitles.enumerated() {
        let level = Level(id: index + 1, title: title)
        levels.append(level)
    }
    
    return levels
}
