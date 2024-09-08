//
//  Emoji.swift
//  TicTacToe
//
//  Created by Ерош Айтжанов on 05.08.2024.
//

import Foundation

class Emoji {
    
    var possibleEmojies = ["😜","😎","🤯","😈","😻","🧛🏻‍♂️"]
    var arrayEmoji:[String] = []
    var currentChoices:[Int] = []
    
    func choiceEmoji(index: Int) {
        currentChoices.append(index)
    }
    func choiceClear() {
        currentChoices = []
    }
    func checkWin() -> String {
        if arrayEmoji[currentChoices[0]] == arrayEmoji[currentChoices[1]] {
            return "win"
        } else {
            return "lose"
        }
    }
    func restart() {
        createGame()
        currentChoices = []
    }
    func createGame() {
        arrayEmoji = []
        var firstEmoji = possibleEmojies.randomElement()
        var secondEmoji = possibleEmojies.randomElement()
        while firstEmoji == secondEmoji {
            secondEmoji = possibleEmojies.randomElement()
        }
        var temp = [firstEmoji,firstEmoji,secondEmoji,secondEmoji]
        for _ in 0...3 {
            var element = temp.randomElement()
            arrayEmoji.append(element!!)
            temp.remove(at: temp.firstIndex(of: element!!)!)

        }
        
    }
}
