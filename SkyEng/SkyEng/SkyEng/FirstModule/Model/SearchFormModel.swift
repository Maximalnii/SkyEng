//
//  SearchFormModel.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

// MARK: - IncomingData

struct IncomingData: Decodable {
    let results: [WordsAndMeanings]
}

// MARK: - WordsAndMeanings

struct WordsAndMeanings: Decodable {
    let text: String?
    let meanings: [Meaning]?
}

// MARK: - Meaning

struct Meaning: Decodable {
    let translation: Translation?
    let previewURL: String?
    
    enum CodingKeys: String, CodingKey {
        case  translation
        case previewURL = "previewUrl"
    }
}

// MARK: - Translation

struct Translation: Decodable {
    let text: String?
}


