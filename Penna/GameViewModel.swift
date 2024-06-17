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
    
    func generateWordEnemy() -> String {
        let randomIndex = Int.random(in: 0..<sentences.count)
        let word = sentences[randomIndex]
        return word
    }

    
    
}
