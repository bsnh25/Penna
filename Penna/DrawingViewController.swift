//
//  DrawingViewController.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 16/06/24.
//

import UIKit
import PencilKit
import SpriteKit

class DrawingViewController: UIViewController, PKCanvasViewDelegate {
    
    
    var gameVM = GameViewModel()
    weak var delegate : ShootProtocol?
    let canvasView = PKCanvasView()
    var canvasHeight: CGFloat?
    var hiddenTextField: UITextField?
    var scoreLabel: UILabel?
    var enemy: [String] = []
    
    
    let canvasViewID = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameVM.setupSentences()
        // Setup canvas view
        canvasHeight = view.bounds.height*1/3
        
        canvasView.frame = CGRect(x: 0, y: view.bounds.height - (canvasHeight ?? view.bounds.height*1/3), width: view.bounds.width, height: canvasHeight ?? view.bounds.height*1/3)
        
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .pencilOnly
        
        view.addSubview(canvasView)
        
        
        let indirectScribbleInteraction = UIIndirectScribbleInteraction(delegate: self)
        canvasView.addInteraction(indirectScribbleInteraction)
        updateWritingState(with: .standBy)
        
        setupHiddenTextField(in: view)
        scoreLabel(in: view)
    }
    
    func setupHiddenTextField(in view: UIView) {
        hiddenTextField = UITextField(frame: CGRect(x: 50, y: 0, width: 300, height: 40))
        hiddenTextField?.text = ""
        hiddenTextField?.font = .systemFont(ofSize: 50)
        hiddenTextField?.backgroundColor = .blue
        hiddenTextField?.autocapitalizationType = .none
        hiddenTextField?.keyboardType = .alphabet
        hiddenTextField?.autocorrectionType = .no
        hiddenTextField?.alpha = 1
        
        if let subView = hiddenTextField {
            view.addSubview(subView)
            // Menambahkan target untuk peristiwa editingChanged
            subView.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    func scoreLabel(in view: UIView){
        scoreLabel = UILabel(frame: CGRect(x: Int(view.bounds.width-100), y: 0, width: 200, height: 40))
        scoreLabel?.text = "Score \(gameVM.currentScore)"
        scoreLabel?.font = .systemFont(ofSize: 20)
        scoreLabel?.backgroundColor = .blue
        scoreLabel?.alpha = 1
        
        if let subView = scoreLabel {
            view.addSubview(subView)
        }
    }
    
    @objc
    func handleTextFieldDidChange(_ textField: UITextField) {
        print("Written text: \(textField.text ?? "")")
    }
    
    
    private func updateWritingState(with state: WritingStateEnum) {
        gameVM.writingState = state
        
        switch gameVM.writingState {
        case .standBy:
            canvasView.backgroundColor = .blue
        case .isWriting:
            canvasView.backgroundColor = .yellow
        case .didFinishWriting:
            canvasView.backgroundColor = .green
        }
    }
    
    private func shootTheText() {
        guard let theText = hiddenTextField?.text else {
            print("Hidden text field is nil or empty")
            return
        }
        gameVM.removeEnemy(for: theText)
        refreshScore()
    }
    
    private func refreshScore() {
        scoreLabel?.text = "Correct: \(gameVM.currentScore)"
    }
    
}

extension DrawingViewController: UIIndirectScribbleInteractionDelegate {
    func indirectScribbleInteraction(_ interaction: any UIInteraction, requestElementsIn rect: CGRect, completion: @escaping ([String]) -> Void) {
        completion([canvasViewID])
    }
    
    func indirectScribbleInteraction(_ interaction: any UIInteraction, isElementFocused elementIdentifier: String) -> Bool {
        return elementIdentifier == canvasViewID
    }
    
    func indirectScribbleInteraction(_ interaction: any UIInteraction, frameForElement elementIdentifier: String) -> CGRect {
        return canvasView.bounds
    }
    
    func indirectScribbleInteraction(_ interaction: any UIInteraction, focusElementIfNeeded elementIdentifier: String, referencePoint focusReferencePoint: CGPoint, completion: @escaping ((any UIResponder & UITextInput)?) -> Void) {
        print("is writing...")
        updateWritingState(with: .isWriting)
        hiddenTextField?.text = ""
        completion(hiddenTextField)
        print(hiddenTextField ?? "")
    }
    
    func indirectScribbleInteraction(_ interaction: any UIInteraction, didFinishWritingInElement elementIdentifier: String) {
        print("did finish writing...")
        
        updateWritingState(with: .didFinishWriting)
        shootTheText()
    }
}
