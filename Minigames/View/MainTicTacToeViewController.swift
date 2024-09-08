//
//  MainTicTacToeViewController.swift
//  Minigames
//
//  Created by Ерош Айтжанов on 08.09.2024.
//

import UIKit

class MainTicTacToeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        computerButton.addTarget(self, action: #selector(computerButtonTapped(_:)), for: .touchUpInside)
        humanButton.addTarget(self, action: #selector(humanButtonTapped(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    let computerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.setTitle("  Играть с компьютером  ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let humanButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.setTitle("  Играть с человеком  ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    @objc func computerButtonTapped(_ sender: UIButton) {
        navigateToTicTacToe(player: "computer")
    }
    
    @objc func humanButtonTapped(_ sender: UIButton) {
        navigateToTicTacToe(player: "human")
    }
    
    func navigateToTicTacToe(player: String) {
        let gameDetailViewController = ticTacToeViewController()
        gameDetailViewController.game.isGameComputer = (player == "computer") ? true : false
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
    
    func setupUI() {
        view.addSubview(computerButton)
        view.addSubview(humanButton)
    
        NSLayoutConstraint.activate([
            // Layout the main stack view
            computerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            computerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            humanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            humanButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
        ])
    }

}
