//
//  TableViewHeader.swift
//  CreateChallenge
//
//  Created by Sameh Mabrouk on 24/11/2021.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's get started. Pick your challenge type."
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "stadium")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI

extension TableViewHeader {
    
    func setupUI() {
        setupSubviews()
        setupConstraints()
        
        contentView.backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(backgroundImage)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            backgroundImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 138),
//            backgroundImage.widthAnchor.constraint(equalToConstant: 287),
            backgroundImage.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -38),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -90)
        ])
    }}
