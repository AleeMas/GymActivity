//
//  TabCreatingView.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 13/05/24.
//

import SwiftUI

struct GymTabChoseTypeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var gymTabController:GymTabController
    @State private var view: GymTabInserting?
        
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                
                Image(systemName: "xmark")
                    .padding()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                
            }
            RoundedRectangle(cornerRadius: 8)
                    .fill(Color.green) // Imposta il colore di riempimento
                    .frame(width: 150, height: 75) // Imposta le dimensioni
                    .shadow(color: Color.gray.opacity(0.6), radius: 2, x: 4, y: 4) // Aggiungi un'ombra verde
                    .overlay(
                        Text("Tab") // Testo al centro del rettangolo
                            .foregroundColor(.white) // Colore del testo
                            .font(.headline) // Imposta il font
                            
                    ).onTapGesture {
                        
                        view = GymTabInserting(presentationMode: _presentationMode, circuit:false , scheda: true, gymTabController: gymTabController)
                        gymTabController.inserting = true
                    }
                    
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.green) // Imposta il colore di riempimento
                .frame(width: 150, height: 75) // Imposta le dimensioni
                .shadow(color: Color.gray.opacity(0.6), radius: 2, x: 4, y: 4) // Aggiungi un'ombra a destra e sotto
                .padding()
                .overlay(
                    Text("Circuit") // Testo al centro del rettangolo
                        .foregroundColor(.white) // Colore del testo
                        .font(.headline) // Imposta il font
                )
                .onTapGesture {
                    view = GymTabInserting(presentationMode: _presentationMode, circuit: true, scheda: false, gymTabController: gymTabController)
                    gymTabController.inserting = true
                }
            Text("")
            //alza per spostarlo su abbassa per spostarlo giu
            }
        .fullScreenCover(isPresented: $gymTabController.inserting) {
            view
        }.onChange(of: gymTabController.inserting) { newValue in
            if newValue {
                gymTabController.tabs.addTab(Tab())
            }
            else{
                gymTabController.tabs.removeLastTab()
            }
        }
            
        }
}



