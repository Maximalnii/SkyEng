//
//  SearchFormAssembly.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import UIKit

final class AssemblySearchForm {
    
    static func assemebly() -> UIViewController {
        let presenter = SearchFormPresenter()
        let view = SearchFormViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
