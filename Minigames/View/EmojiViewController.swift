//
//  EmojiViewController.swift


import UIKit

class EmojiViewController: UIViewController {
    
    var game = Emoji()
    
    var arrayButtonEmoji: [UIButton] = []
    var mainStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .green
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stackSetup()
        game.createGame()


        // Do any additional setup after loading the view.
    }

    func stackSetup() {
        for _ in 0..<2 {
            // Create a horizontal stack view for each row
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 30

            // Create 3 buttons for each row
            for _ in 0..<2 {
                let button = UIButton(type: .system)
                button.backgroundColor = .systemGray4
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                
                // Add button to array and row stack view
                arrayButtonEmoji.append(button)
                rowStackView.addArrangedSubview(button)
            }

            // Add row stack view to the main stack view
            mainStackView.addArrangedSubview(rowStackView)
        }
        
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(mainStackView)
        view.addSubview(restartButton)
    
        NSLayoutConstraint.activate([
            // Layout the main stack view
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            mainStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            label.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            restartButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

    }
    
    var counter = 0
    var found = 0
    
    @objc func buttonTapped(_ sender: UIButton){
        guard let index = arrayButtonEmoji.firstIndex(of: sender)
            else {return}
        counter += 1
        if counter <= 2 {
            game.choiceEmoji(index: index)
            arrayButtonEmoji[index].setTitle(game.arrayEmoji[index], for: .normal)
            if counter == 2 {
                if game.checkWin() == "win" {
                    arrayButtonEmoji[game.currentChoices[0]].isEnabled = false
                    arrayButtonEmoji[game.currentChoices[1]].isEnabled = false
                    found += 2
                    counter = 0
                    if found == 4 {
                        label.text = "WIN"
                    }
                }
            }
        } else {
            for i in 0...3{
                arrayButtonEmoji[i].setTitle("", for: .normal)
            }
            game.choiceClear()
            game.choiceEmoji(index: index)
            arrayButtonEmoji[index].setTitle(game.arrayEmoji[index], for: .normal)
            counter = 1
        }
    }
    
    @objc func restartButtonTapped(_ sender: UIButton) {
        game.restart()
        counter = 0
        found = 0
        label.text = ""
        for i in 0...3 {
            arrayButtonEmoji[i].isEnabled = true
            arrayButtonEmoji[i].setTitle("", for: .normal)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
