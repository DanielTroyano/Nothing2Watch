//
//  ResetPasswordView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/14/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
    
    @State var showingLoginView = false
    @State private var showAlert = false
    
//    func backToLogin() -> Void {
//        showingLoginView = true
//    }
    
    var body: some View {
        
        NavigationStack {
            
            
            ZStack {
                
                
                Image("BGWgradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                ZStack {
                    
                    Text("Reset Password")
                        .font(.custom("Poppins-Bold",size: 45))
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.top, 15)
                        .offset(x: -2, y: -2)
                    
                    Text("Reset Password")
                        .font(.custom("Poppins-Bold",size: 45))
                        .bold()
                        .padding(.top, 15)
                         
                }.offset(y: -380)
                
                
                
                VStack {
                    NavigationLink(destination: LoginView()) {
                        Image(systemName: "chevron.backward")
                            .offset(x: 3)
                        
                        Text("Back")
                        
                    }.foregroundColor(Color(red: 0.129, green: 0.129, blue: 0.129))
                        .offset(x: -175, y: -415)
                    
                }
                
                
                
                VStack {
                    
                    
                    //Title
                    
                    
                    if !viewModel.errorMessage.isEmpty {
                        
                        Text(viewModel.errorMessage)
                            .multilineTextAlignment(.center)
                            .offset(y: 310)
                            .font(.custom("Poppins",size: 20))
                            .foregroundColor(.red)
                            .frame(width: 350)
                            
                        
//                        if !viewModel.alert.isEmpty {
//
//                            Text(viewModel.alert)
//                                .offset(y: 320)
//                                .font(.custom("Poppins",size: 20))
//                                .foregroundColor(.green)
//                                .padding(.top, 15)
//                        }
                    }
                    
                    
                        
                        Spacer()
                    
                    
                    
                            
                            //Email Field
                    
                    Image("lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 175)
                        .offset(y: 70)
                    
                    
                        Spacer()
                    
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.black)
                                    .frame(width: 380, height: 40)
                                
                                TextField("", text: $viewModel.email)
                                    .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                    .textFieldStyle(.plain)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .placeholder(when: viewModel.email.isEmpty) {
                                        Text("                               Email")
                                            .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                            .font(.custom("Poppins-Regular",size: 18))
                                            .multilineTextAlignment(.center)
                                        
                                    }.frame(width: 350)
                                
                                
                                
                            }.padding(.bottom, 35)
                            
                            
                            
                            
                            Button {
                                
                                if (viewModel.validateEmail()) {
                                    
                                    ResetPasswordViewModel.resetPassword(email: viewModel.email) { (result) in
                                        switch result {
                                        case .failure(let error):
                                            viewModel.errorMessage = error.localizedDescription
                                        case .success ( _):
                                            showAlert = true
                                            break
                                        }
                                    }
                                }
                                
                            } label: {
                                
                                ZStack {
                                    
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60)
                                        .foregroundColor(.black)
                                    
                                    ZStack {
                                        Circle()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 53)
                                            .foregroundColor(Color(red: 0.769, green: 0.769, blue: 0.769))
                                            .shadow(radius: 10)
                                            .shadow(radius: 10)
                                            .shadow(radius: 10)
                                        
                                        
                                       
                                        Image("resetIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30)
                                        
                                        Image("resetIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30)
                                            .offset(x: 1, y: 1)
                                        
                                    }.offset(x:-2, y:-4)
                                    
                                }
                                
                            }//Button label end
                            
                 
                 
                    
                }.padding(.bottom, 300)//VStack
                    
                        
                    }//ZStack
            
                    
                    
        }.navigationViewStyle(StackNavigationViewStyle())
            .fullScreenCover(isPresented: $showingLoginView) {
                LoginView() }//Nav Stack + cover
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Reset Password"), message: Text("Password reset link sent to email!"), dismissButton: .default(Text("Ok")))
        }.cornerRadius(20).ignoresSafeArea()
        
            
            
        }//body
    }//struct


struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
