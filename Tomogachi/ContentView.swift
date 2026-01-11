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
    @StateObject private var sleepManager = SleepManager()
    @State private var showSleepScreen = false
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var userLocationManager: UserLocationManager

    init() {
        let store = LocationStore()
        _locationStore = StateObject(wrappedValue: store)
        _userLocationManager = StateObject(
            wrappedValue: UserLocationManager(store: store)
        )
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            AdafruitTestView()
                .tabItem {
                    Label("Adafruit Test", systemImage: "square.and.arrow.up")
                }
            

            LocationsView(store: locationStore)
                .tabItem {
                    Label("Locations", systemImage: "map.fill")
                }
        }
        .fullScreenCover(isPresented: $showSleepScreen) {
            SleepView(
                sleepManager: sleepManager,
                onConfirm: {
                    sleepManager.startSleep()
                }
            )
        }
        .onAppear {
            if sleepManager.isWithinSleepWindow() {
                showSleepScreen = true
            }
        }

        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background && sleepManager.isSleepModeActive {
                sleepManager.wakeUp(reason: "Left app during sleep")
            }
        }

    }
}


#Preview {
    ContentView()
}


