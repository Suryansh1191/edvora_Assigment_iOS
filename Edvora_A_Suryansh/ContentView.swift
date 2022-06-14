//
//  ContentView.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var UserViewModel = UserDataVM()
    @State var isLoading = true
    
    var body: some View {
        
        if isLoading {
            ProgressView()
                .onAppear{
                    UserViewModel.InitUserdata { _ in
                        isLoading = false
                    }
                }
        }else{
            HomeView()
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
