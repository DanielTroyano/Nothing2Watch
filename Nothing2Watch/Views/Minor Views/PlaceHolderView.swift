//
//  PlaceHolderView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/26/23.
//

import SwiftUI

struct PlaceHolderView: View {
    @State var showingHomeView: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            
            ZStack {
                
                
                Image("BGWgradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                Text("PlaceHolder")
                    .font(.custom("Poppins-Bold",size: 48))
                    .foregroundColor(.black)
                    .bold()
                   
                   
                    
                      
                    
                 
               
                
                
                
                VStack {
                    
                    Button {
                        
                        showingHomeView = true
                        
                    }label: {
                        Image(systemName: "chevron.backward")
                            .offset(x: 3)
                        
                        Text("Back")
                    }.foregroundColor(Color(red: 0.129, green: 0.129, blue: 0.129))
                        .offset(x: -175, y: -415)
                    
                    
                    
                    
                       
                        
                    }
                        
                
                
            }
            
            }.cornerRadius(20).ignoresSafeArea()//Nav stack
            .fullScreenCover(isPresented: $showingHomeView) {
              HomeSwipeView()}
        
    }//Body
}//Struct

struct PlaceHolderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceHolderView()
    }
}
