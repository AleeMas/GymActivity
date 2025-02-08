//
//  SysManager.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 03/05/24.
//

import Foundation
import AVFoundation


class SysManager{
    static var audioPlayer: AVAudioPlayer?
    static let fileManager = FileManager.default
    static let root = fileManager.urls(
        for:.documentDirectory, in: .userDomainMask
    ).first?.appendingPathComponent("WatchYourGym")
    
    static let imageURL = root?.appendingPathComponent("profileImage.jpg")
    static let userDataURL = root?.appendingPathComponent("userData.txt")
    static let gymTabDataURL = root?.appendingPathComponent("gymTabDataURL.txt")
    
    
    static func createDirectory(){
        do{
            try fileManager.createDirectory(at: root!, withIntermediateDirectories: true, attributes: [:])
            print(root!)
        }
        catch{
            print(error)
        }
    }
    
    static func createFile(){
        if !fileManager.fileExists(atPath: userDataURL!.path) {
            // If the file does not exist, create it with initial content
            do {
                let text = "\n\n\n\n"
                try text.write(toFile: userDataURL!.path, atomically: true, encoding: .utf8)
                print("File created successfully.")
            } catch {
                print("Error creating file: \(error)")
            }
        } else {
            // File already exists, do nothing
            print("File already exists.")
        }
        
        if !fileManager.fileExists(atPath: gymTabDataURL!.path) {
            // If the file does not exist, create it with initial content
            do {
                let text = ""
                try text.write(toFile: gymTabDataURL!.path, atomically: true, encoding: .utf8)
                print("File created successfully.")
            } catch {
                print("Error creating file: \(error)")
            }
        } else {
            // File already exists, do nothing
            print("File already exists.")
        }
    }
    
    
    static func checkData()->([String]){
        do{
            let fileContents = try String(contentsOfFile: userDataURL!.path)
            let lines = fileContents.components(separatedBy: .newlines)
            return lines
        }
        catch {
            print("nessun file trovato")
            let lines: [(String)] = [("nothing")]
            return lines
            
        }
    }
    
    static func appendStringToEndOfFile(string: String, filePath: URL) {
        // Ottieni un oggetto FileHandle per il file specificato
        if let fileHandle = FileHandle(forWritingAtPath: filePath.path) {
            // Posizionati alla fine del file
            fileHandle.seekToEndOfFile()
            
            // Converte la stringa in dati
            if let data = string.data(using: .utf8) {
                // Scrivi i dati alla fine del file
                fileHandle.write(data)
            }
            // Chiudi il fileHandle
            fileHandle.closeFile()
        } else {
            // Se non è possibile ottenere il fileHandle, gestisci l'errore
            print("Impossibile aprire il file per la scrittura.")
        }
    }
    
    static func checkInfoTab()->Bool{
        guard let file = freopen(SysManager.gymTabDataURL!.path, "r", stdin)
        else {
            return false
        }
        defer {
            fclose(file)
        }

        if let _ = readLine()
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    static func readFileAndSplitContent(atPath path: String, delimiter: String) -> [String]? {
        do {
            // Leggi il contenuto del file in una stringa
            let fileContent = try String(contentsOfFile: path, encoding: .utf8)
            
            // Dividi il contenuto in base al delimitatore specificato
            let splitContent = fileContent.components(separatedBy: delimiter)
            
            return splitContent
        } catch {
            // Gestisci l'errore di lettura del file
            print("Errore nella lettura del file: \(error)")
            return nil
        }
    }
    
    static func playBeep() {
        guard let url = Bundle.main.url(forResource: "stop", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Couldn't load beep sound file")
        }
    }
    
}
