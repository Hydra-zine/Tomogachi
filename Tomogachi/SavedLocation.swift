//
//  Loc.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//

import Foundation
import CoreLocation

enum LocationType: String, Codable, CaseIterable, Identifiable{
    case home = "home"
    case school = "school"
    case work = "work"
    
    var id: String { rawValue }
    
}

struct SavedLocation: Identifiable, Codable {
    let id: UUID
    let latitude: Double
    let longitude: Double
    let type: LocationType

    init(coordinate: CLLocationCoordinate2D, type: LocationType) {
        self.id = UUID()
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.type = type
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
