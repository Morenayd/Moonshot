//
//  MissionView.swift
//  MoonShot
//
//  Created by Jesutofunmi Adewole on 28/02/2024.
//

import SwiftUI

struct CrewLayout: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { member in
                    NavigationLink (value: member.astronaut, label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 104, height: 72)
                                .clipShape(.rect(cornerRadius: 10))
                            
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(member.astronaut.name)
                                Text(member.role)
                            }
                            .foregroundStyle(.white)
                            .padding(.trailing)
                        }
                    })
                }
            }
            .navigationDestination(for: MissionView.CrewMember.self) { member in
                AstronautView(astronaut: member.astronaut)
            }
        }

    }
}

struct MissionView: View {
    struct CrewMember: Hashable {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                    fatalError("Missing \(member.name)")
                }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.6
                        }
                
                    VStack(alignment: .leading) {
                        Text("Launch date")
                            .font(.title.bold())
                        Text(mission.formattedLaunchDate)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                        
                        
                        Text("Crew Members")
                            .font(.title2.bold())
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                    CrewLayout(crew: crew)
                    }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
}


#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
   
    let missions: [Mission] = 
    Bundle.main.decode("missions.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
