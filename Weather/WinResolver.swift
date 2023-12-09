//
//  WinResolver.swift
//  Weather
//
//  Created by Ilya Stoletov on 09.12.2023.
//

import Foundation

struct WinResolver {
    
    private let crossWinCombination = [1,1,1]
    private let circleWinCombination = [2,2,2]
    
    
    let cellsMatrix: [[Int]]
    
    func checkWin() -> Bool {
        return checkWinHorizontalAxis() || checkWinCrossAxis() || checkWinVerticalAxis()
    }
    
    private func checkWinHorizontalAxis() -> Bool {
        var win: Bool = false
        for i in 0..<3 {
            let crossWin = cellsMatrix[i] == crossWinCombination
            let circleWin = cellsMatrix[i] == circleWinCombination
            if crossWin || circleWin { win = true; break }
        }
        return win
    }
    
    private func checkWinVerticalAxis() -> Bool {
        var win: Bool = false
        
        var tempDict: [Int] = []
        var curIndex = 0
        
        while curIndex < 3 {
            for i in 0..<3 {
                tempDict.append(cellsMatrix[i][curIndex])
            }
            if tempDict == crossWinCombination || tempDict == circleWinCombination {
                win = true
                break
            } else {
                curIndex += 1
                tempDict.removeAll()
            }
        }
        
        return win
    }
    
    private func checkWinCrossAxis() -> Bool {
        var win: Bool = false
        
        let secondaryDiagonalEntries: [[Int]] = [[0,2],[1,1],[2,0]]
        var tempDict: [Int] = []
        
        // Check main diagonal entries are equals win combination
        for i in 0..<3 {
            tempDict.append(cellsMatrix[i][i])
        }
        
        if tempDict == crossWinCombination || tempDict == circleWinCombination {
            win = true
        }
        
        tempDict.removeAll()
        
        for entry in secondaryDiagonalEntries {
            tempDict.append(cellsMatrix[entry[0]][entry[1]])
        }
        
        if tempDict == crossWinCombination || tempDict == circleWinCombination {
            win = true
        }
        
        return win
    }
    
}
