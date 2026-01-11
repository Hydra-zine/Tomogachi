//
//  LocationStore.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class LocationStore: ObservableObject {

    @Published var locations: [SavedLocation] = []

    private let key = "saved_locations"
    private var cancellables = Set<AnyCancellable>()

    init() {
        load()
        setupObservers()
    }

    func add(_ location: SavedLocation) {
        locations.append(location)
    }

    func delete(_ location: SavedLocation) {
        locations.removeAll { $0.id == location.id }
    }

    func update(_ location: SavedLocation) {
        guard let index = locations.firstIndex(where: { $0.id == location.id }) else { return }
        locations[index] = location
    }

    func add(
        coordinate: CLLocationCoordinate2D,
        type: LocationType,
        radius: CLLocationDistance = 100
    ) {
        let location = SavedLocation(
            coordinate: coordinate,
            type: type,
            radius: radius
        )
        locations.append(location)
    }


    private func setupObservers() {
        $locations
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] newLocations in
                guard let self else { return }
                self.save(newLocations)
                Task {
                    await self.syncToAdafruit(newLocations)
                }
            }
            .store(in: &cancellables)
    }


    private func save(_ locations: [SavedLocation]) {
        guard let data = try? JSONEncoder().encode(locations) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode([SavedLocation].self, from: data)
        else { return }

        locations = decoded
    }
    
    private func buildLocationsPayload(
        locations: [SavedLocation]
    ) throws -> String {

        let hardwareLocations = locations.map { $0.toAPILocation() }
        let data = try JSONEncoder().encode(hardwareLocations)

        guard let json = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }

        return json
    }


    private func syncToAdafruit(_ locations: [SavedLocation]) async {
        do {
            let payload = try buildLocationsPayload(locations: locations)

            try await AdafruitClient.shared.sendValue(
                feed: "locations",
                value: payload
            )

            print("Synced \(locations.count) locations to Adafruit")
        } catch {
            print("Adafruit sync failed:", error)
        }
    }
}
