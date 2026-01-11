//
//  HomeView.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-10.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack (spacing: 20){
            Text("TamaGO").font(.largeTitle).fontWeight(.bold)
            
            HStack(spacing:50){
                Button(action: {
                    print("Fed alien")
                }) {
                    Text("Feed Alien")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
            }
        }
        .padding()
    }
}


