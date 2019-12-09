//
//  Astronaut.swift
//  40 astronaut
//
//  Created by GayaneA on 11/18/19.
//  Copyright © 2019 ayanemay. All rights reserved.
//

import Foundation

struct Astronaut : Codable, Identifiable{
    var id: String
    var name: String
    var description: String
}



//the structs for mission.json, because we use struct CrewRole only for struct Mission, we could put it in it to make code neat
struct Mission: Codable, Identifiable{
    struct CrewRole :Codable{
        var name: String
        var role: String
    }
    
    var id: Int
    var launchDate: Date?
    var crew: [CrewRole]
    var description: String
    
    var image: String {
        "apollo\(id)"
    }
    
    var displayName: String {
        "Apollo\(id)"
    }
    
    var dateString:String{
        let df = DateFormatter()
        df.dateStyle = .long
        if let launchDate = launchDate{
            return df.string(from: launchDate)
        }
        else {
            return "A/N"
        }
       
}
}

