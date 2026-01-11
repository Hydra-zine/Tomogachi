//
//  MapView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    @ObservedObject var store: LocationStore
    @Binding var selectedType: LocationType?

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition(
            latitude: 37.7749,
            longitude: -122.4194,
            zoom: 14
        )

        let options = GMSMapViewOptions()
        options.camera = camera

        let mapView = GMSMapView(options: options)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()

        for location in store.locations {
            let marker = GMSMarker(position: location.coordinate)
            marker.icon = markerIcon(for: location.type)
            marker.map = mapView
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func markerIcon(for type: LocationType) -> UIImage? {
        let color: UIColor

        switch type {
        case .home:
            color = .blue
        case .school:
            color = .green
        case .work:
            color = .red
        }

        return GMSMarker.markerImage(with: color)
    }

    class Coordinator: NSObject, @preconcurrency GMSMapViewDelegate {
        let parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        @MainActor func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            guard let type = parent.selectedType else { return }

            let newLocation = SavedLocation(
                coordinate: coordinate,
                type: type
            )

            parent.store.add(newLocation)
        }
    }
}

