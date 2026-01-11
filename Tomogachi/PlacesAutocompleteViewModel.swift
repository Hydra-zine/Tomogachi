//
//  PlacesAutocompleteViewModel.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import Foundation
import GooglePlaces
import CoreLocation

class PlacesAutocompleteViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var predictions: [GMSAutocompletePrediction] = []

    private let client = GMSPlacesClient.shared()

    func updateQuery() {
        guard !query.isEmpty else {
            predictions = []
            return
        }

        let filter = GMSAutocompleteFilter()
        filter.types = [] // all places

        client.findAutocompletePredictions(
            fromQuery: query,
            filter: filter,
            sessionToken: nil
        ) { results, error in
            if let results = results {
                DispatchQueue.main.async {
                    self.predictions = results
                }
            }
        }
    }

    func selectPrediction(
        _ prediction: GMSAutocompletePrediction,
        completion: @escaping (CLLocationCoordinate2D) -> Void
    ) {
        let placeID = prediction.placeID

        let fields: GMSPlaceField = [.coordinate]

        client.fetchPlace(
            fromPlaceID: placeID,
            placeFields: fields,
            sessionToken: nil
        ) { place, error in
            guard let place = place else { return }

            DispatchQueue.main.async {
                completion(place.coordinate)
                self.predictions = []
                self.query = prediction.attributedPrimaryText.string
            }
        }
    }
}
