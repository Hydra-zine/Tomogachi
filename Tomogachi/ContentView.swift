//
//  ContentView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var locationStore = LocationStore()

    var body: some View {
        MapSetupView()
            .environmentObject(locationStore)
    }
}

#Preview {
    ContentView()
}


