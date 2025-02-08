//
//  Tab.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 12/05/24.
//

import Foundation
import SwiftUI

class Tabs: ObservableObject {
    
    @Published var tab:[Tab]
    @Published var inserted:Bool = false
    @Published var index : Int = -1
    
    init(){
        self.tab = [Tab]()
    }
    
    func getInserted() -> Bool{
        return self.inserted
    }
    
    func setInserted(setter:Bool){
        self.inserted = setter
    }
    
    func addTab(_ newTab: Tab) {
        self.index = index+1
        self.tab.append(newTab)
    }
    
   
    
    func removeLastTab() {
        if !self.tab.isEmpty {
            self.tab.removeLast()
            self.index = index-1
        }
    }
    
}
