//
//  GameViewModel.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 17/06/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var sentences: [String] = []
    @Published var currentLevel: LevelDictionaryEnum = .level_1
    @Published var currentStrokeType: StrokeType = .oneStroke
    @Published var currentScore: Int = 0
    @Published var maximumWord: Int = 0
    @Published var arrWordEnemy: [String] = []
    @Published var isContinueLevel: Bool = false
    var word: String = ""
    var gameTimer: Timer?
    var writingState: WritingStateEnum = .standBy
    
    func setupSentences() {
        switch currentLevel {
        case .level_1, .level_3, .level_4, .level_5, .level_6:
            sentences = currentLevel.term
        case .level_2:
            sentences = currentLevel.terms(for: currentStrokeType)
        }
    }

    func setupMaxPoint() {
        switch currentLevel {
        case .level_1, .level_2, .level_3, .level_4, .level_5, .level_6:
            maximumWord = currentLevel.maxScore
        }
    }
    
    func generateWordEnemy() -> String {
        let randomIndex = Int.random(in: 0..<sentences.count)
        word = sentences[randomIndex]
        arrWordEnemy.append(word)
        return word
    }
    
    func refreshWordEnemy(completion: @escaping ([String]) -> Void) {
        completion(arrWordEnemy)
    }
    
    func removeEnemy(for enemy: String) {
        print("Attempting to shoot text: \(enemy)")
        print("enemy array: \(arrWordEnemy)")
        
        if arrWordEnemy.contains(enemy) {
            print("Found \(enemy) in array")
            arrWordEnemy.removeAll { $0 == enemy }
            currentScore += 1
            print("Current score: \(currentScore)")
        } else {
            print("\(enemy) not found in sentences")
        }
    }
    
    func continueLevel(){
        if currentScore > (maximumWord * 2/3){
            isContinueLevel = true
        } else {
            isContinueLevel = false
        }
    }
    
    
    
}
