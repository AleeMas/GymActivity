//
//  ProfileController.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 10/05/24.
//

import Foundation
import SwiftUI

class GymTabController : ObservableObject{
    
    @Published var user: User
    @ObservedObject var tabs:Tabs=Tabs()
    
    @Published var choosing: Bool
    @Published var inserting: Bool = false
    @Published var welcomeText: String = ""
    @Published var isAddingTab: Bool = false
    
    init(user: User) {
        self.user = user
        self.choosing = SysManager.checkInfoTab()
        if self.choosing{
            print("ciao")
        }
    }
    
    func setWelcomeText(){
        self.welcomeText = "Welcome in! \n \(self.user.getFirstName())  \(self.user.getLastName()) \n start your workout"
    }
    
    func printTitle(circuit:Bool)->String{
        let ind = self.tabs.tab.count - 1
        if circuit {
            self.tabs.tab[ind].setType(setter:"Circuit")
            return "Circuit"
        }
        else
        {
            self.tabs.tab[ind].setType(setter:"Tab")
            return "Tab"
        }
    }
    
    func getSingleLastTabName()->String{
        let ind = self.tabs.tab.count - 1
        return self.tabs.tab[ind].getName()
    }
    
    func setSingleLastTabName(setter:String){
        let ind = self.tabs.tab.count - 1
        self.tabs.tab[ind].setName(setter: setter)
    }
    
    func getSingleMuscleName(indExe:Int,indiceTab:Int)->String{
        return self.tabs.tab[indiceTab].exercises[indExe].muscolo
    }
    
    func createNewExercise(indiceTab: Int){
        //crea un nuovo esericizio in coda
        self.tabs.tab[indiceTab].addNewExe()
    }
    
    func removeLastExercise(indiceTab:Int){
        //rimuove sempre l'ultimo esercizio
        
        self.tabs.tab[indiceTab].exercises.removeLast()
    }
    
    func getExerciseName(indExe:Int,indiceTab:Int)->String{
        return self.tabs.tab[indiceTab].exercises[indExe].name
    }
    
    func getExerciseNote(indExe:Int,indiceTab:Int)->String{
        return self.tabs.tab[indiceTab].exercises[indExe].note
    }
    
    func getExerciseKg(indExe:Int,indiceTab:Int)->Int{
        
        return self.tabs.tab[indiceTab].exercises[indExe].kg
    }
    
    func getExerciseRest(indExe:Int,indiceTab:Int)->Int{
        
        return self.tabs.tab[indiceTab].exercises[indExe].rest
    }
    
    func getExerciseReps(indExe:Int,indiceTab:Int)->Int{
        
        return self.tabs.tab[indiceTab].exercises[indExe].reps
    }
    
    func getExerciseTypeOfReps(indExe:Int,indiceTab:Int)->Int{
        
        return self.tabs.tab[indiceTab].exercises[indExe].typeOfReps
    }
    
    
    func getExerciseSets(indExe:Int,indiceTab:Int)->Int{
        print("SONO INDICE TAB: \(indiceTab),SONO INDICE EXE: \(indExe)")
        print("SONO IL RETURN: \(self.tabs.tab[indiceTab].exercises[indExe].sets)")
        return self.tabs.tab[indiceTab].exercises[indExe].sets
    }
    
    func setExerciseNote(indExe:Int,indiceTab:Int,setter:String){
        
        self.tabs.tab[indiceTab].exercises[indExe].note = setter
    }
    
    func setExerciseKg(indExe:Int,indiceTab:Int,setter:Int){
        
        self.tabs.tab[indiceTab].exercises[indExe].kg = setter
    }
    
    func setSingleMuscleName(indExe:Int,indiceTab:Int,setter:String){
        
        self.tabs.tab[indiceTab].exercises[indExe].muscolo = setter
    }
    
    func setExerciseName(indExe:Int,indiceTab:Int,setter:String){
        
        self.tabs.tab[indiceTab].exercises[indExe].name = setter
    }
    
    func setExerciseRest(indExe:Int,indiceTab:Int,setter:Int){
        
        self.tabs.tab[indiceTab].exercises[indExe].rest = setter
    }
    
    func setExerciseReps(indExe:Int,indiceTab:Int,setter:Int){
        
        self.tabs.tab[indiceTab].exercises[indExe].reps = setter
    }
    
    func setExerciseTypeOfReps(indExe:Int,indiceTab:Int,setter:Int){
        
        self.tabs.tab[indiceTab].exercises[indExe].typeOfReps = setter
    }
    
    func setExerciseSets(indExe:Int,indiceTab:Int,setter:Int){
        
        self.tabs.tab[indiceTab].exercises[indExe].sets = setter
    }
    
    // aggiunge avanti il valore di setter quello di setter 2
    
    func setTabRest(ind:Int,setter:Int){
        self.tabs.tab[ind].setRestBetweenExercise(setter: setter)
    }
    
