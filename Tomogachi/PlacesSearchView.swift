//
//  PlacesSearchView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import SwiftUI
import GooglePlaces

struct PlacesSearchView: View {
    @ObservedObject var viewModel: PlacesAutocompleteViewModel
    var onSelect: (CLLocationCoordinate2D) -> Void
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0){
                TextField("Search for a place", text: $viewModel.query)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .onChange(of: viewModel.query) {
                        viewModel.updateQuery()
                    }
            }

            if !viewModel.predictions.isEmpty {
                List(viewModel.predictions, id: \.placeID) { prediction in
                    Button {
                        viewModel.selectPrediction(prediction) { coordinate in
                            onSelect(coordinate)
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            Text(prediction.attributedPrimaryText.string)
                                .font(.body)
                            Text(prediction.attributedSecondaryText?.string ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(maxHeight: 200)
            }
        }
    }
}
