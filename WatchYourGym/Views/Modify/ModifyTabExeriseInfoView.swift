//
//  ExerciseForm.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 14/05/24.
//

import SwiftUI

struct ModifyTabExeriseInfoView: View {
    @ObservedObject var gymTabController:GymTabController
    @State var indiceTab:Int
    @State var indiceExe:Int
    
    
    @State var optionTypeChose: Int = 0
    private let optionsType = ["Reps", "Seconds"]
    
    
    var body: some View {
        
        VStack {
            
            Text("Muscle name:").editingFieldNameVS()
            TextField("Muscle Name", text: Binding<String>(
                get: {gymTabController.getSingleMuscleName(indExe: indiceExe,indiceTab: indiceTab)},
                set: {gymTabController.setSingleMuscleName(indExe:indiceExe,indiceTab: indiceTab,setter:$0)}
            )).greyTab()
            
            Text("Exercise Name:").editingFieldNameVS()
            TextField("Exsercise Name", text: Binding<String>(
                get: {gymTabController.getExerciseName(indExe: indiceExe,indiceTab: indiceTab)},
                set: {gymTabController.setExerciseName(indExe:indiceExe,indiceTab: indiceTab,setter:$0)}
            )).greyTab()
            
            VStack{
                Text("Weights:").editingFieldNameVS()
                TextField("Kg", text: Binding<String>(
                    get: {
                        let kgs = gymTabController.getExerciseKg(indExe: indiceExe,indiceTab: indiceTab)
                        return kgs == 0 ? "" : "\(kgs)"
                    },
                    set: { newValue in
                        if let intValue = Int(newValue){
                            gymTabController.setExerciseKg(indExe:indiceExe,indiceTab: indiceTab,setter:intValue)}
                    }
                )).greyTab()
                    .keyboardType(.numberPad)
            }
            
            
            HStack{
                TextField("\(optionsType[optionTypeChose])", text: Binding<String>(
                    get: {
                        
                        let reps = gymTabController.getExerciseReps(indExe: indiceExe,indiceTab: indiceTab)
                        return reps == 0 ? "" : "\(reps)"
                    },
                    set: { newValue in
                        if let intValue = Int(newValue){
                            gymTabController.setExerciseReps(indExe:indiceExe,indiceTab: indiceTab,setter:intValue)
                        }
                    }
                )).greyTab()
                
                
                
                Picker("Select Option", selection: $optionTypeChose) {
                    ForEach(0..<optionsType.count, id: \.self) { index in
                        Text(self.optionsType[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .shadow(radius: 2)
                .onChange(of: optionTypeChose) { newValue in
                    // Chiama il metodo di set con il nuovo valore selezionato
                    gymTabController.setExerciseTypeOfReps(indExe: indiceExe,indiceTab: indiceTab, setter: newValue)
                }
                
            }
            
            Text("Note:").editingFieldNameVS()
            TextEditor(text: Binding<String>(
                get: {gymTabController.getExerciseNote(indExe: indiceExe,indiceTab: indiceTab)},
                set: {gymTabController.setExerciseNote(indExe:indiceExe,indiceTab: indiceTab,setter:$0)}
            )).note()
            
            VStack{
                Text("Sets:").editingFieldNameVS()
                TextField("Sets", text: Binding<String>(
                    get: {
                        let sets = gymTabController.getExerciseSets(indExe: indiceExe,indiceTab: indiceTab)
                        return sets == 0 ? "" : "\(sets)"
                    },
                    set: { newValue in
                        if let intValue = Int(newValue){
                            gymTabController.setExerciseSets(indExe: indiceExe,indiceTab: indiceTab,setter:intValue)}
                    }
                )).greyTab()
            }
            
            HStack{
                Text("Rest for exercise")
                Picker("Time", selection: Binding<Int>(
                    get: { gymTabController.getExerciseRest(indExe: indiceExe,indiceTab: indiceTab) },
                    set: { gymTabController.setExerciseRest(indExe: indiceExe,indiceTab: indiceTab, setter: $0) }
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
            }
        }
        .onAppear{
            optionTypeChose = gymTabController.getExerciseTypeOfReps(indExe: indiceExe, indiceTab: indiceTab)
        }
        .padding()
    }
}
