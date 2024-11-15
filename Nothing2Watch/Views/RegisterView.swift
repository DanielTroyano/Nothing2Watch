//
//  RegisterView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/10/23.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    
    @EnvironmentObject var currentUserRegistration: Authentication
   
    @State private var showingLoginView = false
    @State private var bruh = false //delete later
    
    
    //Date stuff
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 1923)) ?? Date()
    let endingDate: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter }
    
    
    //Avatar Carousel Stuff
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        
        //((diff > 80) && (diff < 210))
        
        let diff = (x)
        if ((diff >= 50) && (diff <= 250))  {
            
            if ((diff > 50) && (diff <= 150)) {
                scale = 1 + (diff - 50) / 400 }
            
            if ((diff > 150) && (diff < 250)) {
                scale = 1 + (-diff + 250) / 400
            }
        
        }
        
        return scale
        
    }
    
    
    
    private func getDiff(proxy: GeometryProxy) -> CGFloat {
        let x = proxy.frame(in: .global).minX
        
        return x
        
    }
    
    
    
    private func getOffset(proxy: GeometryProxy) -> CGFloat {
        var off: CGFloat = 0
        
        
        
        let x = proxy.frame(in: .global).minX
        
        let diff = (x)
        
        //Inner
        if ((diff > 50) && (diff < 250))  {
            
            if ((diff > 50) && (diff <= 150)) {
                off = 1 + (diff - 50) / 10 }
            
            if ((diff > 150) && (diff < 250)) {
                off = 1 + (-diff + 250) / 10
            }
            
        }
        
        //Outer
        if ((diff >= -50 ) && (diff < 80))  {
            
            if ((diff > 80) && (diff <= 150)) {
                off = 1 + (diff - 50) / 50 }
            
            if ((diff > 220) && (diff < 400)) {
                off = 1 + (-diff + 250) / 50
            }
            
        }
    
        return off
        
    }
    
    
    
    
    
    
    
    var body: some View {
        
        NavigationStack {
            
            
            ZStack {
                
                
                Image("BGWgradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
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
                    ZStack {
                        
                        Text("Create Account")
                            .font(.custom("Poppins-Bold",size: 50))
                            .foregroundColor(.gray)
                            .bold()
                            .padding(.top, 15)
                            .offset(x: -2, y: -2)
                        
                        Text("Create Account")
                            .font(.custom("Poppins-Bold",size: 50))
                            .bold()
                            .padding(.top, 15)
                        
                        if !currentUserRegistration.errorMessageR.isEmpty {
                            
                            Text(currentUserRegistration.errorMessageR)
                                .offset(y: 280)
                                .font(.custom("Poppins",size: 20))
                                .foregroundColor(.red)
                                .padding(.top, 15)
                        }
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    
                    
                    //Avatars
                    ScrollView {
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 20){
                                
                                
                                ForEach(currentUserRegistration.avatars.indices) { index in
                                    
                                    
                                    
                                    GeometryReader { proxy in
                                        
                                        
                                        
                                        let scale = getScale(proxy: proxy)
                                        let off = getOffset(proxy: proxy)
                                        
                                        
                                        
                                        
                                        Button {
                                            
                                            print(index)
                                            currentUserRegistration.clickedAvatarIndex = index
                                            
                                            
                                            
                                        }
                                    label: {
                                        ZStack {
                                            
                                            
                                            
                                            //Corousel
                                            Image(uiImage: currentUserRegistration.avatars[index]!)
                                                .resizable()
                                                .scaledToFit()
                                                .offset(y: off)
                                                .frame(width: 140)
                                                .clipped()
                                                .scaleEffect(CGSize(width: scale, height: scale))
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                    }
                                        
                                        
                                        
                                        
                                    }.background(.clear)
                                        .frame(width: 150, height: 150)
                                    
                                    //                                      viewModel.icon = avatars[index]!
                                    //                                      setUserIcon(image: avatars[index]!)
                                    
                                }
                                
                                
                            }.padding(32)
                                .padding(.top, 10)
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    VStack {
                        
                        
                        
                        
                        //Name
                        ZStack {
                            
                            
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black)
                                .frame(width: 380, height: 40)
                            
                            TextField("", text: $currentUserRegistration.name)
                                .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                .textFieldStyle(.plain)
                                .autocapitalization(.none)
                                .placeholder(when: currentUserRegistration.name.isEmpty) {
                                    Text("                              Name")
                                        .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                        .font(.custom("Poppins-Regular",size: 18))
                                }.frame(width: 350)
                            
                        }.padding(.bottom, 50)
                        
                        
                        
                        //Email Field
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black)
                                .frame(width: 380, height: 40)
                            
                            TextField("", text: $currentUserRegistration.email)
                                .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                .textFieldStyle(.plain)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .placeholder(when: currentUserRegistration.email.isEmpty) {
                                    Text("                               Email")
                                        .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                        .font(.custom("Poppins-Regular",size: 18))
                                        .multilineTextAlignment(.center)
                                    
                                }.frame(width: 350)
                            
                            
                            
                        }.padding(.bottom, 50)
                        
                        
                        
                        
                        //Password field
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black)
                                .frame(width: 380, height: 40)
                            
                            SecureField("", text: $currentUserRegistration.password)
                                .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                .textFieldStyle(.plain)
                                .autocapitalization(.none)
                                .placeholder(when: currentUserRegistration.password.isEmpty) {
                                    Text("                            Password")
                                        .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                        .font(.custom("Poppins-Regular",size: 18))
                                }.frame(width: 350)
                            
                            
                        }.padding(.bottom, 50)
                        
                        
                        
                        //Birthday
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black)
                                .frame(width: 380, height: 40)
                            
                            HStack {
                                
                                
                                Spacer()
                                Spacer()
                                
                                ZStack {
                                    
                                    Text("  Birthday:  ")
                                        .font(.custom("Poppins-Regular",size: 18))
                                        .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                                    
                                    
                                }//.offset(x: 100)
                                
                                ZStack {
                                    
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.gray)
                                        .frame(width: 112, height: 29)
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 110, height: 28)
                                        .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
                                    
                                    
                                    DatePicker("", selection: $currentUserRegistration.birthday, in: startingDate...endingDate, displayedComponents: [.date])
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                        .background(.clear) // changes the background color
                                        .accentColor(.black) // changes the tint color
                                        .frame(width: 122)
                                    
                                    
                                    //                            .offset(x: 110)
                                    
                                    
                                }
                                Spacer()
                                Spacer()
                                
                                
                                
                            }
                            
                            
                        }.padding(.bottom, 50)
                        
                        
                        
                        
                    }.padding(.bottom)
                    
                    
                    
                    Spacer()
                    
                    
                    Button {
                        
               
                        currentUserRegistration.register()
                        
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


                                Text("Go")
                                    .foregroundColor(.black)
                                    .font(.custom("Poppins-Bold",size: 30))

                            }.offset(x:-2, y:-4)

                        }
                        
                    }.padding(.bottom, 10)
                    
                    
                    
                } //VStack
                
                
            } //ZStack
            
            //Nav Stack
        }.navigationViewStyle(StackNavigationViewStyle())
            .fullScreenCover(isPresented: $showingLoginView) {
                LoginView() }.cornerRadius(20).ignoresSafeArea()
            .onAppear{
                        currentUserRegistration.email = ""
                        currentUserRegistration.password = ""   }
        
        
    } //Body
    
}//Struct













struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(Authentication())
    }
}
