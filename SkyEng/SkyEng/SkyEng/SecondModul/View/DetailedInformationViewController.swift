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
    }
    
    //MARK: - Public methods
    
    @objc func backBtn() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extentions

extension DetailedInformationViewController: DetailedInformationInput {
    
}
