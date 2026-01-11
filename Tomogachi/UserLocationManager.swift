//
//  UserLocationManager.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import CoreLocation
import SwiftUI

@MainActor
final class UserLocationManager: NSObject, ObservableObject {

    private let manager = CLLocationManager()
    private let store: LocationStore

    @Published var currentLocation: CLLocation?

    // Track which locations we are currently inside
    private var activeLocationIDs: Set<UUID> = []

    init(store: LocationStore) {
        self.store = store
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }

    private func evaluateLocations(at location: CLLocation) {
        for saved in store.locations {

            let center = CLLocation(
                latitude: saved.coordinate.latitude,
                longitude: saved.coordinate.longitude
            )

            let distance = location.distance(from: center)
            let isInside = distance <= saved.radius
            let wasInside = activeLocationIDs.contains(saved.id)

            if isInside && !wasInside {
                activeLocationIDs.insert(saved.id)
                handleEnter(saved)
            }

            if !isInside && wasInside {
                activeLocationIDs.remove(saved.id)
                handleExit(saved)
            }
        }
    }
    func sendEventToTomogachi(event: String) {
        print("📤 Sending to Tomogachi:", event)

        // Example payload
        let payload = [
            "event": event,
            "timestamp": ISO8601DateFormatter().string(from: Date())
        ]

        // TODO:
        // - Send to Adafruit
        // - Or BLE
        // - Or HTTP
    }


    private func handleEnter(_ location: SavedLocation) {
        print("✅ Entered \(location.type.rawValue)")
        sendEventToTomogachi(
            event: "ENTER_\(location.type.rawValue.uppercased())"
        )
    }

    private func handleExit(_ location: SavedLocation) {
        print("🚪 Exited \(location.type.rawValue)")
        sendEventToTomogachi(
            event: "EXIT_\(location.type.rawValue.uppercased())"
        )
    }
}
extension UserLocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let latest = locations.last else { return }

        currentLocation = latest
        evaluateLocations(at: latest)
    }

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        if manager.authorizationStatus == .authorizedAlways ||
           manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
