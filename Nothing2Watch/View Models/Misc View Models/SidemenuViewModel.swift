//
//  SidemenuViewModel.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/26/23.
//

import Foundation
import SwiftUI

    enum SidemenuViewModel: Int, CaseIterable {
        case profile
        case queue
        case favorites
        case settings
        //    case signout
        
        var title: String {
            switch self {
            case .profile: return "Profile"
            case .queue: return "Queue"
            case .favorites: return "Favorites"
            case .settings: return "Settings"
                //        case .signout: return "Logout"
            }
        }
        
        var imageName: String {
            switch self {
            case .profile: return "person"
            case .queue: return "list.bullet"
            case .favorites: return "heart"
            case .settings: return "gearshape"
                //        case .signout: return "arrow.left.square"
                
            }
            
        }
        
        //K&K VIEWS HERE
        var destination: some View {
            Group {
                switch self {
                case .profile: return PlaceHolderView()
                case .queue: return PlaceHolderView()
                case .favorites: return PlaceHolderView()
                case .settings: return PlaceHolderView()
                    
                    //          case .signout: return PlaceHolderView()
                    
                }
                
                
            }
        }
        
    
    
}
