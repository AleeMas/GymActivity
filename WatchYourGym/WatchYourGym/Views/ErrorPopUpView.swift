//
//  ErrorPopUpView.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 25/05/24.
//

import SwiftUI

struct ErrorPopupView: View {
    @Binding var showErrorPopup: Bool

       var body: some View {
           ZStack {
               HStack {
                   Spacer()
                   Button(action: {
                       showErrorPopup = false
                   }) {
                       Image(systemName: "xmark.circle.fill")
                           .foregroundColor(.red)
                           .padding()
                   }
               }
               Text("You didn't insert all obligatory fields. Please check them to continue.")
                   .font(.body)
                   .multilineTextAlignment(.center)
                   .padding()
               Spacer()
           }
           .padding(.vertical, 25)
           .padding(.horizontal, 30)
           //.background(BlurView())
           .cornerRadius(25)
       }
}
