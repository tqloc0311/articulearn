//
//  Lesson.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation

struct Lesson: Decodable {
    let id: String
    let title: String
    let content: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "_id"
        case title
        case content = "story"
    }
}
