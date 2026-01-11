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

import CoreLocation

struct SavedLocation: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let type: LocationType

    init(
        id: UUID = UUID(),
        coordinate: CLLocationCoordinate2D,
        radius: CLLocationDistance = 100,
        type: LocationType
    ) {
        self.id = id
        self.coordinate = coordinate
        self.radius = radius
        self.type = type
    }
}


extension SavedLocation {
    func toAPILocation() -> APILocation {
        APILocation(
            id: id.uuidString,
            type: type.rawValue,
            lat: coordinate.latitude,
            lng: coordinate.longitude,
            radius: radius
        )
    }
}

