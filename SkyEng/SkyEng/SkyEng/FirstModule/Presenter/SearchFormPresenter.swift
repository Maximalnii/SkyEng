//
//  SearchFormPresenter.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import Foundation

//MARK: - Protocol

protocol SearchFormPresenterInput: AnyObject {
    func didChangeText(_ text: String)
    func gettingWordsAndMeaningsCount() -> Int
    func gettingWordsAndMeanings(index: Int) -> WordsAndMeanings
    func didSelectRowAt(index: Int) -> WordsAndMeanings
    func viewDidLoad()
}

//MARK: - Final class

final class SearchFormPresenter {
    
    //MARK: - Constants
    
    private enum Constants {
        static let mainUrl = "https://dictionary.skyeng.ru/api/public/v1/words/search?search="
    }
    
    //MARK: - Public propertys
    
    weak var view: SearchFormInput?
    var data: [WordsAndMeanings] = []
    
    //MARK: - Private methods
    
    private func gettingImage() {
        gettingData(URL: Constants.mainUrl) { [weak self] result in
            self?.data = result
            DispatchQueue.main.async {
                self?.view?.reloadTableView()
            }
        }
    }
    
    private func gettingData(URL url: String, completion:  @escaping ([WordsAndMeanings]) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            do {
                let converting = try JSONDecoder().decode([WordsAndMeanings].self, from: data)
                completion(converting)
            } catch {
            }
        }
        dataTask.resume()
    }
}

//MARK: - Extentions

extension SearchFormPresenter: SearchFormPresenterInput {
    
    func didChangeText(_ text: String) {
        guard !text.isEmpty else {
            view?.views(isHidden: text.isEmpty)
            return
        }
        
        let url = Constants.mainUrl + text
        gettingData(URL: url) { [weak self] result in
            guard let self = self else { return }
            self.data = result
            DispatchQueue.main.async {
                let isHidden = self.data.isEmpty
                self.view?.views(isHidden: isHidden)
                self.view?.reloadTableView()
            }
        }
    }
    
    func viewDidLoad() {
        let isHidden = data.isEmpty
        view?.views(isHidden: isHidden)
    }
    
    func didSelectRowAt(index: Int) -> WordsAndMeanings {
        data[index]
    }
    
    func gettingWordsAndMeanings(index: Int) -> WordsAndMeanings {
        data[index]
    }
    
    func gettingWordsAndMeaningsCount() -> Int {
        data.count
    }
}
