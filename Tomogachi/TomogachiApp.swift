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
        GMSServices.provideAPIKey(ProcessInfo.processInfo.environment["API_KEY"]!)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
