//
//  ViewController.swift
//  TicTacToe
//


import UIKit

class ticTacToeViewController: UIViewController {
    
    var arrayButton: [UIButton] = []
    var mainStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var winLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 33, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.setTitle("  Restart  ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    
    func stackSetup() {
        for _ in 0..<3 {
            // Create a horizontal stack view for each row
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 10

            // Create 3 buttons for each row
            for _ in 0..<3 {
                let button = UIButton(type: .system)
                button.backgroundColor = .systemGray4
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                
                // Add button to array and row stack view
                arrayButton.append(button)
                rowStackView.addArrangedSubview(button)
            }

            // Add row stack view to the main stack view
            mainStackView.addArrangedSubview(rowStackView)
        }
        
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        
        
        view.addSubview(orderLabel)
        view.addSubview(winLabel)
        view.addSubview(mainStackView)
        view.addSubview(restartButton)
    
        NSLayoutConstraint.activate([
            // Layout the main stack view
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            mainStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            // Layout the order label
            orderLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            orderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            // Layout the win label
            winLabel.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -20),
            winLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            // Layout the restart button
            restartButton.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 20),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])

    }
    
    
    
    
    
    var game = TicTacToe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        stackSetup()
        orderLabel.textColor = .blue
        orderLabel.text = "Order of ❎"
    }
    
    @objc func restartButtonTapped(_ sender: UIButton) {
        game.restart()
        updateView()
        orderLabel.text = "Order of ❎"
        winLabel.textColor = .green
        winLabel.text = ""
        for i in 0...8 {
            arrayButton[i].isEnabled = true
        }
    }
    var counter = 0
    
    @objc func buttonTapped(_ sender: UIButton){
        guard let index = arrayButton.firstIndex(of: sender)
            else {return}
        counter = game.choiceXO(index: index)
        if !game.isGameComputer {
            if counter % 2 != 0 {
                orderLabel.text = "Order of ⭕️"
            } else {
                orderLabel.text = "Order of ❎"
            }
        }
        arrayButton[index].isEnabled = false
        updateView()
        if game.win() == nil {
            if game.isGameComputer {
                let randomIndex = game.computerXO()
                arrayButton[randomIndex].isEnabled = false
                updateView()
            }
        }
    }
    
    
    func updateView() {
        for i in 0...8 {
            let button = arrayButton[i]
            let XO = game.arrayXO[i]
            if XO.isWriteXO {
                button.setTitle(XO.name, for: .normal)
            } else {
                button.setTitle(" ", for: .normal)
            }
        }
        if let win = game.win() {
            orderLabel.text = ""
            if win == "Draw" {
                winLabel.textColor = .blue
                winLabel.text = "\(win)"
            } else {
                if win == "⭕️" {
                    winLabel.textColor = .red
                }
                winLabel.text = "Winner: \(win)"
            }
            for i in 0...8 {
                arrayButton[i].isEnabled = false
            }
        }
    }
    
    
    
}


