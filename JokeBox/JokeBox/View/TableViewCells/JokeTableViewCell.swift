//
//  JokeTableViewCell.swift
//  JokeBox
//
//  Created by Naman on 24/06/23.
//

import Foundation
import UIKit

class JokeTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    //================================
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    //================================
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setup UI
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(cardView)
        self.cardView.addSubview(titleLabel)
        self.setUIConstraints()
    }
    
    // set the constraints for UI Elements
    func setUIConstraints() {
        // Configure constraints
        NSLayoutConstraint.activate([
            self.cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            self.cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            self.cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            self.titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            self.titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
    }
}
