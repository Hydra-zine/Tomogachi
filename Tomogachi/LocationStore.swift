//
//  LocationStore.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//


import Foundation
import CoreLocation

final class LocationStore: ObservableObject {
    @Published var school: CLLocationCoordinate2D?
    @Published var work: CLLocationCoordinate2D?
    @Published var home: CLLocationCoordinate2D?
}
