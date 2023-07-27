//
//  ExampleView.swift
//  SkyEng
//
//  Created by Максим Жуков on 25.07.2023.
//

import UIKit

//MARK: - Final class

protocol ExampleViewProtocol {
    func sendUrl(url: String)
}

final class ExampleView: UIView {
    
    //MARK: - Constants
    
    private enum Constants {
        static let examplePlayButtonImageName = "play"
    }
    
    //MARK: - UI
    
    private let examplePlayButton: UIButton = {
        let examplePlayButton = UIButton()
        examplePlayButton.setBackgroundImage(UIImage(named: Constants.examplePlayButtonImageName), for: .normal)
        examplePlayButton.addTarget(nil, action: #selector(btnDidTap), for: .touchUpInside)
        examplePlayButton.translatesAutoresizingMaskIntoConstraints = false
        return examplePlayButton
    }()
    
    private lazy var exampleLabel: UILabel = {
        let exampleLabel = UILabel()
        exampleLabel.textColor = .lightGray
        exampleLabel.numberOfLines = 0
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        return exampleLabel
    }()
    
    //MARK: - Public propertys
    
    var delegate: ExampleViewProtocol?
    var url: String?
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupViwes()
        setupConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(btnDidTap))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupViwes() {
        addSubview(examplePlayButton)
        addSubview(exampleLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            examplePlayButton.centerYAnchor.constraint(equalTo: exampleLabel.centerYAnchor),
            examplePlayButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            examplePlayButton.widthAnchor.constraint(equalToConstant: 25),
            examplePlayButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            exampleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            exampleLabel.leadingAnchor.constraint(equalTo: examplePlayButton.trailingAnchor, constant: 10),
            exampleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            exampleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: - Public methods
    
    func configure(with text: String, url: String) {
        exampleLabel.text = text
        self.url = url
    }
    
    @objc func btnDidTap() {
        delegate?.sendUrl(url: url ?? "")
    }
}

