//
//  AdafruitTestView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import SwiftUI

struct AdafruitTestView: View {
    @State private var status = "Idle"

    var body: some View {
        VStack(spacing: 20) {
            Text("Adafruit Test")
                .font(.title)

            Text(status)
            
            HStack {
                Button("Sad Noise") {
                    Task {
                        await sendTest1()
                    }
                }.padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(3)

                Button("Happy Noise") {
                    Task {
                        await sendTest2()
                    }
                }.padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(3)

            }

        }
        .padding()
    }

    func sendTest1() async {
        status = "Sending..."
        do {
            try await AdafruitClient.shared.sendValue(
                feed: "fed",
                value: "0"
            )
            status = "✅ Sent successfully"
        } catch {
            status = "❌ Failed: \(error.localizedDescription)"
        }
    }
    
    func sendTest2() async {
        status = "Sending..."
        do {
            try await AdafruitClient.shared.sendValue(
                feed: "fed",
                value: "1"
            )
            status = "✅ Sent successfully"
        } catch {
            status = "❌ Failed: \(error.localizedDescription)"
        }
    }
}
