//
//  Missions.swift
//  MoonShot
//
//  Created by Jesutofunmi Adewole on 27/02/2024.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    
    struct CrewMember: Hashable, Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewMember]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "Didn't Launch"
    }
    
}


