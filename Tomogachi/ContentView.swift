//
//  ContentView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//


import SwiftUI
import GoogleMaps
import CoreLocation




struct ContentView: View {
    @StateObject private var store = LocationStore()
    @StateObject private var placesVM = PlacesAutocompleteViewModel()
    @State private var searchCoordinate: CLLocationCoordinate2D?

    @State private var selectedType: LocationType? = .home

    @State private var searchQuery = ""
    
    func searchAddress() {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(searchQuery) { placemarks, error in
            guard
                error == nil,
                let placemark = placemarks?.first,
                let location = placemark.location
            else {
                print("Geocoding failed")
                return
            }

            DispatchQueue.main.async {
                self.searchCoordinate = location.coordinate
            }
        }
    }
    
    func confirmSearchLocation() {
        guard
            let coordinate = searchCoordinate,
            let type = selectedType
        else { return }

        store.add(
            coordinate: coordinate,
            type: type
        )

        // Clear temporary pin after saving
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


#Preview {
    ContentView()
}


