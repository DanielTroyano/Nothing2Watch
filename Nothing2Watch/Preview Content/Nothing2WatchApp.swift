//
//  Nothing2WatchApp.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/4/23.
//

import SwiftUI
import FirebaseCore
import Firebase

import FirebaseAuth

import GoogleSignIn



//App Delegate
class AppDelegate: NSObject, UIApplicationDelegate {
    
    //main stuff
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        //Disable UI constraint complaints
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        
        //Restore sign in if google user (currently inactivate)
        //GIDSignIn.sharedInstance.restorePreviousSignIn()
        
        return true
        
    }
    
    
    
    //Google Stuff
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
        
    }
    
    
    
   
}



@main
struct Nothing2WatchApp: App {
    
    @StateObject var userModel = Authentication()
    
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
  
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(userModel)
        }
    }
    
}
