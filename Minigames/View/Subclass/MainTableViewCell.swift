//
//  MainTableViewCell.swift
//  Minigames
//
//  Created by Ерош Айтжанов on 06.09.2024.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    private lazy var gameTitle:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func conf(game: String) {
        gameTitle.text = game
    }
    
    func setupUI() {
        contentView.addSubview(gameTitle)
        NSLayoutConstraint.activate([
            gameTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            gameTitle.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            gameTitle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            gameTitle.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
