//
//  ViewController.swift
//  Minigames
//
//  Created by Ерош Айтжанов on 06.09.2024.
//

import UIKit


class ViewController: UIViewController {
    
    var gameData = ["Крестики-нолики", "Погода", "Кликерман", "Кроссворд", "Найди пару", "Погода", "Кликерман", "Кроссворд", "Крестики-нолики", "Погода"]
    
    lazy var mainTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MainTableViewCell.self, forCellReuseIdentifier: "main")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        view.backgroundColor = .red
    }

    func setupUI() {
        view.addSubview(mainTableView)
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "main", for: indexPath) as! MainTableViewCell
        let game = gameData[indexPath.row]
        cell.conf(game: game)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = gameData[indexPath.row]
        var gameDetailViewController: UIViewController
        
        if game == "Найди пару" {
            gameDetailViewController = EmojiViewController()
        } else if game == "Погода"{
            gameDetailViewController = WeatherViewController()
        } else {
            gameDetailViewController = MainTicTacToeViewController()
        }
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 8
    }
    
}
