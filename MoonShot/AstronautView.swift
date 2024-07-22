//
//  AstronautView.swift
//  MoonShot
//
//  Created by Jesutofunmi Adewole on 28/02/2024.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .padding(.bottom)
                    
                    Text(astronaut.description)
                        .padding(.horizontal)
                }
                .navigationTitle(astronaut.name)
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return AstronautView(astronaut: astronauts["chaffee"]!)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)

}
