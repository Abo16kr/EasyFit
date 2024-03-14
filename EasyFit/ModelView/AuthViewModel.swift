//
//  AuthViewModel.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 14.03.2024.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
   
    @Published var isAuthenticated: Bool = false

    func signInAnonymous() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Error signing in anonymously: \(error.localizedDescription)")
            } else {
                print("Successfully signed in anonymously")
                self.isAuthenticated = true
            }
        }
    }

    @Published var isUserAuthenticated = false
       @Published var errorMessage = ""

       func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }

       func registerUser(email: String, password: String) {
           guard isValidEmail(email) else {
               self.errorMessage = "The email address is badly formatted."
               return
           }
           
           Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
               if let error = error {
                   DispatchQueue.main.async {
                       self.errorMessage = error.localizedDescription
                   }
                   return
               }
               // User was successfully created
               DispatchQueue.main.async {
                   self.isUserAuthenticated = true
               }
           }
       }
    
    @Published var isSignedIn = false
 
     func signIn(email: String, password: String) {
         Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
             DispatchQueue.main.async {
                 if let error = error {
                     self?.errorMessage = error.localizedDescription
                 } else {
                     self?.isSignedIn = true
                 }
             }
         }
     }
}

