//
//  DetailedInformationPresenter.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import Foundation
import AVFoundation

//MARK: - Protocol

protocol DetailedInformationPresenterInput: AnyObject {
    func viewDidLoad()
    func play(url: NSURL)
}

//MARK: - Final class

final class DetailedInformationPresenter  {
    
    //MARK: - Constants
    
    private enum Constants {
        static let mainURL = "https://dictionary.skyeng.ru/api/public/v1/meanings?ids="
        static let transcriptionText = "Transcription: /"

    }
    
    //MARK: - Public propertys
    
    weak var view: DetailedInformationInput?
    
    //MARK: - Private propertys
    
    private lazy var player = AVPlayer()
    private let id: Int
    private var wordDetails: [WordDetails] = []
    
    //MARK: - Init
    
    init(with id: Int) {
        self.id = id
    }
    
    //MARK: - Private methods
    
    private func gettingDetailedData(URL url: String, completion:  @escaping ([WordDetails]) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            do {
                let detailedWordArray = try JSONDecoder().decode([WordDetails].self, from: data)
                completion(detailedWordArray)
            } catch {
            }
        }
        dataTask.resume()
    }
}

//MARK: - Extention

extension DetailedInformationPresenter: DetailedInformationPresenterInput {
    
    func play(url: NSURL) {
        let playerItem = AVPlayerItem(url: url as URL)
        self.player = AVPlayer(playerItem: playerItem)
        player.volume = 1.0
        player.play()
    }
    
    func viewDidLoad() {
        let correctURL = Constants.mainURL + "\(id)"
        gettingDetailedData(URL: correctURL) { [weak self] result in
            guard let self = self else { return }
            self.wordDetails = result
            DispatchQueue.main.async {
                guard let result = result.first else { return }
                
                let transcription = "\(Constants.transcriptionText) \(result.transcription ?? "") /"
                let difficultyLevel = result.difficultyLevel ?? 1
                
                let prepareResult = WordDetails(
                    difficultyLevel: difficultyLevel,
                    text: result.text,
                    soundUrl: result.soundUrl,
                    transcription: transcription,
                    translation: result.translation,
                    images: result.images,
                    definition: result.definition,
                    examples: result.examples
                )
                
                self.view?.update(with: prepareResult, delegate: self)
            }
        }
    }
}

extension DetailedInformationPresenter: ExampleViewProtocol {
    
    func sendUrl(url: String?) {
        guard let url = NSURL(string: url ?? "") else { return }
        play(url: url)
    }
}
