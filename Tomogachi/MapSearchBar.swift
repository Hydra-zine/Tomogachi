//
//  MapSearchBar.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import SwiftUI

struct MapSearchBar: View {
    @Binding var query: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search address", text: $query)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.words)
                .disableAutocorrection(true)
                .onSubmit {
                    onSearch()
                }

            Button("Go") {
                onSearch()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
    }
}
