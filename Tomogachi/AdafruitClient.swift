//
//  AdafruitClient.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import Foundation

struct AdafruitResponse: Codable {
    let value: String
}

final class AdafruitClient {
    static let shared = AdafruitClient()
    private init() {}

    private let username = "rsooknanan"
    private let apiKey = "API_KEY"
    private let feed = "espcommunicator"

    func sendValue(
        feed: String,
        value: String
    ) async throws {

        let url = URL(
            string: "https://io.adafruit.com/api/v2/rsooknanan/feeds/espcommunicator/data"
        )!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "X-AIO-Key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["value": value]
        request.httpBody = try JSONEncoder().encode(body)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              http.statusCode == 200 || http.statusCode == 201
        else {
            throw URLError(.badServerResponse)
        }
    }
    
    func sendLocationsToAdafruit(store: LocationStore) async {
        let locations = await store.locations.map { $0.toAPILocation() }

        guard let data = try? JSONEncoder().encode(locations),
              let json = String(data: data, encoding: .utf8)
        else { return }

        try? await AdafruitClient.shared.sendValue(
            feed: "locations",
            value: json
        )
    }
    func fetchLatest(feed: String) async throws -> String {
        let url = URL(
            string: "https://io.adafruit.com/api/v2/rsooknanan/feeds/espcommunicator/data"
        )!

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-AIO-Key")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(AdafruitResponse.self, from: data)
        return decoded.value
    }

}




