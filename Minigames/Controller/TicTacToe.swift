//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Ерош Айтжанов on 14.06.2024.
//

import Foundation

class TicTacToe {

    var arrayXO: [XO] = Array(repeating: XO(), count: 9)
    var isGameComputer = false
    var counter = 0
    let winCombination = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var possibleIndecies = [0,1,2,3,4,5,6,7,8]

    func choiceXO(index: Int) -> Int {
        if isGameComputer && counter != 0 {
            counter += 2
        } else {
            counter += 1
        }
        possibleIndecies.remove(at: possibleIndecies.firstIndex(of: index)!)
        if counter % 2 == 0 {
            arrayXO[index].name = "⭕️"
        } else {
            arrayXO[index].name = "❎"
        }
        arrayXO[index].isWriteXO = true
        return counter
    }

    func computerXO() -> Int {
        let bestMove = minimax(array: arrayXO, pos: possibleIndecies, maximizing: true).index
        possibleIndecies.remove(at: possibleIndecies.firstIndex(of: bestMove)!)
        arrayXO[bestMove].name = "⭕️"
        arrayXO[bestMove].isWriteXO = true
        return bestMove
    }

    func win() -> String? {
        for i in winCombination {
            if arrayXO[i[0]].name == arrayXO[i[1]].name &&
                arrayXO[i[1]].name == arrayXO[i[2]].name &&
                arrayXO[i[0]].isWriteXO {
                return arrayXO[i[0]].name
            }
        }
        if counter == 9 {
            return "Draw"
        }
        return nil
    }

    func restart() {
        arrayXO = Array(repeating: XO(), count: 9)
        possibleIndecies = [0,1,2,3,4,5,6,7,8]
        counter = 0
    }

    func minimax(array: [XO], pos: [Int], maximizing: Bool) -> (score: Int, index: Int) {
        if let score = evaluate(array: array) {
            return (score, -1)
        }
        
        var bestScore = maximizing ? Int.min : Int.max
        var bestMove = -1

        for p in pos {
            var array2 = array
            var pos2 = pos
            pos2.remove(at: pos2.firstIndex(of: p)!)
            array2[p].name = maximizing ? "⭕️" : "❎"
            array2[p].isWriteXO = true

            let currentScore = minimax(array: array2, pos: pos2, maximizing: !maximizing).score
            
            if maximizing {
                if currentScore > bestScore {
                    bestScore = currentScore
                    bestMove = p
                }
            } else {
                if currentScore < bestScore {
                    bestScore = currentScore
                    bestMove = p
                }
            }
        }
        return (bestScore, bestMove)
    }

    func evaluate(array: [XO]) -> Int? {
        for i in winCombination {
            if array[i[0]].name == array[i[1]].name &&
                array[i[1]].name == array[i[2]].name &&
                array[i[0]].isWriteXO {
                return array[i[0]].name == "⭕️" ? 1 : -1
            }
        }
        if !array.contains(where: { !$0.isWriteXO }) {
            return 0 // Draw
        }
        return nil // Game is still ongoing
    }
}
