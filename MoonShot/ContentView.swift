//
//  ContentView.swift
//  MoonShot
//
//  Created by Jesutofunmi Adewole on 27/02/2024.
//

import SwiftUI

struct ContentView: View {
        
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid (columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink(value: mission, label: {
                            VStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .fontWeight(.semibold)
                                    Text(mission.formattedLaunchDate)
                                }
                                .foregroundStyle(.white)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        })
                    }
                }
                
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
                .navigationDestination(for: Astronaut.self) { astronaut in
                    AstronautView(astronaut: astronaut)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
