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
    @Binding var searchCoordinate: CLLocationCoordinate2D?


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
    
    func circleColor(for type: LocationType) -> UIColor {
        switch type {
        case .home: return .blue
        case .school: return .green
        case .gym: return .red
        }
    }
    
    

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()

        // Saved locations
        for location in store.locations {
            let marker = GMSMarker(position: location.coordinate)
            marker.icon = markerIcon(for: location.type)
            marker.map = mapView

            let circle = GMSCircle(
                position: location.coordinate,
                radius: location.radius
            )
            circle.fillColor = circleColor(for: location.type).withAlphaComponent(0.15)
            circle.strokeColor = circleColor(for: location.type)
            circle.strokeWidth = 1
            circle.map = mapView
        }

        // Temporary search pin
        if let coord = searchCoordinate {
            let marker = GMSMarker(position: coord)
            marker.icon = GMSMarker.markerImage(with: .purple)
            marker.title = "Search Result"
            marker.map = mapView

            let camera = GMSCameraPosition(
                latitude: coord.latitude,
                longitude: coord.longitude,
                zoom: 15
            )

            mapView.animate(to: camera)
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
        case .gym:
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

