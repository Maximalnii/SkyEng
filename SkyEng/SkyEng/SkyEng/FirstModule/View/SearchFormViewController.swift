//
//  SearchFormViewController.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import UIKit

protocol SearchFormInput: AnyObject {
    
}

class SearchFormViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
    }
    
    //MARK: - UI
    
    
    
    //MARK: - Private propertys
    
    private var presenter: SearchFormPresenterInput?
    
    init(presenter: SearchFormPresenterInput) {
        
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}


//MARK: - Extentions


extension SearchFormViewController: SearchFormInput {
    
}

