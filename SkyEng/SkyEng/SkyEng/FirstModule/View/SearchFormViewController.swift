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
        static let rightBarButtonTitle = "Готово"
    }
    
    //MARK: - UI
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 50
        searchBar.returnKeyType = .done
        searchBar.becomeFirstResponder()
        searchBar.placeholder = "Введите слово"
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    //MARK: - Private propertys
    
    private var presenter: SearchFormPresenterInput?
    
    //MARK: - Init
    
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
        viewAndNavBarSetup()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func viewAndNavBarSetup() {
        view.backgroundColor = .white
        var leftNavBarButton = UIBarButtonItem(customView:searchBar)
        navigationItem.leftBarButtonItem = leftNavBarButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.rightBarButtonTitle, style: .done, target: self, action:  #selector(doneBtn))
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: 295),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    //MARK: - Public methods
    
    @objc func doneBtn() {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
}


//@objc func perfomSecondController() {
//    let secondVC = BirthdayViewController()
//    navigationController?.pushViewController(secondVC, animated: true)
//}

//MARK: - Extentions

extension SearchFormViewController: SearchFormInput {
    
}

extension SearchFormViewController: UISearchBarDelegate {
    
}
