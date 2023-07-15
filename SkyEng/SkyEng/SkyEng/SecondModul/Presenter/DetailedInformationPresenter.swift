//
//  DetailedInformationPresenter.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import Foundation


protocol DetailedInformationPresenterInput: AnyObject {
}

final class DetailedInformationPresenter  {
    
    weak var view: DetailedInformationInput?
    
}

extension DetailedInformationPresenter: DetailedInformationPresenterInput {
}



