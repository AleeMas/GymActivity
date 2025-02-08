//
//  style.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 17/06/24.
//

import Foundation
import SwiftUI


// Estensione per il testo stile
extension Text {
    func titleStyle() -> some View {
        self
            .font(.largeTitle)
            .bold()
            .foregroundColor(.red)
 
    }
    
    func scritteBlue() -> some View {
        self
            .padding()
            .foregroundColor(.blue)
    }
    
    func editingFieldNameVS() -> some View{
        self
            .font(.system(size: 14))
            .fontWeight(.bold)
            .frame(width: UIScreen.main.bounds.width * 0.90, alignment: .leading)
            .padding(.bottom, -6)
    }
}
// Estensione per il TextField stile
extension TextField {
    func greyTab() -> some View {
        self
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            
    }
    
    func greyTabNoPad() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            
    }
    
    func greyTabTitle() -> some View {
        self
        .padding(8)
        .background(
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.6),lineWidth: 2)
                
                
        )
        .padding()
    }
}



// Estensione per il pulsante stile
extension TextEditor {
    
    func note() -> some View {
        self
            .frame(minHeight: 65) // Imposta l'altezza minima per il form note
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        
        }
    }

extension ScrollView {
    func editing() -> some View {
        self
            .frame(height: UIScreen.main.bounds.height * 0.85)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(1), radius: 100, x: 40, y: 40)
            .padding()
    }
}

extension VStack {
    func editing() -> some View {
        self
            .frame(height: UIScreen.main.bounds.height * 0.80)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(1), radius: 100, x: 40, y: 40)
            .padding(.bottom, 70)
    }
}



extension ZStack {
    func editing() -> some View {
        self
            .frame(height: UIScreen.main.bounds.height * 0.79)
            .background(Color.white)
            .shadow(radius: 10)
            .padding()
    }
}



