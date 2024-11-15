//
//  LoginView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/10/23.
//

import SwiftUI

import GoogleSignIn

import FirebaseAuth
import Firebase

struct LoginView: View {

    //View change button values
    @State var showingRegisterView = false
    @State private var  showingResetPasswordView = false
    
    //Connect to viewModels
    @EnvironmentObject var currentUserLogIn: Authentication
    
    //Allows for hiding/customizing of back button when moving from login back to register
    @Environment (\.presentationMode) private var
    presentationMode: Binding<PresentationMode>
    
   
    
    //Login screen UI
    var body: some View {
        
        NavigationStack {
        
        
        ZStack {
            
            //back navigation
            Spacer()
                       
            
            
            //Background
            Image("BGWgradient")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .rotationEffect(.degrees (270))
                .ignoresSafeArea()
            
            
            //FIX ERROR MESSAGES (allow for invalid email & add invalid credentials)
            if !currentUserLogIn.errorMessage.isEmpty {
                
                Text(currentUserLogIn.errorMessage)
                    .offset(y: 105)
                    .font(.custom("Poppins",size: 20))
                    .foregroundColor(.red)
                    .padding(.top, 15)
            }
            
            VStack {
                
                
                //Login Title
                ZStack {
                    
                    Text("Login")
                        .font(.custom("Poppins-Bold",size: 55))
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.top, 15)
                        .offset(x: -2, y: -2)
                    
                    Text("Login")
                        .font(.custom("Poppins-Bold",size: 55))
                        .bold()
                        .padding(.top, 15)
                    
                }
                
                
                //Logo
                ZStack {

                    Image("Rectangle 260")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .shadow(radius: 10)
                        .shadow(radius: 10)
                        .shadow(radius: 15)
                    
                    
                    Button {
                        
                        //SECRET FEATURE
                        currentUserLogIn.checkIfCurrentUser()
                        
                    } label: {
                        Image("")
            
                    }
                    
                    
                    
                    
                    
                    
                }
                
                Spacer()
                
                
                //3 new view buttons
                HStack {
                    
                    Spacer()
                    Spacer()
                    
                    
                    //google login button
                    Button {
                        
                        currentUserLogIn.signInWithGoogle(presenting: getRootViewController()) { error in print("ERROR: \(currentUserLogIn.errorMessage)")}
                        
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
                                
                                
                                Image("googleicon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                                    .offset(x: 5)
                                
                            }.offset(x:-2, y:-4)
                            
                        }
                    }
                    
                    Spacer()
                
                    
                    //Create new user button
                    Button {
                        currentUserLogIn.errorMessage = ""
                        currentUserLogIn.errorMessageR = ""
                        
                        
                        showingRegisterView = true
                        
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
                                
                                
                                Image("AddNewUser")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32)
                                    .offset(x: 2, y:3)
                                
                                
                            }.offset(x:-2, y:-4)
                            
                        }
                    }
                    
                    
                    Spacer()
                    
                    
        

                    
                    
                    //NEW MEDIA login button (twitter/apple sign in)
                    Button {
                        
                        
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
                                
                                
                                Image("fbicon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32)
                                    .offset(x: 2, y: -4)
                                
                                
                            }.offset(x:-2, y:-4)
                            
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                } .padding(.horizontal, 80)
                
                Spacer()
                
                
                
                //Email field
                VStack {
                    
                    //SHOW ERRORS IF THERE ARE ANY
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                            .frame(width: 380, height: 40)
                        
                        
                        TextField("", text: $currentUserLogIn.email)
                            .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                            .textFieldStyle(.plain)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .placeholder(when: currentUserLogIn.email.isEmpty) {
                                Text("                               Email")
                                    .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                    .font(.custom("Poppins-Regular",size: 18))
                            }.frame(width: 350)
                        
                    }
                    .padding(.bottom, 20)
                    
                    
                    
                    //Password field
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                            .frame(width: 380, height: 40)
                        
                        SecureField("", text: $currentUserLogIn.password)
                            .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                            .textFieldStyle(.plain)
                            .autocapitalization(.none)
                            .placeholder(when: currentUserLogIn.password.isEmpty) {
                                Text("                           Password")
                                    .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                    .font(.custom("Poppins-Regular",size: 18))
                            }.frame(width: 350)
                        
                        
                    }.padding(.top, 20)
                    
                }
                
                Button {
                    
                    showingResetPasswordView = true
                    
                } label: {
                    Text("Forgot Password?")
                        .font(.custom("Poppins-Regular",size: 15))
                        .foregroundColor(Color(red: 0.576, green: 0.576, blue: 0.576))
                }
                
                Spacer()
                
                
                
                
                //Go button AKA THE OG 3D BUTTON
                
                Button {
                    currentUserLogIn.errorMessage = ""
                    
                    currentUserLogIn.login()
                    
                    
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
                            
                            //R
                            Text("Go")
                                .foregroundColor(.black)
                                .font(.custom("Poppins-Bold",size: 30))
                            
                        }.offset(x:-2, y:-4)
                        
                    }
                }
                
                
            }.offset(y: -7)
              
            
            
            
        }
        
        
        //NavStack
        }.fullScreenCover(isPresented: $showingRegisterView) {
            RegisterView() }
        .fullScreenCover(isPresented: $showingResetPasswordView) {
            ResetPasswordView() }
        .navigationViewStyle(StackNavigationViewStyle()) 
        .navigationBarBackButtonHidden(true)
        .onAppear{
                    currentUserLogIn.email = ""
                    currentUserLogIn.password = ""  }
        
    } //Body
        

    
} //Struct







struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
            .environmentObject(Authentication())
    }
}

