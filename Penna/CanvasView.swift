//
//  CanvasView.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 15/06/24.
//

import SwiftUI
import SpriteKit

struct CanvasView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 1133, height: 744)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack(alignment: .center){
            SpriteView(scene: scene)
                .frame(maxWidth: .infinity, maxHeight: 700)
                .border(.red)
            ZStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .padding(.top, -10)
                Text("Ini Canvas buat gambar")
                    .foregroundStyle(.white)
            }
            
            
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CanvasView()
}
