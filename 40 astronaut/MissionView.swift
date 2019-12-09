//
//  MissionView.swift
//  40 astronaut
//
//  Created by GayaneA on 11/18/19.
//  Copyright © 2019 ayanemay. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    
    struct CrewMember{
        var role: String //from mission.crew[0].role
        var astro : Astronaut ///id=namestring, name-wholename, description
    }
    
    var role_Astro:[CrewMember] = []
    
    
   // let astronauts: [Astronout] = Bundle.main.decode(file: "astronauts.json")

    var mission: Mission
    //let astronouts:
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView{
                VStack{
                    
                    Image(decorative: self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                        
                    Text(self.mission.dateString ).font(.subheadline)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    Spacer(minLength: 25)
                    
                    
                    ForEach(self.role_Astro, id: \.role){ m in
                        NavigationLink(destination: AstronautDetail(astronaut: m.astro)){
                            
                        HStack{
                            Image(m.astro.id)
                            .resizable()
                            .frame(width:83, height: 60)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                            VStack(alignment: . leading){
                                Text(m.astro.name).font(.headline)
                                Text(m.role).foregroundColor(.secondary)
                            }.accessibilityElement(children: .ignore)
                                .accessibility(label: Text("Crew member \(m.astro.name)  \(m.role)"))
                            Spacer()
                        }.padding(.horizontal)
                        }
                    }.buttonStyle(PlainButtonStyle())
                    
                    //first vers, works, now lesson vers
                   /* ForEach(self.mission.crew, id: \.name){i in
                        HStack(alignment: .bottom){
                            Image(i.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            VStack(alignment: .leading){
                                Text("\( self.astronauts.filter{$0.id == i.name}.first!.name)")
                               // Text(i.name)
                                Text(i.role)
                                
                            }.padding().font(.headline)
                            Spacer()
                        }
                    }*/
                }
            }.navigationBarTitle(self.mission.displayName)
        }
        
    }

    
    
    
    init(mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        var matches = [CrewMember]()
        
        
        for i in mission.crew{
            if let match = astronauts.first(where: {$0.id == i.name}){
                ///match is the element of astronauts the correspondents on mission crew i name
               // missionNames.append("Apollo \(mission.id)")
                matches.append(CrewMember( role: i.role, astro: match))
            }
            else{
                fatalError("Missing member")
            }
        }
        self.role_Astro = matches
    }
    
}

struct MissionView_Previews: PreviewProvider {
   static let astronauts: [Astronaut] = Bundle.main.decode(file: "astronauts.json")

    static let missions:[Mission] = Bundle.main.decode(file: "missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts )
    }
}
