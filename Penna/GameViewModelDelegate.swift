//
//  GameViewModelDelegate.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 18/06/24.
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func arrWordEnemyDidUpdate(newValue: [String])
}

