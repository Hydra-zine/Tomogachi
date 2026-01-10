//
//  LocationFile.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//

import Foundation

enum LocationType: String, CaseIterable, Identifiable {
    case home = "home"
    case work = "work"
    case school = "school"
    
    var id: String{
        rawValue
    }
}
