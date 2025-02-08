//
//  ContentView.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 03/05/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @StateObject private var user = User()

        
    var body: some View {
        NavigationView {
            TabView(){
                
                GymTabView(user:user).tabItem(){
                    Image(systemName: "figure.run.square.stack")
                    Text("Tabs")
                }
                
                ProfileView(user:user).tabItem(){
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
                }
            
            }
            .onAppear{
                SysManager.createDirectory()
                SysManager.createFile()
        }
    }
}


