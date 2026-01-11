//
//  Loc.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//

import Foundation
import CoreLocation

enum LocationType: String, Codable, CaseIterable {
    case home
    case school
    case gym
}

struct SavedLocation: Identifiable, Codable {
    let id: UUID
    var latitude: Double
    var longitude: Double
    var type: LocationType
    var radius: Double   // meters

    init(
        coordinate: CLLocationCoordinate2D,
        type: LocationType,
        radius: Double = 100
    ) {
        self.id = UUID()
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.type = type
        self.radius = radius
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
