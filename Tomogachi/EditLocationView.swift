//
//  EditLocationView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//
import SwiftUI

struct EditLocationView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: LocationStore
    @State var location: SavedLocation

    var body: some View {
        Form {
            Picker("Type", selection: $location.type) {
                ForEach(LocationType.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }

            VStack {
                Text("Radius: \(Int(location.radius))m")
                Slider(value: $location.radius, in: 50...500, step: 10)
            }

            Button("Save") {
                store.update(location)
                dismiss()
            }
            
            Button("Delete Location", role: .destructive) {
                store.delete(location)
                dismiss()
            }

        }
        .navigationTitle("Edit Location")
    }
}
