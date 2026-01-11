//
//  SleepView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import SwiftUI

struct SleepView: View {

    @ObservedObject var sleepManager: SleepManager
    let onConfirm: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 32) {

                Text("Tomogachi is Sleeping")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                if sleepManager.isSleepModeActive {
                    Text(formattedTime(sleepManager.remainingTime))
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)

                    Text("Time until wake-up")
                        .foregroundColor(.white.opacity(0.7))
                } else {
                    Text("Put your phone down.\nSee you in the morning.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))

                    Button {
                        onConfirm()
                    } label: {
                        Text("Put Tomogachi to Sleep")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .interactiveDismissDisabled(true) // cannot swipe away
    }

    private func formattedTime(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60

        if hours > 0 {
            return String(format: "%02dh %02dm", hours, minutes)
        } else {
            return String(format: "%02dm %02ds", minutes, seconds)
        }
    }
}
