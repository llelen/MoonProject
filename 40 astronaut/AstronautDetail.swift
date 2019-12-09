//
//  AstronautDetail.swift
//  40 astronaut
//
//  Created by GayaneA on 11/19/19.
//  Copyright © 2019 ayanemay. All rights reserved.
//

import SwiftUI

struct AstronautDetail: View {
    
    var astronaut: Astronaut
    
    var body: some View {
        
        GeometryReader{geo in
            ScrollView(.vertical){
                VStack{
                    
                    Image(decorative: self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                     .frame(width: geo.size.width)
                    
                 //   Text("Flew on \(self.missionNames.joined(separator: " , "))"  )
                    Text("Flew on \(self.missionsPerAstro(ast: self.astronaut))")
                    
                    Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                    
                }.padding()
                
            }
            
            
        }.navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        
    }
    
    
    
    func missionsPerAstro(ast: Astronaut) -> String{
        
        var missionnames: [String] = []
        
        let missions: [Mission] = Bundle.main.decode(file: "missions.json")
        
        
        for mission in missions{
            for crew in mission.crew {
                if crew.name == ast.id{
                    missionnames.append("Apollo \(mission.id)")
                }
            }
        }
        
        
        return missionnames.joined(separator: " , ")
    }
    
    
    
}

struct AstronautDetail_Previews: PreviewProvider {
    
    static let astronauts:[Astronaut] = Bundle.main.decode(file: "astronauts.json")
    static let missionNames = 0
    
    static var previews: some View {
        AstronautDetail(astronaut: astronauts[0])
    }
}
