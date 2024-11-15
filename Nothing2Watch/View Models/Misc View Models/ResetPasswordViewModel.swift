//
//  ResetPasswordViewModel.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/25/23.
//

import Foundation
import FirebaseAuth

class ResetPasswordViewModel: ObservableObject {
    // Abstracted data fields
    @Published var email = ""
    @Published var errorMessage = ""
    @Published var alert = ""
    @Published var validated: Bool = false
    
    init() {}
    
    
    //Attempt reset password function
    static func resetPassword(email:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
               
                resetCompletion(.failure(error))
            } else {
               
                resetCompletion(.success(true))
            }
            
        })
       
        }
    
    func cleanse() {
        errorMessage = ""
        alert = ""
    }
    
    
    func validateEmail() -> Bool {
        
        errorMessage = ""
        alert = ""
        
        //ensure
        
        guard
              !email.trimmingCharacters(in: .whitespaces).isEmpty
              
        else {
            errorMessage = "Please enter a valid email."
            return false }
        
    
        guard email.contains("@") && email.contains(".")
                
            else {
                errorMessage = "Please enter a valid email."
                return false
            }
        
        //Success and register() will attempt login
        return true
    }


}
