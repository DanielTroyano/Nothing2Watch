//
//  UserService.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 7/6/23.
//

import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        
        print("fetched")
        
        Firestore.firestore().collection("Users")
            .document(uid)
            .getDocument { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print("fugg1")
                return }
                

                guard let user = try? snapshot.data(as: User.self) else {
                    print("fugg2")
                    return }
                
                print("DEBUG: Email is \(user.email)")
                print("DEBUG: Name is \(user.name)")
                
                completion(user)

        }
    }
    
//    func fetchGoogleUser(withUid uid: String, completion: @escaping(User) -> Void) {
//        
//        print("fetchedGoogle")
//        
//        Firestore.firestore().collection("Users")
//            .document(uid)
//            .getDocument { snapshot, error in
//            guard let snapshot = snapshot, error == nil else {
//                print("fugg1")
//                return }
//                
//
//                guard let user = try? snapshot.data(as: G?.self) else {
//                    print("fugg2")
//                    return }
//                
//                print("DEBUG: Email is \(user.email)")
//                print("DEBUG: Name is \(user.name)")
//                
//                completion(user)
//
//        }
//    }
    
    

}