    func getTabRest(ind:Int)-> Int {
        return self.tabs.tab[ind].getRestBetweenExercise()
    }
    
    
    
    func saveTab(ind:Int)
    {
        var text = "----\n"
        text = text + "NUOVOES"
        text = text + "XYX" + self.tabs.tab[ind].getName()
        text = text + "XYX" + self.tabs.tab[ind].getType()
        text = text + "XYX" + String(self.tabs.tab[ind].getRestBetweenExercise()) + "\n"
        print(text)
        for (index, exercise) in self.tabs.tab[ind].exercises.enumerated() {
            if index != self.tabs.tab[ind].exercises.count {
                print("TESTOOO")
                text = text + "NUOVOES"
                text = text + "XYX" + exercise.name
                text = text + "XYX" + exercise.muscolo
                text = text + "XYX" + String(exercise.kg)
                text = text + "XYX" + String(exercise.rest)
                text = text + "XYX" + String(exercise.reps)
                text = text + "XYX" + String(exercise.sets)
                // dato che ho problemi con le note se sono vuote
                if exercise.note == ""
                {
                    text = text + "XYX" + "vuotoZ"
                }
                else
                {
                    text = text + "XYX" + exercise.note
                }
                
                text = text + "XYX" + String(exercise.typeOfReps) + "\n"
            }
        }
        SysManager.appendStringToEndOfFile(string: text, filePath: SysManager.gymTabDataURL!)
    }
    
    func generateTabs(){
        var ind:Int
        // le schede lette dal file
        let tabsFromFile = SysManager.readFileAndSplitContent(atPath: SysManager.gymTabDataURL!.path, delimiter: "----")
        
        // se l'indice è -1 vuol dire che l'elemento non ha schede inizializzate
        if self.tabs.index == -1
        {
            for (id , section) in tabsFromFile!.enumerated() {
                print("sezione numero:\(id),contenuto:\(section) \n")
                // per qualche motivo (in creazione del file creo la prima sezione vuota) la prima sezione risulta
                // = ""
                if section == ""
                {
                    
                }
                else
                {
                    self.tabs.addTab(Tab())
                    ind = self.tabs.index
                    let linea = section.split(separator: "\n")
                    let name_and_type = linea.first!.split(separator: "XYX")
                    print(name_and_type)
                    print(name_and_type[1])
                    print(name_and_type[2])
                    
                    print(name_and_type[3])
                    self.tabs.tab[ind].setName(setter:String(name_and_type[1]))
                    self.tabs.tab[ind].setType(setter:String(name_and_type[2]))
                    self.tabs.tab[ind].setRestBetweenExercise(setter:Int(name_and_type[3])!)
                    
                    let esercizi = section.split(separator: "NUOVOES")
                    print("Sono esercizi \(esercizi)")
                    //l'ultimo esercizio è tutto vuoto per qualche motivo che non mi va di capire
                    for (id , esercizioToSplit) in (esercizi.enumerated()) {
                        let esercizio = esercizioToSplit.split(separator: "XYX")
                        print("Sono esercizio splittato \(esercizio)")
                        print(id)
                        // id è il numero di
                        if id == 2
                        {
                            //print("SONO 0: \(String(esercizio[0]))")
                            self.tabs.tab[ind].exercises[id-2].name = String(esercizio[0])
                            //print("SONO 1: \(String(esercizio[1]))")
                            self.tabs.tab[ind].exercises[id-2].muscolo = String(esercizio[1])
                            //print("SONO 2: \(String(esercizio[2]))")
                            self.tabs.tab[ind].exercises[id-2].kg = Int(esercizio[2])!
                            //rimuovi lo spazio
                            //print("SONO 3: \(String(esercizio[2]))")
                            self.tabs.tab[ind].exercises[id-2].rest = Int(esercizio[3])!
                            //print("SONO 4: \(String(esercizio[4]))")
                            self.tabs.tab[ind].exercises[id-2].sets = Int(esercizio[5])!
                            //print("SONO 5: \(String(esercizio[5]))")
                            self.tabs.tab[ind].exercises[id-2].reps = Int(esercizio[4])!
                            //print("SONO 6: \(String(esercizio[6]))")
                            // avevo problemi quando le note erano vuote ho dato quindi
                            // un valore vuoto nel file di testo
                            if String(esercizio[6]) == "vuotoZ"
                            {
                                self.tabs.tab[ind].exercises[id-2].note = ""
                            }
                            else
                            {
                                self.tabs.tab[ind].exercises[id-2].note = String(esercizio[6])
                            }
                            // se è vuoto setta 0 cioè il tipo Reps
                            //print("SONO 7: \(String(esercizio[7]))")
                            self.tabs.tab[ind].exercises[id-2].typeOfReps = Int(String(esercizio[7].first!))!
                        }
                        if id >= 3
                        {
                            print(esercizio)
                            self.tabs.tab[ind].exercises.append(ExerciseTab())
                            print("SONO 0: \(String(esercizio[0]))")
                            self.tabs.tab[ind].exercises[id-2].name = String(esercizio[0])
                            print("SONO 1: \(String(esercizio[1]))")
                            self.tabs.tab[ind].exercises[id-2].muscolo = String(esercizio[1])
                            print("SONO 2: \(String(esercizio[2]))")
                            self.tabs.tab[ind].exercises[id-2].kg = Int(esercizio[2])!
                            //rimuovi lo spazio
                            print("SONO 3: \(String(esercizio[2]))")
                            self.tabs.tab[ind].exercises[id-2].rest = Int(esercizio[3])!
                            print("SONO 4: \(String(esercizio[4]))")
                            
                            self.tabs.tab[ind].exercises[id-2].sets = Int(esercizio[5]) == nil ? 0 : Int(esercizio[5])!
                            
                            print("SONO 5: \(String(esercizio[5]))")
                            self.tabs.tab[ind].exercises[id-2].reps = Int(esercizio[4])!
                            print("SONO 6: \(String(esercizio[6]))")
                            self.tabs.tab[ind].exercises[id-2].note = String(esercizio[6])
                            print("SONO 7: \(String(esercizio[7]))")
                            //POTREBBE NON FIXARE LA COSA PERCHE METTE 0 INVECE DI QUELLO GIUSTO
                            self.tabs.tab[ind].exercises[id-2].typeOfReps = Int(String(esercizio[7].first!))!
                            print("SONO SELF7: \( self.tabs.tab[ind].exercises[id-2].typeOfReps)")
                        }
                    }
                }
            }
        }
        
    }
    
