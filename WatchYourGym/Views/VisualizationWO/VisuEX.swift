//
//  VisuEX.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 27/05/24.
//
import Foundation
import SwiftUI



struct VisuEX: View {
    
    @Binding var presentationModeRoot: PresentationMode
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var gymTabController: GymTabController
    @State var cover:Bool
    @State var tabIndex: Int
    
    @State var showTimer = false
    @State var done = false
    @State var currentPage = 0
    @State var timeRemaining = 0
    
    var body: some View {
        
            if(!done)
        {
                    ZStack {
                    
                    TabView(selection: $currentPage) {
                        ForEach(0..<gymTabController.tabs.tab[tabIndex].exercises.count, id: \.self) { exerciseIndex in
                            ExercisePageView(
                                exercise:gymTabController.tabs.tab[tabIndex].exercises[exerciseIndex],
                                tabIndex: tabIndex,
                                exerciseIndex:exerciseIndex,
                                gymTabController:gymTabController,
                                currentPage:$currentPage,
                                done:$done,
                                showTimer: $showTimer,
                                timeRemaining: $timeRemaining
                            )
                            .tag(exerciseIndex)
                        }
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    HStack {
                        
                        if !showTimer
                        {
                            Button(action: {
                                if currentPage > 0 {
                                    currentPage -= 1
                                }
                            }) {
                                Image(systemName: "chevron.left.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(currentPage > 0 ? .blue : .gray)
                            }
                            .padding()
                            
                            Spacer()
                            
                            Button(action: {
                                if currentPage < gymTabController.tabs.tab[tabIndex].exercises.count - 1 {
                                    currentPage += 1
                                }
                            }) {
                                Image(systemName: "chevron.right.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(currentPage < gymTabController.tabs.tab[tabIndex].exercises.count - 1 ? .blue : .gray)
                            }
                            .padding()
                        }
                    }
                    }.overlay(
                        Group {
                            
                                            
                                            
                            if showTimer {
                                Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)
                               
                                    
                                VStack {
                               
                                    Text("Rest Time: \(timeString(time: timeRemaining))")
                                        .font(.largeTitle)
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                    Button(action: {
                                        timeRemaining = 0
                                    }) {
                                        Text("Skip rest")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.red)
                                            .cornerRadius(10)
                                    }
                                    
                                }
                                
                        
                            }
                        }
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        else
        {
            Button(action: {
                //il primo presentaion chiude quello corrente il secondo chiude quello dello start
                presentationMode.wrappedValue.dismiss()
                presentationModeRoot.dismiss()
                }
            ) {
                Text("Done")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
           
            
    }
}
    
    
    struct ExercisePageView: View {
        var exercise: ExerciseTab
        var tabIndex: Int
        var exerciseIndex: Int
        var gymTabController:GymTabController
        
        @Binding var currentPage:Int
        @Binding var done:Bool
        @Binding var showTimer:Bool
        @Binding var timeRemaining:Int
        
        @State var i = 0
        
        var body: some View {
            VStack {
                Text(exercise.name)
                    .font(.largeTitle)
                    .padding()
                Text(exercise.muscolo)
                Text("\(exerciseIndex+1)/\(gymTabController.tabs.tab[tabIndex].exercises.count)")
                    .padding()
                // Aggiungi qui ulteriori dettagli dell'esercizio
                
                Spacer()
                Text("\(exercise.sets) x \(exercise.reps)")
                Text(String(exercise.kg))
                Text("Current set:\(i+1)")
                Spacer()
                if !showTimer{
                    Button(action: {
                        gymTabController.manageTimer(i: $i, currentPage: $currentPage, exercise: exercise, tabIndex: tabIndex, done: $done, showTimer: $showTimer, remainingTime: $timeRemaining)
                    }) {
                        Text("Start rest")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                TextField("Note", text: Binding<String>(
                    get: {gymTabController.getExerciseNote(indExe: exerciseIndex,indiceTab: tabIndex)},
                    set: {gymTabController.setExerciseNote(indExe:exerciseIndex,indiceTab: tabIndex,setter:$0
                    ); gymTabController.reLoadFile()
                    }
                )).textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            
            //IN TEORIA POSSO METTERE IL BORDOINO QUI
            //.shadow(radius: 10)
            //.padding()
        }
    }

func timeString(time: Int) -> String {
    let minutes = time / 60
    let seconds = time % 60
    return String(format: "%02d:%02d", minutes, seconds)
}
