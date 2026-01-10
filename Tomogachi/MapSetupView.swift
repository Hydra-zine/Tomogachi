//
//  MapSetupView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//

import SwiftUI
import CoreLocation

struct MapSetupView: View {

    @EnvironmentObject var locationStore: LocationStore

    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var selectedType: LocationType = .school

    var body: some View {
        VStack(spacing: 12) {

            Text("Set Your Locations")
                .font(.title)
                .fontWeight(.bold)

            Picker("Location Type", selection: $selectedType) {
                ForEach(LocationType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            GoogleMapView(selectedCoordinate: $selectedCoordinate)
                .frame(height: 350)
                .cornerRadius(12)
                .padding()

            Button("Save Location") {
                saveLocation()
            }
            .disabled(selectedCoordinate == nil)
            .buttonStyle(.borderedProminent)

            Spacer()
        }
    }

    private func saveLocation() {
        guard let coordinate = selectedCoordinate else { return }

        switch selectedType {
        case .school:
            locationStore.school = coordinate
        case .work:
            locationStore.work = coordinate
        case .home:
            locationStore.home = coordinate
        }

        selectedCoordinate = nil
    }
}
