//
//  LocationsView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import SwiftUI
import GoogleMaps
import CoreLocation

struct LocationsView: View {

    @ObservedObject var store: LocationStore

    @StateObject private var placesVM = PlacesAutocompleteViewModel()
    @State private var searchCoordinate: CLLocationCoordinate2D?
    @State private var selectedType: LocationType? = .home
    @State private var searchQuery = ""

    func confirmSearchLocation() {
        guard
            let coordinate = searchCoordinate,
            let type = selectedType
        else { return }

        store.add(
            coordinate: coordinate,
            type: type
        )

        searchCoordinate = nil
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {

                PlacesSearchView(viewModel: placesVM) { coordinate in
                    searchCoordinate = coordinate
                }

                Picker("Type", selection: $selectedType) {
                    ForEach(LocationType.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                            .tag(Optional($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                MapView(
                    store: store,
                    selectedType: $selectedType,
                    searchCoordinate: $searchCoordinate
                )
                .frame(height: 300)

                if searchCoordinate != nil {
                    Button {
                        confirmSearchLocation()
                    } label: {
                        Label("Save This Location", systemImage: "checkmark.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                }

                LocationListView(store: store)
            }
            .navigationTitle("TamaGO Destinations")
        }
    }
}
