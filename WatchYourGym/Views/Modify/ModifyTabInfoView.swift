//
//  ExerciseForm.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 14/05/24.
//

import SwiftUI

struct ModifyTabInfoView: View {
    @ObservedObject var gymTabController:GymTabController
    @State var indiceTab:Int
    
    @State private var selectedOption = 0
    
    
    @State var optionTypeChose: Int = 0
    private let optionsType = ["Tab", "Circuit"]
    
    
    var body: some View {
            
            //info della scheda nome, tipo, rest tra gli es
            // nel circuito anche il numero di set è una informazione della scheda
            
            
            HStack{
                Picker("Select Option", selection: $optionTypeChose) {
                                ForEach(0..<optionsType.count, id: \.self) { index in
                                    Text(self.optionsType[index])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .clipped()
                            .shadow(radius: 2)
                            .onChange(of: optionTypeChose) { newValue in
                                            // Chiama il metodo di set con il nuovo valore selezionato
                                gymTabController.tabs.tab[indiceTab].setType(setter: optionsType[optionTypeChose])
                        }
                }
                
            HStack{
                Text("Rest betwin exercise")
                Picker("Time", selection: Binding<Int>(
                    get: { gymTabController.getTabRest(ind: indiceTab)},
                    set: { gymTabController.setTabRest(ind:indiceTab,setter: $0)}
                )) {
                    ForEach(0..<305, id: \.self) { i in
                        if i % 5 == 0 {
                            let minutes = i / 60
                            let seconds = i % 60
                            Text(String(format: "%02d:%02d", minutes, seconds)).tag(i)
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 60)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
            }
    }
}
