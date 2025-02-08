//
//  ExerciseForm.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 25/05/24.
//

import SwiftUI

struct ExerciseCircuitFormView: View {
    @ObservedObject var gymTabController:GymTabController
    @State var indiceExe:Int
    @State var indiceTab:Int

    @State private var selectedOption = 0

   
    
    @State var timeIndex: Int = 0
    private let options = ["Reps", "Seconds"]
    
    var body: some View {
    
        
       
        VStack {
            Text("Exercise:")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            TextField("Muscle Name", text: Binding<String>(
                get: {gymTabController.getSingleMuscleName(indExe: indiceExe,indiceTab: indiceTab)},
                set: {gymTabController.setSingleMuscleName(indExe:indiceExe,indiceTab: indiceTab,setter:$0)}
            )).greyTab()
            
            TextField("Exsercise Name", text: Binding<String>(
                get: {gymTabController.getExerciseName(indExe: indiceExe,indiceTab: indiceTab)},
                set: {gymTabController.setExerciseName(indExe:indiceExe,indiceTab: indiceTab,setter:$0)}
            )).greyTab()
            
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
            
           
            
            HStack{
                TextField("\(options[selectedOption])", text: Binding<String>(
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
                  .keyboardType(.numberPad)
                
                Picker("Select Option", selection: $selectedOption) {
                                ForEach(0..<options.count, id: \.self) { index in
                                    Text(self.options[index])
                                }
                                
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .shadow(radius: 4)
                            .onChange(of: selectedOption) { newValue in
                                            // Chiama il metodo di set con il nuovo valore selezionato
                                            gymTabController.setExerciseTypeOfReps(indExe: indiceExe,indiceTab: indiceTab, setter: newValue)
                                        }
                
            }
            
            TextEditor(text: Binding<String>(
                get: {gymTabController.getExerciseNote(indExe: indiceExe,indiceTab: indiceTab)},
                set: {gymTabController.setExerciseNote(indExe:indiceExe,indiceTab: indiceTab,setter:$0)}
            ))
            .note()
            
            HStack{
                Text("Rest for exercise")
                Picker("Time", selection: Binding<Int>(
                    get: { gymTabController.getExerciseRest(indExe: indiceExe,indiceTab: indiceTab) },
                    set: { gymTabController.setExerciseRest(indExe: indiceExe,indiceTab: indiceTab, setter: $0) }
                )){
                    ForEach(0..<305, id: \.self) { i in
                        if i % 5 == 0 {
                            let minutes = i / 60
                            let seconds = i % 60
                            Text(String(format: "%02d:%02d", minutes, seconds)).tag(i)
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .shadow(radius: 4)
                .frame(width: 80, height: 60)
            }
            
           
        }
        .padding()
        
    }
}

