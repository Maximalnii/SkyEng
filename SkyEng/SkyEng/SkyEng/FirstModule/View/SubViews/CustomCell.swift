//
//  CustomCell.swift
//  SkyEng
//
//  Created by Максим Жуков on 18.07.2023.
//

import UIKit

//MARK: - Final class

final class CustomCell: UITableViewCell {
    
    //MARK: - Constants
    
    private enum Constants {
        static let https = "https:"
    }
    
    //MARK: - UI
    
    private lazy var wordImageView: UIImageView = {
        let wordImageView = UIImageView()
        wordImageView.layer.cornerRadius = 15
        wordImageView.contentMode = .scaleAspectFill
        wordImageView.layer.masksToBounds = true
        wordImageView.translatesAutoresizingMaskIntoConstraints = false
        return wordImageView
    }()
    
    private lazy var wordLabel: UILabel = {
        let wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        return wordLabel
    }()
    
    private lazy var meaningLabel: UILabel = {
        let meaningLabel = UILabel()
        meaningLabel.textColor = .lightGray
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        return meaningLabel
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViwes()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupViwes() {
        selectionStyle = .none
        contentView.addSubview(wordImageView)
        contentView.addSubview(wordLabel)
        contentView.addSubview(meaningLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wordImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            wordImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            wordImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            wordImageView.heightAnchor.constraint(equalToConstant: 60),
            wordImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            wordLabel.leadingAnchor.constraint(equalTo: wordImageView.trailingAnchor, constant: 10),
            wordLabel.heightAnchor.constraint(equalToConstant: 20),
            wordLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor,constant: 10),
            meaningLabel.leadingAnchor.constraint(equalTo: wordImageView.trailingAnchor, constant: 10),
            meaningLabel.heightAnchor.constraint(equalToConstant: 20),
            meaningLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    //MARK: - Public methods
    
    func configure(with model: WordsAndMeanings) {
        wordLabel.text = model.text
        meaningLabel.text = model.meanings?.first?.translation?.text
        guard let previewUrl = model.meanings?.first?.previewURL else { return }
        let url = Constants.https + previewUrl
        wordImageView.downloaded(from: url)
    }
}
