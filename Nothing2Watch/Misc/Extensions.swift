//
//  Extensions.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/15/23.
//

import SwiftUI

//For storing user data in database
extension Encodable {
    
    func asDictionary() -> [String: Any] {
        
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
             
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
            
        } catch {
            return [:]
        }
    }
    
}

//Get bounds of view
extension View{
    
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
    
    
    
    //retreive RootView Controller
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
        
    }
    
    
    
    
    
    // Navigate to a new view.
        // - Parameters:
        //   - view: View to navigate to.
        //   - binding: Only navigates when this condition is `true`.
        func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
            NavigationView {
                ZStack {
                    self
                        .navigationBarTitle("")
                        .navigationBarHidden(true)

                    NavigationLink(
                        destination: view
                            .navigationBarTitle("")
                            .navigationBarHidden(true),
                        isActive: binding
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    
    
}






extension View {

    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }


}
