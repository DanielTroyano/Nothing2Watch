//
//  SideMenuView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/26/23.
//

import SwiftUI
import FirebaseAuth

struct SideMenuView: View {
    @Binding var iconsAreShowing: Bool
    @StateObject var viewModel = HomeSwipeViewModel()
    @State private var showingAlert = false
    
    @EnvironmentObject var currentUser: Authentication
    

    
    var body: some View {
        
    
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
           
            
            VStack{
                
                
              //Header
                SideMenuHeaderView(iconsAreShowing: $iconsAreShowing)
                    .foregroundColor(.black)
                    .frame(height: 240)
                
              //Icons
                ForEach(SidemenuViewModel.allCases, id: \.self) { icon in
                   NavigationLink(
                    destination: {
                        icon.destination
                   }, label: {
                       SideMenuCellView(viewModel: icon)
                   })
                    
                }
                
                Button {
                    
                    showingAlert = true
                    
                    
                    
                }label: {
                    HStack(spacing: 16) {
                        
                        Image(systemName: "arrow.left.square")
                            .frame(width: 24, height: 24)
                        
                        Text("Logout")
                            .font(.system(size: 15, weight: .semibold))
                        
                        Spacer()
                        
                    }
                    .foregroundColor(.white)
                    .padding()
                }.alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("Would you like to logout?"),
                        primaryButton: .destructive(Text("Yes")) {
                            currentUser.logOut()
                        },
                        secondaryButton:.default(Text("No")){
                            showingAlert = false
                        }
                    )
                }
                
                

                Spacer()
                
            }.offset(x: 210)//VStack
            
            
        }.navigationBarHidden(true)//ZStack
            .navigationViewStyle(StackNavigationViewStyle()) 
        
        
        
    }//Body
}//struct

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(iconsAreShowing: .constant(true))
    }
}
