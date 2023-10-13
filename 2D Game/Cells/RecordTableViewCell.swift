//
//  RecordTableViewCell.swift
//  2D Game
//
//  Created by Igor on 12.10.2023.
//

import UIKit

final class RecordTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static var identifier: String { "\(Self.self)" }
    
    private let recordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    private let avatarIV: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    //MARK: - Override Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        avatarIV.layer.cornerRadius = avatarIV.frame.height / 2
        avatarIV.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recordLabel.text = nil
        userNameLabel.text = nil
        avatarIV.image = nil
    }

    
    //MARK: - Flow
    private func addSubviews() {
        contentView.addSubview(recordLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(avatarIV)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarIV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarIV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarIV.widthAnchor.constraint(equalToConstant: 40),
            avatarIV.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor , constant: 50),
            userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(user: User) {
        recordLabel.text = String(user.record.scores)
        userNameLabel.text = user.name
        avatarIV.image = StorageManager.shared.loadImage(name: user.imageName)
    }
    
}
