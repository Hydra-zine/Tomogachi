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

            Button("Send Test Data") {
                Task {
                    await sendTest()
                }
            }
        }
        .padding()
    }

    func sendTest() async {
        status = "Sending..."
        do {
            try await AdafruitClient.shared.sendValue(
                feed: "fed",
                value: "true"
            )
            status = "✅ Sent successfully"
        } catch {
            status = "❌ Failed: \(error.localizedDescription)"
        }
    }
}

#Preview {
    AdafruitTestView()
}
