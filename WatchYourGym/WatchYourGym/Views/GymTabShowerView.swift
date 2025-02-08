//  ExerciseForm.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 14/05/24.
//

import SwiftUI
import Foundation


struct GymTabShowerView: View {
    @ObservedObject var gymTabController:GymTabController
    @ObservedObject var changing:DataChanging
    @State private var showingEditView = -1
    
    
    var body: some View {
        Text("Workout")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading) // Allinea il testo a sinistra
            .padding([.top, .leading, .trailing]) // Applica il padding in alto, a sinistra e a destra
        List{
            ForEach(Array(gymTabController.tabs.tab.enumerated()), id: \.1.id) { index, tab in
                NavigationLink(destination: VisuWOView(gymTabController: gymTabController, tabIndex: index)) {
                    //è utile avere index per sapere dopo quale dei tab vuole essere modificato
                    HStack {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 5) // La larghezza della barretta
                        
                        VStack(alignment: .leading) {
                            Text(tab.getName())
                                .font(.headline)
                            
                            Text(tab.getType())
                                .font(.subheadline)
                                .foregroundColor(Color(white: 0.3))
                            Text("Volendo durata")
                                .font(.subheadline)
                                .foregroundColor(Color(white: 0.3))
                        }
                        .padding(.leading, 5) // Aggiunge un po' di spazio tra la barretta e il contenuto
                    }.cornerRadius(5)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.white)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        showingEditView = index
                    } label: {
                        Label("Modifica", systemImage: "pencil")
                    }.tint(.blue)
                    
                    Button {
                        //METTI L'ALLERT SEI SICURO DI VOLER ELIMINARE?
                        gymTabController.tabs.tab.remove(at: index)
                        gymTabController.reLoadFile()
                        changing.changing += 1
                        gymTabController.tabs.index -= 1
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                        
                    }.tint(.red)
                }
            }
            
        }
        .listStyle(PlainListStyle())
        .background(Color .white)
        //apriamo l'overlay in caso siamo in modifica
        //
        .overlay(
            Group {
                if(showingEditView != -1){
                    ZStack{
                        Color.black.opacity(0.8)
                        VStack{
                            HStack {
                                Text("Back")
                                    .padding()
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        showingEditView = -1
                                    }
                                Spacer()
                                TextField("\(gymTabController.tabs.tab[showingEditView].getType()) Name", text: Binding<String>(
                                    get: {gymTabController.tabs.tab[showingEditView].getName()},
                                    set: {gymTabController.tabs.tab[showingEditView].setName(setter: $0)}
                                )).greyTab()
                                Spacer()
                                Text("Save")
                                    .padding()
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        gymTabController.reLoadFile()
                                        showingEditView = -1
                                    }
                            }
                            
                            ScrollView {
                                if (gymTabController.tabs.tab[showingEditView].getType() == "Circuit")
                                {
                                    VStack{
                                        //Nel tab di modifica questa prima parte printa le informazioni iniziali
                                        //cioè le informazioni che vengono riportate più di una volta anche se ci sono più esericiz
                                        ModifyCircuitInfoView(
                                            gymTabController: gymTabController,
                                            indiceTab: showingEditView
                                        ).padding(.horizontal)
                                        
                                        ForEach(0..<gymTabController.tabs.tab[showingEditView].exercises.count, id: \.self) { exerciseIndex in
                                            
                                            ModifyCircuitExeriseInfoView(
                                                gymTabController: gymTabController,
                                                indiceTab: showingEditView,
                                                indiceExe: exerciseIndex
                                            )
                                        }
                                    }
                                }
                                else
                                {
                                    VStack{
                                        //questo printa solo le info della scheda
                                        ModifyTabInfoView(
                                            gymTabController: gymTabController,
                                            indiceTab: showingEditView
                                        )
                                        ForEach(0..<gymTabController.tabs.tab[showingEditView].exercises.count, id: \.self) { exerciseIndex in
                                            
                                            ModifyTabExeriseInfoView(
                                                gymTabController: gymTabController,
                                                indiceTab: showingEditView,
                                                indiceExe: exerciseIndex
                                            )
                                        }
                                    }
                                }
                            }
                        }.editing()
                }
            }
            })
    }
}
