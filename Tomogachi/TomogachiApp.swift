//
//  TomogachiApp.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//

import SwiftUI
import GoogleMaps
import Foundation

@main
struct TomogachiApp: App {
    
    init() {
        let apiKey = Bundle.main.object(
            forInfoDictionaryKey: "GOOGLE_MAPS_API_KEY"
        ) as? String

        print("Google Maps API Key:", apiKey ?? "NOT FOUND")

        GMSServices.provideAPIKey(apiKey ?? "")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
