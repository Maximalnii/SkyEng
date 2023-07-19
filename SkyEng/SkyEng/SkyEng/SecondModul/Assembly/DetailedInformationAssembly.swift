//
//  DetailedInformationAssembly.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import UIKit

final class AssemblyDetailedInformation {
    
    static func assembly(with word: WordsAndMeanings) -> UIViewController {
        let presenter = DetailedInformationPresenter()
        let view = DetailedInformationViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
