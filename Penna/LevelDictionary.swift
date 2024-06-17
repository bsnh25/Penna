//
//  LevelDictionaryEnum.swift
//  Penna
//
//  Created by Bayu Septyan Nur Hidayat on 16/06/24.
//

import Foundation

enum LevelDictionaryEnum: Int16, CaseIterable {
    case level_1
    case level_2
    case level_3
    case level_4
    case level_5
    case level_6
    
    var term: [String] {
        switch self {
        case .level_1:
            return [
                "Aa","Bb","Dd","Ee","Ff","Gg","Hh","Ii","Jj","Ll","Mm","Nn",
                "Qq","Rr","Tt","Yy"
            ]
        case .level_2:
            return []
        case .level_3:
            return [
                "Tegangan", "Hambatan", "Komponen", "Paralel", "Pasif", "Aktif", "Teknik", "Kating", "Pemetaan", "Proyek",
                "Bangunan", "Ukuran", "Energi", "Adukan", "Angker", "Kabel", "Dowel", "Agregat", "Acuan", "Bahan", "Beban",
                "Galat", "Jaringan", "Memori", "Bang", "Kating", "Dosen", "Software", "ERD", "Loss", "Web", "VSCode", "Dataset",
                "Energi", "Biner", "Korosi", "Ide", "Mekanika", "Database", "Komputer", "Algoritma", "Kopling", "Usaha", "Geometri",
                "Volt", "Ampere", "Vektor", "Mekanis", "Turbin", "Saklar", "Presisi", "Diskrit", "Akurasi", "Kecepatan", "Simulasi",
                "Abrasi", "Robotika", "Torsi", "Resistor", "Tendon", "Tekanan", "Struktur", "Daya", "Pondasi", "Pascal", "Mortar",
                "Neutron", "Momen", "Mesin", "Komposit", "Gaya", "Geser", "Gambar", "Defleksi", "Rekayasa"
            ]
        case .level_4:
            return []
        case .level_5:
            return []
        case .level_6:
            return []
        }
    }
    
    func terms(for strokeType: StrokeType) -> [String] {
        switch self {
        case .level_2:
            switch strokeType {
            case .oneStroke:
                return ["LV", "VU", "WZ", "ZC", "OS", "OC"]
            case .twoStroke:
                return ["BD", "JK", "MN", "PQ", "QR", "TX", "YG", "RT"]
            case .threeStroke:
                return ["AE", "FH", "AF", "AH", "FA", "FE"]
            }
        default:
            return []
        }
    }
}

enum StrokeType: String, CaseIterable {
    case oneStroke
    case twoStroke
    case threeStroke
}
