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
        GMSServices.provideAPIKey("AIzaSyDJ6BdaR9yGsiIQLoGHE0BkzQwrOF92mSk")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
