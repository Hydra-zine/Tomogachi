//
//  ContentView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var store = LocationStore()
    @State private var selectedType: LocationType? = .home

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Type", selection: $selectedType) {
                    ForEach(LocationType.allCases, id: \.self) {
                        Text($0.rawValue.capitalized).tag(Optional($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                MapView(store: store, selectedType: $selectedType)
                    .frame(height: 400)

                LocationListView(store: store)
            }
            .navigationTitle("Tomogachi Destinations")
        }
    }
}

#Preview {
    ContentView()
}


