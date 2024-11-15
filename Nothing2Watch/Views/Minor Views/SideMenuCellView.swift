//
//  SideMenuCellView.swift
//  Nothing2Watch
//
//  Created by Daniel Troyano on 6/26/23.
//

import SwiftUI

struct SideMenuCellView: View {
    let viewModel: SidemenuViewModel
    
    
    var body: some View {
      
        HStack(spacing: 16) {
            
            Image(systemName: viewModel.imageName)
                .frame(width: 24, height: 24)
            
            Text(viewModel.title)
                .font(.system(size: 15, weight: .semibold))
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .padding()
        
        
    }
}

struct SideMenuCellView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuCellView(viewModel: .profile)
    }
}
