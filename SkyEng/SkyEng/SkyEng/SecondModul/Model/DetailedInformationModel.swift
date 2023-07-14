////
////  DetailedInformationModel.swift
////  SkyEng
////
////  Created by Максим Жуков on 14.07.2023.
////
//
//import Foundation
//
//// MARK: - WelcomeElement
//struct WelcomeElement: Codable {
//    let id: String
//    let wordID, difficultyLevel: Int
//    let partOfSpeechCode, welcomePrefix, text, soundURL: String
//    let transcription: String
//    let properties: Properties
//    let updatedAt, mnemonics: String
//    let translation: Translation
//    let images: [Image]
//    let definition: Definition
//    let examples: [Definition]
//    let meaningsWithSimilarTranslation: [MeaningsWithSimilarTranslation]
//    let alternativeTranslations: [AlternativeTranslation]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case wordID = "wordId"
//        case difficultyLevel, partOfSpeechCode
//        case welcomePrefix = "prefix"
//        case text
//        case soundURL = "soundUrl"
//        case transcription, properties, updatedAt, mnemonics, translation, images, definition, examples, meaningsWithSimilarTranslation, alternativeTranslations
//    }
//}
//
//// MARK: - AlternativeTranslation
//struct AlternativeTranslation: Codable {
//    let text: String
//    let translation: Translation
//}
//
//// MARK: - Translation
//struct Translation: Codable {
//    let text, note: String
//}
