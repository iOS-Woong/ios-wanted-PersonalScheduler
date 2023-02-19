//
//  ReverseGeoCode.swift
//  PersonalScheduler
//
//  Created by 서현웅 on 2023/02/19.
//

import Foundation

struct ReverseGeoCode: Codable {
    let results: [Results]
}

struct Results: Codable {
    let region: Region
    let land: Land?
}

struct Land: Codable {
    let type, number1, number2: String
    let name: String?
}

struct Region: Codable {
    let area0: Area
    let area1: Area1
    let area2, area3, area4: Area
}

struct Area: Codable {
    let name: String
}

struct Area1: Codable {
    let name: String
    let alias: String
}
