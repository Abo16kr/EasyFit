//
//  AuthViewModel.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 14.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

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

    
    //MARK: User Loaging by Google 
    
    func signInWithGoogle() {
        Task {
            do {
                let signInGoogleHelper = SignInGoogleHelper()
                let result = try await signInGoogleHelper.signIn()
                print("Successfully signed in with Google: \(result.name ?? "")")
                DispatchQueue.main.async { [weak self] in
                    self?.isAuthenticated = true
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.errorMessage = error.localizedDescription
                }
                print("Error signing in with Google: \(error.localizedDescription)")
            }
        }
    }
}


import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email

        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
    
}

import Foundation
import UIKit

final class Utilities {
    
    static let shared = Utilities()
    private init() {}
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
