//
//  LocationStore.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//


import Foundation

@MainActor
class LocationStore: ObservableObject {
    @Published var locations: [SavedLocation] = [] {
        didSet { save() }
    }

    private let key = "saved_locations"

    init() { load() }

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

    private func save() {
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
}

