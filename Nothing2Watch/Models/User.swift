//
//  User.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/10/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {

    @DocumentID var id: String?
    let name: String
    let email: String
    let joined: TimeInterval
    let birthdate: Date
    let profileImage: String

}


//Conformed to protocol in order to use extension dictionary (old user model)
//struct User: Codable {
//
//    let id: String
//    let name: String
//    let email: String
//    let joined: TimeInterval
//    let birthdate: Date
//    let profileImage: String
//
//
//}


