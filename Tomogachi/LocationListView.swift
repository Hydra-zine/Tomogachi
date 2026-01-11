//
//  LocationListView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import SwiftUI

struct LocationListView: View {
    @ObservedObject var store: LocationStore
    @State private var selected: SavedLocation?

    var body: some View {
        List {
            ForEach(store.locations) { location in
                Button {
                    selected = location
                } label: {
                    HStack {
                        Text(location.type.rawValue.capitalized)
                        Spacer()
                        Text("\(Int(location.radius))m")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onDelete { indexSet in
                indexSet
                    .map { store.locations[$0] }
                    .forEach(store.delete)
            }
        }
    }
}
