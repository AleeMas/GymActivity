//
//  ProfileView.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 03/05/24.
//

import Foundation
import SwiftUI


struct ProfileView: View {
    
    
    
    @ObservedObject var user: User
    
    @State private var selectedImage: UIImage?
    @State private var isPresented = false
    
    @State private var isEditingFirstName = false
    @State private var isEditingLastName = false
    @State private var isEditingEmail = false
    @State private var isEditingAge = false
    
    
    var body: some View {
        VStack {
            if user.getgotImage(){
                user.getUserConvertedImage()?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 12)
                    .onTapGesture {
                        user.setUserImage(setter: true)
                    }
            } else {
                Image(systemName:"person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 180)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 12)
                    .onTapGesture {
                        user.setUserImage(setter:true)
                    }
            }
            
            Button(action: {
                user.setUserImage(setter: true)
            }) {
                Text("Carica Foto")
            }
            
            VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        Spacer(minLength:30)
                        Text("First name:")
                            .foregroundColor(.blue)
                            .onTapGesture {
                            isEditingFirstName = true
                        }
                        TextField("Insert name", text: Binding <String>(
                            get: { user.getFirstName()},
                            set: { user.setFirstName(setter:$0)}
                        ),onEditingChanged: { editing in
                            self.isEditingFirstName = editing
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(!isEditingFirstName)
                        Spacer(minLength:30)
                    }
                    HStack {
                        Spacer(minLength:30)
                        Text("Last name:")
                            .foregroundColor(.blue)
                            .onTapGesture {
                            self.isEditingLastName = true
                        }
                        TextField("Insert last name", text: Binding<String>(
                            get: { user.getLastName() },
                            set: { user.setLastName(setter:$0) }
                        ), onEditingChanged: { editing in
                            self.isEditingLastName = editing
                            
                        })
                        
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(!self.isEditingLastName)
                        Spacer(minLength:30)
                    }
                    HStack {
                        Spacer(minLength:30)
                        Text("         Email:")
                            .foregroundColor(.blue)
                            .onTapGesture {
                            self.isEditingEmail = true
                        }
                        TextField("Insert email", text: Binding<String>(
                            get: { user.getEmail()},
                            set: { user.setEmail(setter:$0) }
                        ), onEditingChanged: { editing in
                            self.isEditingEmail = editing
                        })
                        
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(!self.isEditingEmail)
                        Spacer(minLength:30)
                    }
                    HStack {
                        Spacer(minLength:30)
                        Text("           Age:")
                            .foregroundColor(.blue)
                            .onTapGesture {
                            self.isEditingAge = true
                        }
                        Spacer()
                        TextField("Insert age", text: Binding<String>(
                            get: { user.getAge() },
                            set: { user.setAge(setter:$0) }
                        ), onEditingChanged: { editing in
                            self.isEditingAge = editing
                        })
                        
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(!self.isEditingAge)
                        Spacer(minLength:30)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
                .padding(.horizontal, 20)
            Button(action: {
                            // Ripristina lo stato di modifica dei campi
                            (self.isEditingFirstName,
                            self.isEditingLastName,
                            self.isEditingEmail,
                             self.isEditingAge) = ProfileController.invertBool(setter: self.isEditingFirstName,setter1: self.isEditingLastName,setter2: self.isEditingEmail,setter3: self.isEditingAge)
                           
                        }) {
                            Text("Change All")
                        }
                        
            Spacer()
        }
        .padding(.top,50)
        .sheet(isPresented: $user.isShowingImagePicker) {
            ImagePickerView(user: user)
        }
    }
      
}
    

