//
//  ContentView.swift
//  Weather
//
//  Created by Ilya Stoletov on 04.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cellsMatrix: [[Int]] = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
    ]
    
    @State private var currentAction: Int = 1
    
    @State private var winCombination: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Tic tac toe")
                ForEach(0..<3) { i in
                    HStack {
                        ForEach(0..<3) { j in
                            CellView(
                                iconToShow: $cellsMatrix[i][j]
                            ).onTapGesture {
                                if (!winCombination) {
                                    resolveCellClick(cellPositionX: i, cellPositionY: j)
                                }
                            }
                        }
                    }
                }
                Button(action: clearField) {
                    Text("Clear")
                }
                if winCombination == true {
                    Text("Game over! Restart to continue playing.")
                }
            }.padding()
        }
    }
    
    private func resolveCellClick(cellPositionX: Int, cellPositionY: Int) {
        if cellsMatrix[cellPositionX][cellPositionY] != 0 { return }
        
        cellsMatrix[cellPositionX][cellPositionY] = currentAction
        if currentAction == 1 {
            currentAction = 2
        } else {
            currentAction = 1
        }
        
        let winCombinationReached = WinResolver(cellsMatrix: cellsMatrix).checkWin()
        winCombination = winCombinationReached
    }
    
    private func clearField() {
        for i in 0..<3 {
            for j in 0..<3 {
                cellsMatrix[i][j] = 0
            }
        }
        winCombination = false
    }
    
}

struct CellView: View {
    
    @Binding var iconToShow: Int
    
    private let iconMap: [Int: String] = [0: "transparent", 1: "cross", 2: "circle"]
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(iconMap[iconToShow]!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48, height: 48)
        }.frame(width: 64, height: 64)
            .background(SwiftUI.Color.yellow)
            .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