    func checkObligatory(indiceExe:Int)->Bool
    {
        let ind = self.tabs.tab.count - 1
        if(self.tabs.tab[ind].getName() != ""){
            return true
        }
        else{
            return false
        }
    }
    
    func reLoadFile(){
        
        let nTabs = self.tabs.tab.count
        //dopo aver eliminato il tab riscrivo tutto il file
        do {
            let text = ""
            try text.write(toFile: SysManager.gymTabDataURL!.path, atomically: true, encoding: .utf8)
            
        } catch {
            print("error overwriting file: \(error)")
        }
        print("HO PORCODIO UN FILE VUOTO E CI SCRIVO LE NUOVE COSE DENTRO")
        for i in 0..<nTabs
        {
            self.saveTab(ind: i)
        }
        
    }
    
   
    func startTimer(timeRemaining:Binding<Int>,showTimer:Binding<Bool>)
    {
         var timer: Timer?

         timer?.invalidate()
         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
             if timeRemaining.wrappedValue > 0 {
                 if timeRemaining.wrappedValue <= 3{
                     print("ci sn")
                     SysManager.playBeep()
                 }
                 timeRemaining.wrappedValue -= 1
             } else {
                 showTimer.wrappedValue = false
                 timer?.invalidate()
             }
         }
     }
     
    func startTimerAndSetPage(timeRemaining:Binding<Int>,showTimer:Binding<Bool>,currentPage:Binding<Int>)
    {
         var timer: Timer?

         timer?.invalidate()
         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
             if timeRemaining.wrappedValue > 0 {
                 if timeRemaining.wrappedValue <= 3{
                     print("ci sn")
                     SysManager.playBeep()
                 }
                 timeRemaining.wrappedValue -= 1
             }  else {
                 showTimer.wrappedValue = false
                 currentPage.wrappedValue += 1
                 timer?.invalidate()
             }
         }
     }
    
    func manageTimer(i:Binding<Int>,currentPage:Binding<Int>,exercise:ExerciseTab,tabIndex:Int,done :Binding<Bool>,showTimer:Binding<Bool>,remainingTime:Binding<Int>)
    {
        // i è il set attuale su cui si trova il broski
        i.wrappedValue = i.wrappedValue + 1
        
        if(i.wrappedValue < exercise.sets)
        {
            // parte il timer tra le serie
            remainingTime.wrappedValue = exercise.rest
            showTimer.wrappedValue = true
            
            self.startTimer(timeRemaining:remainingTime , showTimer: showTimer)
        }
        else{
            let info = currentPage.wrappedValue + 1
            if info  >= self.tabs.tab[tabIndex].exercises.count
            {
                //finisce il WO
                done.wrappedValue = true
            }
            else
            {
                // se il rest tra gli es è settato
                if self.getTabRest(ind: tabIndex) != 0
                {
                   // fai partire il timer tra gli esercizi
                    remainingTime.wrappedValue = self.getTabRest(ind: tabIndex)
                    showTimer.wrappedValue = true
                   
                    self.startTimerAndSetPage(timeRemaining:remainingTime , showTimer: showTimer,currentPage:currentPage)
                    
                }
                else{

                    currentPage.wrappedValue += 1
                }
            }
        }
    }
    
}

    
 
            
        
        
        
