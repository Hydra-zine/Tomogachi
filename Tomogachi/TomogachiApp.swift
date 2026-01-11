//
//  TomogachiApp.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct TomogachiApp: App {

    init() {
        let key = Bundle.main.object(
            forInfoDictionaryKey: "GOOGLE_MAPS_API_KEY"
        ) as! String

        GMSServices.provideAPIKey(key)
        GMSPlacesClient.provideAPIKey(key)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
