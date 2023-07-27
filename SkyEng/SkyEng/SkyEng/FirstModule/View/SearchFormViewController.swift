//
//  SearchFormViewController.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import UIKit

//MARK: - Protocol

protocol SearchFormInput: AnyObject {
    func reloadTableView()
    func views(isHidden: Bool)
    func changeMainView(imageName: String, lableText: String)
}

//MARK: - Final class

class SearchFormViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let rightBarButtonTitle = "Готово"
        static let searchBarPlaceholder = "Введите слово"
        static let mainImageName = "mainImage"
        static let mainLabelText = "Ищите слова и списки слов, добавляйте на изучение"
        static let indentifire = "customCell"
    }
    
    //MARK: - UI
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 50
        searchBar.returnKeyType = .done
        searchBar.placeholder = Constants.searchBarPlaceholder
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.addSubview(mainImageView)
        mainView.addSubview(mainLabel)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private lazy var mainImageView: UIImageView = {
        let mainImageView = UIImageView()
        mainImageView.image = UIImage(named: Constants.mainImageName)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        return mainImageView
    }()
    
    private lazy var mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.text = Constants.mainLabelText
        mainLabel.textAlignment = .center
        mainLabel.textColor = .lightGray
        mainLabel.numberOfLines = 0
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        return mainLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: Constants.indentifire)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Private propertys
    
    private var presenter: SearchFormPresenterInput
    
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
        presenter.viewDidLoad()
        isHidden()
    }
    
    //MARK: - Private methods
    
    private func viewAndNavBarSetup() {
        view.backgroundColor = .white
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        navigationItem.leftBarButtonItem = leftNavBarButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.rightBarButtonTitle, style: .done, target: self, action:  #selector(doneBtn))
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(mainView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: 295),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.widthAnchor.constraint(equalToConstant: 360),
            mainView.heightAnchor.constraint(equalToConstant: 360)
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 40),
            mainImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 150),
            mainImageView.widthAnchor.constraint(equalToConstant: 60),
            mainImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalToConstant: 360)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func isHidden() {
        tableView.isHidden = true
        mainView.isHidden = false
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

//MARK: - Extentions

extension SearchFormViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.gettingWordsAndMeaningsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.indentifire, for: indexPath) as? CustomCell {
            let word = presenter.gettingWordsAndMeanings(index: indexPath.row)
            cell.configure(with: word)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = presenter.didSelectRowAt(index: indexPath.row)
        let destinationVC = AssemblyDetailedInformation.assembly(with: word)
        navigationController?.pushViewController(destinationVC, animated: false)
    }
}

extension SearchFormViewController: SearchFormInput {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func views(isHidden: Bool) {
        tableView.isHidden = isHidden
        mainView.isHidden = !isHidden
    }
    
    func changeMainView(imageName: String, lableText: String) {
        let imageName = imageName
        let lableText = lableText
        mainImageView.image = UIImage(named: imageName)
        mainLabel.text = lableText
        isHidden()
    }
}

extension SearchFormViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText
        if searchText.isEmpty {
            mainImageView.image = UIImage(named: Constants.mainImageName)
            mainLabel.text = Constants.mainLabelText
            isHidden()
        } else {
            presenter.didChangeText(searchText)
        }
    }
}
