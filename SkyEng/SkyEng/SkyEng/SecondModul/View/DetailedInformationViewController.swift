//
//  DetailedInformationViewController.swift
//  SkyEng
//
//  Created by Максим Жуков on 14.07.2023.
//

import UIKit


//MARK: - Protocol

protocol DetailedInformationInput: AnyObject {
    
}

//MARK: - Final class

class DetailedInformationViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        
    }
    
    //MARK: - UI
    
    private lazy var detailedView: UIView = {
        let detailedView = UIView()
        detailedView.layer.cornerRadius = 15
        detailedView.contentMode = .scaleAspectFill
        detailedView.addSubview(detailedImageView)
        detailedView.addSubview(detailedWordview)
        detailedView.layer.masksToBounds = true
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        return detailedView
    }()
    
    private lazy var detailedImageView: UIImageView = {
        let detailedImageView = UIImageView()
        detailedImageView.image = UIImage(named: "mainImage 1")
        detailedImageView.translatesAutoresizingMaskIntoConstraints = false
        return detailedImageView
    }()
    
    private lazy var detailedWordview: UIView = {
        let detailedWordview = UIView()
        detailedWordview.backgroundColor = .detailedWordViewColor
        detailedWordview.addSubview(detailedWordLabel)
        detailedWordview.addSubview(detailedMeaningLabel)
        detailedWordview.addSubview(pronounceButton)
        detailedWordview.translatesAutoresizingMaskIntoConstraints = false
        return detailedWordview
    }()
    
    private lazy var detailedWordLabel: UILabel = {
        let detailedWordLabel = UILabel()
        detailedWordLabel.text = "gold"
        detailedWordLabel.textColor = .white
        detailedWordLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        detailedWordLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailedWordLabel
    }()
    
    private lazy var detailedMeaningLabel: UILabel = {
        let detailedMeaningLabel = UILabel()
        detailedMeaningLabel.text = "золотой цвет"
        detailedMeaningLabel.textColor = .white
        detailedMeaningLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailedMeaningLabel
    }()
    
    private lazy var pronounceButton: UIButton = {
        let pronounceButton = UIButton()
        pronounceButton.setBackgroundImage(UIImage(named: "pronounce"), for: .normal)
        pronounceButton.translatesAutoresizingMaskIntoConstraints = false
        return pronounceButton
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setBackgroundImage(UIImage(named: "backBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(backBtn), for: .allTouchEvents)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private lazy var rareWordImageView: UIImageView = {
        let rareWordImageView = UIImageView()
        rareWordImageView.image = UIImage(named: "rareWord")
        rareWordImageView.translatesAutoresizingMaskIntoConstraints = false
        return rareWordImageView
    }()
    
    private lazy var rareWordLabel: UILabel = {
        let rareWordLabel = UILabel()
        rareWordLabel.text = "Редкое слово"
        rareWordLabel.translatesAutoresizingMaskIntoConstraints = false
        return rareWordLabel
    }()
    
    private lazy var transcriptionLabel: UILabel = {
        let transcriptionLabel = UILabel()
        transcriptionLabel.text = "/gəʊldgəʊld/"
        transcriptionLabel.numberOfLines = 0
        transcriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return transcriptionLabel
    }()
    
    private lazy var partOfSpeachLabel: UILabel = {
        let partOfSpeachLabel = UILabel()
        partOfSpeachLabel.text = "существительное"
        partOfSpeachLabel.translatesAutoresizingMaskIntoConstraints = false
        return partOfSpeachLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "A deep yellow color."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var firstExamplePlayButton: UIButton = {
        let firstExamplePlayButton = UIButton()
        firstExamplePlayButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
        firstExamplePlayButton.translatesAutoresizingMaskIntoConstraints = false
        return firstExamplePlayButton
    }()
    
    private lazy var secondExamplePlayButton: UIButton = {
        let secondExamplePlayButton = UIButton()
        secondExamplePlayButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
        secondExamplePlayButton.translatesAutoresizingMaskIntoConstraints = false
        return secondExamplePlayButton
    }()
    
    private lazy var firstExampleLabel: UILabel = {
        let firstExampleLabel = UILabel()
        firstExampleLabel.text = "He admired the gold of her hire"
        firstExampleLabel.textColor = .lightGray
        firstExampleLabel.numberOfLines = 0
        firstExampleLabel.translatesAutoresizingMaskIntoConstraints = false
        return firstExampleLabel
    }()
    
    private lazy var secondExampleLabel: UILabel = {
        let secondExampleLabel = UILabel()
        secondExampleLabel.text = "Her eys were light green and flicked with gold"
        secondExampleLabel.textColor = .lightGray
        secondExampleLabel.numberOfLines = 0
        secondExampleLabel.translatesAutoresizingMaskIntoConstraints = false
        return secondExampleLabel
    }()
    
    private lazy var addToDictionaryButton: UIButton = {
        let addToDictionaryButton = UIButton()
        addToDictionaryButton.setTitle("Добавить в словарь", for: .normal)
        addToDictionaryButton.setTitleColor(UIColor.white, for: .normal)
        addToDictionaryButton.layer.cornerRadius = 23
        addToDictionaryButton.backgroundColor = .detailedWordViewColor
        addToDictionaryButton.translatesAutoresizingMaskIntoConstraints = false
        return addToDictionaryButton
    }()
    
    //MARK: - Private propertys
    
    private var presenter: DetailedInformationPresenterInput
    
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
    }
    
    //MARK: - Private methods
    
    private func setupViewAndNavButton() {
        view.backgroundColor = .white
        let leftNavBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func setupViews() {
        view.addSubview(detailedView)
        view.addSubview(rareWordImageView)
        view.addSubview(rareWordLabel)
        view.addSubview(transcriptionLabel)
        view.addSubview(partOfSpeachLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(firstExamplePlayButton)
        view.addSubview(secondExamplePlayButton)
        view.addSubview(firstExampleLabel)
        view.addSubview(secondExampleLabel)
        view.addSubview(addToDictionaryButton)
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
            detailedWordLabel.widthAnchor.constraint(equalToConstant: 250),
            detailedWordLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            detailedMeaningLabel.topAnchor.constraint(equalTo: detailedWordLabel.bottomAnchor,constant: 10),
            detailedMeaningLabel.leadingAnchor.constraint(equalTo: detailedWordview.leadingAnchor, constant: 20),
            detailedMeaningLabel.widthAnchor.constraint(equalToConstant: 250),
            detailedMeaningLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            pronounceButton.topAnchor.constraint(equalTo: detailedWordview.topAnchor, constant: 10),
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
            transcriptionLabel.topAnchor.constraint(equalTo: rareWordImageView.bottomAnchor, constant: 30),
            transcriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            transcriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            partOfSpeachLabel.topAnchor.constraint(equalTo: rareWordLabel.bottomAnchor, constant: 30),
            partOfSpeachLabel.leadingAnchor.constraint(equalTo: transcriptionLabel.trailingAnchor, constant: 10),
            partOfSpeachLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: transcriptionLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            firstExamplePlayButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            firstExamplePlayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            firstExamplePlayButton.widthAnchor.constraint(equalToConstant: 20),
            firstExamplePlayButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            secondExamplePlayButton.topAnchor.constraint(equalTo: firstExamplePlayButton.bottomAnchor, constant: 15),
            secondExamplePlayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            secondExamplePlayButton.widthAnchor.constraint(equalToConstant: 20),
            secondExamplePlayButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            firstExampleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            firstExampleLabel.leadingAnchor.constraint(equalTo: firstExamplePlayButton.trailingAnchor, constant: 10),
            firstExampleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            secondExampleLabel.topAnchor.constraint(equalTo: firstExampleLabel.bottomAnchor, constant: 15),
            secondExampleLabel.leadingAnchor.constraint(equalTo: firstExamplePlayButton.trailingAnchor, constant: 10),
            secondExampleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            addToDictionaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -50),
            addToDictionaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addToDictionaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addToDictionaryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //MARK: - Public methods
    
    @objc func backBtn() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extentions

extension DetailedInformationViewController: DetailedInformationInput {
    
}
