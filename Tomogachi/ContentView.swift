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
        VStack {
            Picker("Location Type", selection: $selectedType) {
                ForEach(LocationType.allCases, id: \.self) {
                    Text($0.rawValue.capitalized).tag(Optional($0))
                }
            }
            .pickerStyle(.segmented)
            .padding()

            MapView(store: store, selectedType: $selectedType)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}


