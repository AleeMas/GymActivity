//
//  GymTabInserting.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 13/05/24.
//

import SwiftUI

struct GymTabInserting: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var circuit : Bool
    
    @State private var showErrorPopup: Bool = false
    @State var scheda: Bool
    @ObservedObject var gymTabController: GymTabController
    
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var exerciseForms: [ExerciseFormView] = []
    @State private var exerciseFormsCircuit: [ExerciseCircuitFormView] = []
    @State private var exerciseFormsCircuitRestAndReps: [ExerciseFormsCircuitRestAndRepsView] = []
    
    @State var indiceExe = -1;
    @State var indiceTab = 0;
    @State private var buttonPressed = false
    
    // tab inizializza le info degli es e della cheda/circuito
    @State var tab = Tab()
    
    
    var body: some View {
        
            HStack{
                
                Text("Back")
                    .padding()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        exerciseForms.removeAll()
                        exerciseFormsCircuit.removeAll()
                        gymTabController.inserting = false
                    }
                
                Spacer()
                Text("\(gymTabController.printTitle(circuit:circuit)) info").bold()
                Spacer()
                
                Text("Save")

                    .alert("Insert obligatory field", isPresented: $showErrorPopup){}
                    .padding()
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if gymTabController.checkObligatory(indiceExe: indiceExe)
                        {
                            gymTabController.tabs.tab[gymTabController.tabs.tab.count-1].exercises.removeLast()
                            
                            gymTabController.saveTab(ind:gymTabController.tabs.index)
                           
                            gymTabController.choosing = true
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                        else
                        {
                            showErrorPopup = true
                        }
                    }
                
                
            }
            
            TextField("\(gymTabController.printTitle(circuit: circuit)) name*", text: Binding<String>(
                get: {gymTabController.getSingleLastTabName()},
                set: {gymTabController.setSingleLastTabName(setter:$0)}
                
            )).greyTabTitle()
            
        
        ScrollViewReader { proxy in
            ScrollView{
                    if scheda
                    {
                        
                        ForEach(exerciseForms.indices, id: \.self) { index in
                            exerciseForms[index]
                        }
            
                            Text("Add exercise")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    gymTabController.createNewExercise(indiceTab: indiceTab)
                                    indiceExe = indiceExe + 1;
                                    exerciseForms.append(ExerciseFormView(gymTabController: gymTabController,indiceExe:indiceExe,indiceTab: indiceTab))
                                }
                            
                            if(indiceExe >= 0 ){
                                Text( "Remove exercise")
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        gymTabController.removeLastExercise(indiceTab: indiceTab)
                                        indiceExe = indiceExe - 1
                                        exerciseForms.remove(at: exerciseForms.count-1)
                                    }
                            }
                      
                        
                        if(indiceExe >= 0 ){
                            ForEach(exerciseFormsCircuitRestAndReps.indices, id: \.self) { index in
                                exerciseFormsCircuitRestAndReps[index]
                            }
                        }
                    }
                    
                    
                    else{
                        
                       
                        
                        ForEach(exerciseFormsCircuit.indices, id: \.self) { index in
                            exerciseFormsCircuit[index]
                        }
                        
                            Text("Add exercise")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    gymTabController.createNewExercise(indiceTab: indiceTab)
                                    indiceExe = indiceExe + 1;
                                    exerciseFormsCircuit.append(ExerciseCircuitFormView(gymTabController: gymTabController,indiceExe:indiceExe,indiceTab: indiceTab))
                                }
                            
                            if(indiceExe >= 0 ){
                                Text( "Remove exercise")
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        gymTabController.removeLastExercise(indiceTab: indiceTab)
                                        indiceExe = indiceExe - 1
                                        exerciseFormsCircuit.remove(at: exerciseFormsCircuit.count-1)
                                    }
                            }
                        
                      
                        if(indiceExe >= 0 ){
                            ForEach(exerciseFormsCircuitRestAndReps.indices, id: \.self) { index in
                                exerciseFormsCircuitRestAndReps[index]
                            }
                        }
                        
                    }
                    
               
                // roba che appare quando vuoi aggiungere il rest
                HStack{
                
                    if !buttonPressed{
                        if indiceExe >= 0 {
                            if scheda {
                                Text("Add rest between exercise")
                                    .scritteBlue()
                                    .onTapGesture {
                                        exerciseFormsCircuitRestAndReps.append(ExerciseFormsCircuitRestAndRepsView(gymTabController: gymTabController,indiceTab: indiceTab,indiceExe:indiceExe,scheda:scheda))
                                        buttonPressed = true
                                    }
                            }
                            else{
                                Text("Rest and Reps entire circuit")
                                    .scritteBlue()
                                    .onTapGesture {
                                        exerciseFormsCircuitRestAndReps.append(ExerciseFormsCircuitRestAndRepsView(gymTabController: gymTabController,indiceTab: indiceTab,indiceExe:indiceExe,scheda:scheda))
                                        buttonPressed = true
                                    }
                            }
                            
                        }
                    }
                }
            }
            .onAppear{
                indiceTab = gymTabController.tabs.tab.count-1
            }
            .onChange(of: indiceExe){ _ in
                withAnimation {
                    proxy.scrollTo(indiceExe)
                }
            }
        }
       
        }
        
        
}

