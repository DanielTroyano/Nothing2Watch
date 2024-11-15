//
//  ContentView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/4/23.
//

import SwiftUI
import Firebase


struct MainView: View {
    @EnvironmentObject var userModel: Authentication
    
    //Connect to MainViewModel
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        //Shows correct first view based on viewModel
        
        if (userModel.currentUser == nil) {
            LoginView()
        }
        else {
            HomeSwipeView()
        }
        
        
        }
    }


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




