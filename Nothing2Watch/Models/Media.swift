//
//  Media.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/10/23.
//

import Foundation
import SwiftUI

struct media: Identifiable {
    var id = UUID().uuidString
    var name: String
    var imageName: String
    var description: String
    var genre: String
//    let trailerURL: URL
    var destination: any View
    
    
}
