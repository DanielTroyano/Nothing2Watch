//
//  SideMenuHeaderView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/26/23.
//

import SwiftUI
import Kingfisher //for downloading images from the internet (avatars & movie images)

struct SideMenuHeaderView: View {
    @Binding var iconsAreShowing: Bool
    @StateObject var viewModel = HomeSwipeViewModel()
    
    @EnvironmentObject var authViewModel: Authentication
    
    
    
    var body: some View {
        
        if let user = authViewModel.currentUser {
            
            
            ZStack(alignment: .topTrailing){
                
                
                VStack(alignment: .leading) {
                    
                    
                    HStack {
                        
                        //avatar image
                        KFImage(URL(string: user.profileImage))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 60, height: 80)
                            .padding(.trailing)
                           
                            
                        
                        Button {
                            
                            withAnimation(.spring()) {
                                iconsAreShowing.toggle()
                            }
                            
                            
                            
                        } label: {
                            
                            ZStack {
                                
                                
                                
                                Image(systemName: "xmark")
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                
                                
                            }
                        }.offset(x: 250)
                        
                        
                    }
                    
                    //find a way to access and display user info
                    Text(user.name)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("@\(user.email)")
                        .font(.system(size: 14))
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                    
                    
                    HStack(spacing: 12){
                        

                        
                        HStack(spacing: 4){
                            //Add actual number to database later...
                            Text("13").bold()
                                .foregroundColor(.white)
                            Text("Movies in queue")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                    }
                    
                    
                    Spacer()
                    
                    
                }.padding()
                
                
            }
            
            
        }//end of if let statement
        
    }
}

