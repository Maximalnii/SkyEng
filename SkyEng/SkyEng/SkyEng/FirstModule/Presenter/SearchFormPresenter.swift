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
    func gettingWelcomeElementsCount() -> Int
    func gettingWelcomeElements(index: Int) -> WelcomeElement
    func didSelectRowAt(index: Int) -> WelcomeElement
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
    var data = [WelcomeElement]()
    
    //MARK: - Private methods
    
    private func gettingImage() {
        gettingData(URL: Constants.mainUrl) { [weak self] result in
            self?.data = result
            DispatchQueue.main.async {
                self?.view?.reloadTableView()
            }
        }
    }
    
    private func gettingData(URL url: String, completion:  @escaping ([WelcomeElement]) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data, response, error in
            guard let data = data else {
                print("<<< \(error)")
                return
            }
            do {
                let parsingData = try JSONDecoder().decode([WelcomeElement].self, from: data)
                completion(parsingData)
            } catch {
                print("parsing Error")
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
            print("!!! \(result)")
        }
    }
    
    func viewDidLoad() {
        let isHidden = data.isEmpty
        view?.views(isHidden: isHidden)
    }
    
    func didSelectRowAt(index: Int) -> WelcomeElement {
        data[index]
    }
    
    func gettingWelcomeElements(index: Int) -> WelcomeElement {
        data[index]
    }
    
    func gettingWelcomeElementsCount() -> Int {
        data.count
    }
}
