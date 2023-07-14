//
//  SearchFormPresenter.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import Foundation

protocol SearchFormPresenterInput: AnyObject {
}

final class SearchFormPresenter {
    
    weak var view: SearchFormInput?
    
}

extension SearchFormPresenter: SearchFormPresenterInput {
}
