//
//  APIModels.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//
import Foundation

struct APILocation: Codable {
    let id: String
    let type: String
    let lat: Double
    let lng: Double
    let radius: Double
}

struct LocationsPayload: Codable {
    let userId: String
    let locations: [APILocation]
}
