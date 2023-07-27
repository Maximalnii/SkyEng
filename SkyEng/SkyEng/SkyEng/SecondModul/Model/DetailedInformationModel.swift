//
//  DetailedInformationModel.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//



import Foundation


// MARK: - Welcome

struct WordDetails: Decodable {
    let difficultyLevel: Int?
    let partOfSpeechCode: String?
    let text: String?
    let soundUrl: String?
    let transcription: String?
    let translation: Taranslation
    let images: [Image]
    let definition: Definition
    let examples: [Definition]
}

// MARK: - Definition
struct Definition: Decodable {
    let text: String?
    let soundUrl: String?
}

// MARK: - Image
struct Image: Decodable {
    let url: String?
}

// MARK: - Translation
struct Taranslation: Decodable {
    let text: String?
    let note: String?
}


