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
        GMSServices.provideAPIKey()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
