//
//  SearchFormModel.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import Foundation

// MARK: - WordsAndMeanings

struct WordsAndMeanings: Decodable {
    let text: String?
    let meanings: [Meaning]?
}

// MARK: - Meaning

struct Meaning: Decodable {
    let id: Int
    let translation: Translation?
    let previewUrl: String?
}

// MARK: - Translation

struct Translation: Decodable {
    let text: String?
}


