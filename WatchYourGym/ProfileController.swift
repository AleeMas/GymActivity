//
//  ProfileController.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 10/05/24.
//

import Foundation
import SwiftUI



class ProfileController{
    
    static func invertBool(setter:Bool,setter1:Bool,setter2:Bool,setter3:Bool)->(Bool,Bool,Bool,Bool){
        var check:Bool
        if(!setter && !setter1 && !setter2 && !setter3)
        {
            check = true
            return (check,check,check,check)
        }
        else{
            check = false
            return (check,check,check,check)
        }
        
        
    }
}
    
