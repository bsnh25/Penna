//
//  DrawingViewController.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 16/06/24.
//

import UIKit
import PencilKit
import SpriteKit

class DrawingViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    var canvasView = PKCanvasView()
    var toolPicker = PKToolPicker()
    var canvasHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup canvas view
        canvasHeight = view.bounds.height*1/3
        
        canvasView.frame = CGRect(x: 0, y: view.bounds.height - (canvasHeight ?? view.bounds.height*1/3), width: view.bounds.width, height: canvasHeight ?? view.bounds.height*1/3)
        
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        
        view.addSubview(canvasView)
        
        // Setup tool picker
        if let window = view.window, let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            toolPicker.addObserver(self)
            canvasView.becomeFirstResponder()
        }
    }
    
    // Handle PencilKit events if needed
}

