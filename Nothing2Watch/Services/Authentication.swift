//
//  CurrentUser.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 7/6/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn


class Authentication: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? //find a way to include google user here (maybe convert google user -> Firebase user)
    
    @Published var currentUser: User?
    
    private let service = UserService() //connection to fetch user func
    
   
    
    
    init() {
        
        self.userSession = Auth.auth().currentUser
        
        print("User session is: \(self.userSession?.uid)")
        
        self.fetchUser()

    }
    
    
  
    
    //LOGIN VIEW MODEL***************************************************************************************************************
    
    //Abstracted data fields
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    
    
    //Firebase database
    var usersCollection = Firestore.firestore().collection("Users")
    @Published private var accountExists = false
    @Published private var passwordIncorrect = false
    
    
    //Attempt login function
    func login() {
        
        //Call validate func to check for errors
        guard validateLogin()    else {
            //If validate returns false 
            return
        }
        
        checkIfAccountExists { result in
            if (result == true) {
                self.accountExists = true
                
                
                
                //Attempt sign in (IMPORTANT)
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (authResult, error) in
                    switch error {
                   
                    case .some(let error as NSError) where error.code == AuthErrorCode.wrongPassword.rawValue:
                        self.errorMessage = "Invalid password"
                        
                    case .some(let error as NSError) where error.code == AuthErrorCode.tooManyRequests.rawValue:
                        self.errorMessage = "Please reset password or try again later."
                                
                            case .some(let error):
                        self.errorMessage = error.localizedDescription
                           
                            case .none:
                                if let user = authResult?.user {
                                    print(user.uid)
                                    self.userSession = user
                                    self.fetchUser()
                                }
                            }
                                   }
                
                
            }
            
            if (result == false) {
                self.accountExists = false
                
                self.errorMessage = "Account not found."
            }
        }
        
         
        
    }
    
    
    
    //Func called by login func to check for errors
    private func validateLogin() -> Bool {
        
        //remove prior error messages
        errorMessage = ""
        
        //ensure email and password are not either empty or only spaces
        guard (!email.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty)
        
            else {
                errorMessage = "Please fill in all fields."
         
                return false
        }
        
        //ensure the email contains both "@" and "."
        guard (email.contains("@") && email.contains("."))
                
            else {
                errorMessage = "Please enter a valid email."
           
                return false
            }
        
        //If all error tests are successfully guarded:
        return true
    }

    
    //Func called by login func to check if account is in database
    func checkIfAccountExists(completion: @escaping((Bool) -> () )) {
        
        self.usersCollection.whereField("email", isEqualTo: self.email).getDocuments() { (querySnapshot, error) in
            
            if let errorResult = error {
                print("Unable to query")
                completion(true)
            }
            else {
                if (querySnapshot!.count > 0) {
                    print("User exists.")
                    completion(true)
                }
                else {
                    print("No user exists yet")
                    completion(false)
                }
            }
            
            
        }
        
        
    }
    
    
    //Not necessary function, only here for authentication testing purposes
    func checkIfCurrentUser() {
        let user = Auth.auth().currentUser
        
        if (user == nil) {
            print("Not signed in :)")
        }
        
        if (user != nil) {
            print("User is signed in\(user?.email)")
        }
    }
    
    
    
    //Google sign in
    func signInWithGoogle(presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        
        errorMessage = ""
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        
        // Start the sign in flow
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
          guard error == nil else {
              print(error?.localizedDescription)
              return
          }

          guard let user = result?.user,
                let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    //self.errorMessage = "Invalid google sign in attempt"
                    print(error?.localizedDescription)
                    return
                }
                
                
                guard let user = result?.user else {
                    print("cannot assign user...")
                    return }
                
                
                //test connection
                print(user.uid)
                
                //Check if google account is already stored in database (check for id)
                self.usersCollection.whereField("id", isEqualTo: user.uid).getDocuments() { (querySnapshot, error) in
                    
                    if let errorResult = error {
                        print("Unable to query")
                        return
                    }
                    else { //uid is already documented in database yet
                        if (querySnapshot!.count > 0) {
                            print("User exists.")
                            
                            //set user as active
                            self.userSession = user
                            
                            print("HEllo\(self.userSession?.uid)")
                            
                            self.fetchUser()
                            
                        }
                        else { //uid not documented in database yet
                            print("No user exists yet")
                            
                            //set user as active
                            self.tempUserSession = user
                            
                            self.userSession = user
                            
                            
                            //store user in database
                            let data = ["id": user.uid,
                                        "name": user.displayName,
                                        "email": user.email,
                                        "joined": Date().timeIntervalSince1970,
                                        "birthdate": nil,
                                        "profileImage": "" ]
                            
                            Firestore.firestore().collection("Users")
                                .document(user.uid)
                                .setData(data) { _ in
                                    print("uploaded user data...")
                                }
                            
                            //update to default avatar and attempt to fetch stored user info
                            self.uploadUserAvatarImage(self.avatars[self.clickedAvatarIndex]!)
                            
                            self.fetchUser()
                            
                        }
                    }
                   
                }
                
                
                
                
            }
        }
        
        
    }
    
    
    //Twitter sign in (incomplete)
    @Published var provider = OAuthProvider(providerID: "twitter.com")



  
    
    
    
    //REGISTER VIEW MODEL************************************************************************************************************
    
    //Abstracted data fields
    @Published var name = ""
    @Published var birthday: Date = Date()
    private var tempUserSession: FirebaseAuth.User? //used for assigning avatar image post account creation)

    @Published var errorMessageR = ""
    
    
    
    //Create a new user record in firebase (WTF WTF WTF)
    func register() {
        guard validateRegister() else {
            return //if validate() returned false
            
        }
        
        checkIfAccountExists { result in
            if (result == true) {
                self.accountExists = true
                self.errorMessageR = "Account already exists."
                

            }
            if (result == false) {
                self.accountExists = false
                
                //if both validate() and checkIfUserExists() passed -> create a new user in Authentication
                Auth.auth().createUser(withEmail: self.email, password: self.password) { result, error in
                    
                    guard let userId = result?.user.uid else {
                       
                        return }
                    
                    guard let user = result?.user else {
                        
                        return }
                    
                    self.tempUserSession = user
                    self.userSession = user
                    
                    //NEED PERMISSIONS:
                    
//                    self.insertUserRecord(id: userId) **old database function
                    
                    let data = ["id": user.uid,
                                "name": self.name,
                                "email": self.email,
                                "joined": Date().timeIntervalSince1970,
                                "birthdate": self.birthday,
                                "profileImage": ""  ]
                    Firestore.firestore().collection("Users")
                        .document(user.uid)
                        .setData(data) { _ in
                            print("uploaded user data...")
                        }
                    
                    //Add their selected avatar to their account
                    self.uploadUserAvatarImage(self.avatars[self.clickedAvatarIndex]!)
                    self.fetchUser()
                }
            }
        }
        
       
        
    }
    
    
    private func validateRegister() -> Bool {
        //ensure
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessageR = "One or more fields are empty."
            return false
        }
        guard email.contains("@") && email.contains(".")
                
            else {
                errorMessageR = "Please enter a valid email."
                return false
            }
        
        guard password.count >= 6 else {
                errorMessageR = "Password must be at least 6 characters."
            return false
        }
        
        
        //Success and register() will attempt login
        return true
    }
    
    
    //MISC *****************************************************************************************************************************
    
    
    func logOut() {
        
        errorMessage = ""
    
        userSession = nil
        currentUser = nil
        
        try? Auth.auth().signOut()
    
        print("User session is: \(self.userSession?.uid)")
        
    }
    
    
  
    
    
    
    //Avatar Stuff (change avatars later)
    let avatars = [UIImage(named:"sonicPFP"),
                   UIImage(named:"rickPFP"),
                   UIImage(named:"ninjaPFP"),
                   UIImage(named:"sonicPFP"),
                   UIImage(named:"rickPFP"),
                   UIImage(named:"ninjaPFP"),
                   UIImage(named:"sonicPFP"),
                   UIImage(named:"rickPFP"),
                   UIImage(named:"ninjaPFP")]
    

    @Published var clickedAvatarIndex: Int = 0
    
    func uploadUserAvatarImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else {return}
        
        //hold UIImage and upload post register...
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("Users")
                .document(uid)
                .updateData(["profileImage": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                }
        }
    }
    
    
    //helper function to access current user
    func fetchUser() {
        guard let uid = self.userSession?.uid else {return}
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user

            print("User session is: \(self.userSession?.uid)")
        }
    }
    
    
    
    
    
}


//Insert record of user into the database (old function)
//    private func insertUserRecord(id: String) {
//
//        //Call the user model to create a new user object
//        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970, birthdate: birthday, profileImage: "")
//
//        //Insert into database
//        let dataBase = Firestore.firestore()
//
//        dataBase.collection("Users")
//            .document(id)
//            .setData(newUser.asDictionary()) //Store user info in dictionary (func in extension)
//    }
//    
