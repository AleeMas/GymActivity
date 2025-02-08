//
//  GymTabView.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 03/05/24.
//

import SwiftUI
import Foundation

struct GymTabView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var user: User
    @ObservedObject var gymTabController: GymTabController
    
    @State var view:GymTabShowerView?
    @StateObject var changin = DataChanging()
    
    
    init(user: User) {
        self.user = user
        self._gymTabController = ObservedObject(wrappedValue: GymTabController(user: user))
    }

    var body: some View {
            VStack {
                
                if !gymTabController.choosing{
                    // Se non ci sono schede, mostra la scritta di benvenuto e l'icona di aggiunta
                    Text(gymTabController.welcomeText)
                        .onAppear{
                            gymTabController.setWelcomeText()
                           
                        }
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding()
                    
                    Image(systemName: "plus.circle.fill")
                        .onTapGesture {
                            gymTabController.isAddingTab = true
                        }
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .padding()
                }
                else
                {
                    // Se ci sono schede, mostra le schede esistenti
                    view
                    
                    // Aggiungi un pulsante per aggiungere altre schede
                    HStack{
                        Text("Add workout")
                            .foregroundColor(.blue)
                            .padding()
                            .onTapGesture {
                                gymTabController.isAddingTab = true
                            }
                    }
                    .onChange(of: changin.changing) { newValue in
                        gymTabController.generateTabs()
                        view = GymTabShowerView(gymTabController: gymTabController,changing:changin)
                        
                        }
                    .onAppear{
                       gymTabController.generateTabs()
                       view = GymTabShowerView(gymTabController: gymTabController,changing:changin)
                    }
                }
            }
            .sheet(isPresented: $gymTabController.isAddingTab) {
                        GymTabChoseTypeView(gymTabController: gymTabController)
                            .presentationDetents([.fraction(0.35)]) // Imposta la proporzione dell'altezza della sheet
                    }
        }
        
}
