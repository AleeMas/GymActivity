import SwiftUI

struct ExerciseFormsCircuitRestAndRepsView: View{
            
    @ObservedObject var gymTabController:GymTabController
    @State var indiceTab:Int
    @State var indiceExe:Int
    @State var scheda: Bool
    
    


    var body: some View {
        VStack {
            if scheda{
                HStack{
                    Text("Rest every set").padding(.leading)
                    Picker("Time", selection: Binding<Int>(
                        get: { gymTabController.getTabRest(ind:indiceTab)},
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
                    .frame(width: 80, height: 50)
                }
            }
            else
            {
                TextField("Sets", text: Binding<String>(
                    get: {
                        let sets = gymTabController.getExerciseSets(indExe: indiceExe,indiceTab: indiceTab)
                        return sets == 0 ? "" : "\(sets)"
                    },
                    set: { newValue in
                        if let intValue = Int(newValue){
                            gymTabController.setExerciseSets(indExe:indiceExe,indiceTab: indiceTab,setter:intValue)}
                    }
                ))
                .frame(width: 190, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                
                
                HStack{
                    Text("Rest every set").padding(.leading)
                    Picker("Time", selection: Binding<Int>(
                        get: { gymTabController.getTabRest(ind:indiceTab)},
                        set: { gymTabController.setTabRest(ind: indiceTab, setter: $0)}
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
                    .frame(width: 80, height: 50)
                }
            }
        }
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.green.opacity(0.9), lineWidth: 2))
        .padding()
        
    }
}
