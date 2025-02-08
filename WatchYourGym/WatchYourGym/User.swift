//
//  User.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 03/05/24.
//
import Foundation
import SwiftUI



class User: ObservableObject {
    
    
    private var image: UIImage = UIImage() // Immagine dell'utente
    private var convertedImage: Image?
    private var firstName: String = ""
    private var lastName: String = ""
    private var email: String = ""
    private var age: String = ""
    private var gotImage: Bool = false
    private var selectedImage: UIImage?
    
    @Published var isShowingImagePicker: Bool = false
    @Published var isShowingDataInserting: Bool = false

    
    init() {
        // Controlla se l'immagine è presente nel percorso specifico
        if FileManager.default.fileExists(atPath: SysManager.imageURL!.path) {
            // Se l'immagine è presente, caricala
            if let imageData = try? Data(contentsOf: SysManager.imageURL!) {
                if let loadedImage = UIImage(data: imageData) {
                    self.image = loadedImage
                    self.convertedImage = Image(uiImage: loadedImage)
                    self.gotImage = true
                }
            }
            else {
                print("Impossibile caricare l'immagine")
                self.gotImage = false
            }
        }
        else {
            print("Immagine non trovata carico il nulla")
            self.gotImage = false
        }
        
        // Controlla se il file di dati dell'utente è presente nel percorso specifico
        if FileManager.default.fileExists(atPath: SysManager.userDataURL!.path) {
            // Se il file di dati dell'utente è presente, caricalo e analizzalo
                let text = SysManager.checkData()
                if text.indices.contains(0) {
                    self.firstName = text[0]
                }
                
                if text.indices.contains(1) {
                    self.lastName = text[1]
                }
                
                if text.indices.contains(2) {
                    self.email = text[2]
                }
                
                if text.indices.contains(3) {
                    self.age = text[3]
                }
            }
        else
        {
            print("File di dati utente non trovato")
        }
    }
        
    
    // GETTER
    
    func getgotImage() -> Bool{
        return self.gotImage
    }
    
    func getUserConvertedImage() -> Image?{
        return self.convertedImage
    }
    
    func getFirstName() -> String {
           return self.firstName
       }
       
   func getLastName() -> String {
       return self.lastName
   }
   
   
   func getEmail() -> String {
       return self.email
   }
   
   func getAge() -> String {
       return self.age
   }
    
    func getIsShowingImagePicker() -> Bool {
        return self.isShowingImagePicker
    }
    
    //SETTERSè
    func setFirstName(setter:String){
        self.firstName = setter
        do{
            var text = SysManager.checkData()
            text[0] = setter
            let content = text.joined(separator: "\n")
            try content.write(toFile: SysManager.userDataURL!.path, atomically: false, encoding: .utf8)
        }
        catch{
            print(error)
        }
    }
    
    func setLastName(setter:String){
        self.lastName = setter
        do{
            var text = SysManager.checkData()
            text[1] = setter
            let content = text.joined(separator: "\n")
            try content.write(toFile: SysManager.userDataURL!.path, atomically: false, encoding: .utf8)
        }
        catch{
            print(error)
        }
    }
    
    func setEmail(setter:String){
        self.email = setter
        do{
            var text = SysManager.checkData()
            text[2] = setter
            let content = text.joined(separator: "\n")
            try content.write(toFile: SysManager.userDataURL!.path, atomically: false, encoding: .utf8)
        }
        catch{
            print(error)
        }
    }
    
    func setAge(setter:String){
        self.age = setter
        do{
            var text = SysManager.checkData()
            text[3] = setter
            let content = text.joined(separator: "\n")
            try content.write(toFile: SysManager.userDataURL!.path, atomically: false, encoding: .utf8)
        }
        catch{
            print(error)
        }
    }
    
    func setIsShowingImagePicker( setter:Bool){
        self.isShowingImagePicker = setter
    }
    

    func setUserImage(setter:Bool){
        self.isShowingImagePicker = setter
    }
    
    func setUserDataInserting(setter:Bool){
        self.isShowingDataInserting = setter
    }
    func setGotImage(setter:Bool){
        self.gotImage = setter
    }
    func setImg( setter:UIImage){
        do {
            // Crea il percorso completo per l'immagine all'interno della cartella
            

            // Salva l'immagine nel percorso specificato
            if let imageData = setter.jpegData(compressionQuality: 1.0) {
                try imageData.write(to: SysManager.imageURL!)
            } else {
                print("Impossibile convertire l'immagine in dati.")
            }
        } catch {
            print("Errore nel salvataggio dell'immagine \(error)")
        }
    }
    
    func loadImage(from url: URL) -> UIImage?{
        do {
            let imageData = try Data(contentsOf: url)
            if let image = UIImage(data: imageData) {
                return image
            } else {
                print("Failed to create image from data.")
                return nil
            }
        } catch {
            print("Error loading image:", error)
            return nil
        }
    }
    
    func setImage(){
        self.image = loadImage(from: SysManager.imageURL!)!
        self.convertedImage = Image(uiImage: self.image)
        print("ho caricato la nuova immagine")
    }
}


