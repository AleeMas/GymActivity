//
//  Tab.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 12/05/24.
//

import Foundation
import SwiftUI


class Tab: ObservableObject,Identifiable {
    
    private var type:String
    private var name:String
    private var restBetweenExercise:Int
    
    @Published var exercises: [ExerciseTab]
    let id: UUID = UUID()
    
    
    init(){
        self.type = ""
        self.name = ""
        self.exercises = [ExerciseTab()]
        self.restBetweenExercise = 0
    }
    
    func setExercised(setter:[ExerciseTab]){
        self.exercises = setter
    }
    
    func setRestBetweenExercise(setter:Int){
        self.restBetweenExercise = setter
    }
    
    func getRestBetweenExercise()->Int{
        return self.restBetweenExercise
    }
    
    func getName()->String{
        return self.name
    }
    
    func getType()->String{
        return self.type
    }
    
    func addNewExe(){
        self.exercises.append(ExerciseTab())
    }
    
    func setName(setter: String){
        self.name = setter
    }
    
    func setType(setter: String){
        print("\(setter)")
        self.type = setter
    }
}
