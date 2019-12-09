//
//  ContentView.swift
//  40 astronaut
//
//  Created by GayaneA on 11/18/19.
//  Copyright © 2019 ayanemay. All rights reserved.
//day 40

import SwiftUI

struct ContentView: View {
    
    //this was before making decode generic
   // let astronauts = Bundle.main.decode(file: "astronauts.json")
    //we must use type annotation for this, or swift will not know what is under generic
    @State var showNames = false
   
   @State var astronauts: [Astronaut] = Bundle.main.decode(file: "astronauts.json")
   @State var missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    var body: some View {
        NavigationView{
//opening missionView when selecting row
            
            List(missions){ m in
                NavigationLink(destination : MissionView(mission: m, astronauts: self.astronauts)  ) {
                    
                    Image(m.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading){
                        Text(m.displayName)
                        Text(self.showNames ? self.crewnames(mission: m) : m.dateString)
                    }
                }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text(!self.showNames ? "\(m.displayName) launched at  \(m.dateString)" : "\(m.displayName)   Crew was \(self.crewnames(mission: m))"))
                
                
                .navigationBarTitle("Moonsite")
                    .navigationBarItems(leading: Button(action:{self.showNames.toggle()}){
                        Text(self.showNames ?  "Show Mission Launchdate" : "Show Crew Names")
                    })
            }
        }
    }
    //challange show crewnames in first view list on button toggle
    func crewnames(mission: Mission) -> String{
        //create an array of from mission crew, that contens only names as strings
        let a = mission.crew.map{$0.name.capitalized}
        return a.joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
