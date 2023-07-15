//
//  SearchFormModel.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int
    let text: String
    let meanings: [Meaning]
}

// MARK: - Meaning
struct Meaning: Codable {
    let id: Int
    let partOfSpeechCode: String
    let translation: Translation
    let previewURL, imageURL, transcription, soundURL: String

    enum CodingKeys: String, CodingKey {
        case id, partOfSpeechCode, translation
        case previewURL = "previewUrl"
        case imageURL = "imageUrl"
        case transcription
        case soundURL = "soundUrl"
    }
}

// MARK: - Translation
struct Translation: Codable {
    let text, note: String
}

