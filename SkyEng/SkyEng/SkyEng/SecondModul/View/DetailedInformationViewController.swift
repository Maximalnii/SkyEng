//
//  DetailedInformationViewController.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import UIKit

//MARK: - Protocol

protocol DetailedInformationInput: AnyObject {
    func update(with model: WordDetails, delegate: ExampleViewProtocol)
}

//MARK: - Final class

class DetailedInformationViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let https = "https:"
        static let font = "HelveticaNeue-Bold"
        static let pronounceButtonImageName = "pronounce"
        static let backButtonImageName = "backBtn"
        static let rareWordImageName = "rareWord"
        static let addToDictionaryButtonTitle = "Добавить в словарь"
        static let rareWordText = "Уровень сложности -"
        
    }
    
    //MARK: - UI
    
    private lazy var detailedView: UIView = {
        let detailedView = UIView()
        detailedView.backgroundColor = .lightGray
        detailedView.layer.cornerRadius = 15
        detailedView.layer.masksToBounds = true
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        return detailedView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var detailedImageView: UIImageView = {
        let detailedImageView = UIImageView()
        detailedImageView.layer.masksToBounds = true
        detailedImageView.translatesAutoresizingMaskIntoConstraints = false
        return detailedImageView
    }()
    
    private lazy var detailedWordview: UIView = {
        let detailedWordview = UIView()
        detailedWordview.backgroundColor = .detailedWordViewColor
        detailedWordview.translatesAutoresizingMaskIntoConstraints = false
        return detailedWordview
    }()
    
    private lazy var detailedWordLabel: UILabel = {
        let detailedWordLabel = UILabel()
        detailedWordLabel.textColor = .white
        detailedWordLabel.font = UIFont(name: Constants.font, size: 20)
        detailedWordLabel.numberOfLines = 0
        detailedWordLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailedWordLabel
    }()
    
    private lazy var detailedMeaningLabel: UILabel = {
        let detailedMeaningLabel = UILabel()
        detailedMeaningLabel.textColor = .white
        detailedMeaningLabel.numberOfLines = 0
        detailedMeaningLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailedMeaningLabel
    }()
    
    private lazy var pronounceButton: UIButton = {
        let pronounceButton = UIButton()
        pronounceButton.setBackgroundImage(UIImage(named: Constants.pronounceButtonImageName), for: .normal)
        pronounceButton.addTarget(self, action: #selector(pronounceButtonDidTap), for: .allTouchEvents)
        pronounceButton.translatesAutoresizingMaskIntoConstraints = false
        return pronounceButton
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setBackgroundImage(UIImage(named: Constants.backButtonImageName), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .allTouchEvents)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private lazy var rareWordImageView: UIImageView = {
        let rareWordImageView = UIImageView()
        rareWordImageView.image = UIImage(named: Constants.rareWordImageName)
        rareWordImageView.translatesAutoresizingMaskIntoConstraints = false
        return rareWordImageView
    }()
    
    private lazy var rareWordLabel: UILabel = {
        let rareWordLabel = UILabel()
        rareWordLabel.translatesAutoresizingMaskIntoConstraints = false
        return rareWordLabel
    }()
    
    private lazy var transcriptionLabel: UILabel = {
        let transcriptionLabel = UILabel()
        transcriptionLabel.numberOfLines = 0
        transcriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return transcriptionLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var addToDictionaryButton: UIButton = {
        let addToDictionaryButton = UIButton()
        addToDictionaryButton.setTitle(Constants.addToDictionaryButtonTitle, for: .normal)
        addToDictionaryButton.setTitleColor(UIColor.white, for: .normal)
        addToDictionaryButton.layer.cornerRadius = 23
        addToDictionaryButton.backgroundColor = .detailedWordViewColor
        addToDictionaryButton.translatesAutoresizingMaskIntoConstraints = false
        return addToDictionaryButton
    }()
    
    //MARK: - Private propertys
    
    private var presenter: DetailedInformationPresenterInput
    private var soundUrl: String?
    
    //MARK: - Init
    
    init(presenter: DetailedInformationPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewAndNavButton()
        setupViews()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    //MARK: - Private methods
    
    private func configure(with model: WordDetails, delegate: ExampleViewProtocol) {
        soundUrl = model.soundUrl
        detailedWordLabel.text = model.text
        descriptionLabel.text = model.definition.text
        transcriptionLabel.text = model.transcription
        detailedMeaningLabel.text = model.translation.text
        rareWordLabel.text = Constants.rareWordText + " " + "\(model.difficultyLevel)"
        let string = Constants.https + (model.images.first?.url ?? "")
        let url = URL(string: string)
        if let url = url {
            detailedImageView.downloaded(from: url)
        }
        model.examples.forEach {
            let exampleView = ExampleView(delegate: delegate)
            exampleView.configure(with: $0.text ?? "", url: $0.soundUrl ?? "")
            stackView.addArrangedSubview(exampleView)
        }
    }
    
    private func setupViewAndNavButton() {
        view.backgroundColor = .white
        let leftNavBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func setupViews() {
        view.addSubview(detailedView)
        detailedView.addSubview(detailedImageView)
        detailedView.addSubview(detailedWordview)
        detailedWordview.addSubview(detailedWordLabel)
        detailedWordview.addSubview(detailedMeaningLabel)
        detailedWordview.addSubview(pronounceButton)
        view.addSubview(rareWordImageView)
        view.addSubview(rareWordLabel)
        view.addSubview(transcriptionLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(addToDictionaryButton)
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            detailedView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            detailedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            detailedView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            detailedImageView.topAnchor.constraint(equalTo: detailedView.topAnchor),
            detailedImageView.leadingAnchor.constraint(equalTo: detailedView.leadingAnchor),
            detailedImageView.trailingAnchor.constraint(equalTo: detailedView.trailingAnchor),
            detailedImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            detailedWordview.topAnchor.constraint(equalTo: detailedImageView.bottomAnchor),
            detailedWordview.leadingAnchor.constraint(equalTo: detailedView.leadingAnchor),
            detailedWordview.trailingAnchor.constraint(equalTo: detailedView.trailingAnchor),
            detailedWordview.bottomAnchor.constraint(equalTo: detailedView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailedWordLabel.topAnchor.constraint(equalTo: detailedWordview.topAnchor, constant: 10),
            detailedWordLabel.leadingAnchor.constraint(equalTo: detailedWordview.leadingAnchor, constant: 20),
            detailedWordLabel.trailingAnchor.constraint(equalTo: pronounceButton.leadingAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            detailedMeaningLabel.topAnchor.constraint(equalTo: detailedWordLabel.bottomAnchor,constant: 10),
            detailedMeaningLabel.leadingAnchor.constraint(equalTo: detailedWordview.leadingAnchor, constant: 20),
            detailedMeaningLabel.trailingAnchor.constraint(equalTo: detailedWordview.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            pronounceButton.centerYAnchor.constraint(equalTo: detailedWordLabel.centerYAnchor),
            pronounceButton.trailingAnchor.constraint(equalTo: detailedWordview.trailingAnchor, constant: -20),
            pronounceButton.widthAnchor.constraint(equalToConstant: 40),
            pronounceButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            rareWordImageView.topAnchor.constraint(equalTo: detailedView.bottomAnchor, constant: 30),
            rareWordImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            rareWordImageView.widthAnchor.constraint(equalToConstant: 20),
            rareWordImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            rareWordLabel.topAnchor.constraint(equalTo: detailedView.bottomAnchor, constant: 30),
            rareWordLabel.leadingAnchor.constraint(equalTo: rareWordImageView.trailingAnchor, constant: 10),
            rareWordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rareWordLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            transcriptionLabel.topAnchor.constraint(equalTo: rareWordImageView.bottomAnchor, constant: 10),
            transcriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            transcriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: transcriptionLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            addToDictionaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -50),
            addToDictionaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addToDictionaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addToDictionaryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10)
        ])
    }
    
    //MARK: - Public methods
    
    
    
    @objc func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pronounceButtonDidTap() {
        guard let url = NSURL(string: soundUrl ?? "") else { return }
        presenter.play(url: url)
    }
}

//MARK: - Extentions

extension DetailedInformationViewController: DetailedInformationInput {
    
    func update(with model: WordDetails, delegate: ExampleViewProtocol) {
        configure(with: model, delegate: delegate)
    }
}




