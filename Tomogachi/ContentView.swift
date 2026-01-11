//
//  ContentView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//


import SwiftUI
import GoogleMaps
import CoreLocation



import SwiftUI

struct ContentView: View {
    @StateObject private var locationStore = LocationStore()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            LocationsView(store: locationStore)
                .tabItem {
                    Label("Locations", systemImage: "map.fill")
                }
        }
    }
}


#Preview {
    ContentView()
}


