//
//  MainTableViewCell.swift
//  AvitoTechTestTask
//
//  Created by Денис Медведев on 26.10.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let reuseId = "MainTableViewCell"
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 22)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let phoneLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.font = .systemFont(ofSize: 14)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberLabel
    }()
    
    private let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.font = .boldSystemFont(ofSize: 17)
        phoneNumberLabel.textColor = .systemBlue
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberLabel
    }()
    
    private let skillsLabel: UILabel = {
        let skillsLabel = UILabel()
        skillsLabel.font = .boldSystemFont(ofSize: 17)
        skillsLabel.numberOfLines = 0
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        return skillsLabel
    }()
    
    private let personImageView: UIImageView = {
        let personImageView = UIImageView()
        personImageView.image = UIImage.init(systemName: "person.fill")
        personImageView.tintColor = .systemGray
        personImageView.contentMode = .scaleAspectFit
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        return personImageView
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        [nameLabel, phoneLabel, phoneNumberLabel, skillsLabel].forEach { stack.addArrangedSubview($0) }
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(with data: Employee) {
        nameLabel.text = data.name
        phoneLabel.text = "phone:"
        phoneNumberLabel.text = "\(data.phoneNumber)"
        if data.skills.count > 1 {
            skillsLabel.text = "Skills: \(data.skills.map({ "\($0)" }).joined(separator: ", "))"
        } else if data.skills.count == 1 {
            skillsLabel.text = "Skills: \(data.skills[0])"
        } else {
            skillsLabel.text = "None"
        }
    }
    
    private func setupSubviews() {
        [verticalStack, personImageView].forEach { subview in contentView.addSubview(subview) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            personImageView.heightAnchor.constraint(equalToConstant: 100),
            personImageView.widthAnchor.constraint(equalToConstant: 100),
            personImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            verticalStack.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
}
