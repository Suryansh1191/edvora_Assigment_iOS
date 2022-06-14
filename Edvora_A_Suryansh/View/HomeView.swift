//
//  HomeView.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import SwiftUI

struct HomeView: View {
    @State var selectedView = Tabs.NearestRider
    @State var isFilterOpen = false
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Edcora")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                AsyncImage(url: URL(string: UserStoredData.userData?.url ?? "")) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            
                    } else if phase.error != nil {
                        Text(phase.error?.localizedDescription ?? "error")
                            .foregroundColor(Color.pink)
                    } else {
                        ProgressView()
                    }
                }.frame(width: 40, height: 40)
            }.padding()
            
            HStack{
                Text("Nearest")
                    .foregroundColor(self.selectedView == .NearestRider ? .black : .gray)
                    .underline(self.selectedView == .NearestRider, color: .blue)
                    .padding(.leading)
                    .onTapGesture {
                        withAnimation {
                            self.selectedView = .NearestRider
                        }
                        
                    }
                Spacer()
                Text("Upcoming")
                    .underline(self.selectedView == .UpcomingRider, color: .blue)
                    .foregroundColor(self.selectedView == .UpcomingRider ? .black : .gray)
                    .onTapGesture {
                        withAnimation {
                        self.selectedView = .UpcomingRider
                        }
                    }
                Spacer()
                Text("Past")
                    .foregroundColor(self.selectedView == .PastRider ? .black : .gray)
                    .underline(self.selectedView == .PastRider, color: .blue)
                    .onTapGesture {
                        withAnimation {
                        self.selectedView = .PastRider
                        }
                    }
                Spacer()
                HStack(spacing: 0){
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.blue)
                        .padding(.leading, 10)

                    Text("Filter")
                        .onTapGesture(perform: {
                            withAnimation {
                                if !isFilterOpen {
                                    isFilterOpen = true
                                }else{
                                    isFilterOpen = false
                                }
                                
                            }
                        
                        })
                        .padding(.leading, 3)
                        .padding(.trailing)
                }
            }
            
            if selectedView == .NearestRider{
                NearestView(isFilterOpen: $isFilterOpen)

            }else if selectedView == .PastRider {
                PastRiderView()
            }else{
                UpcomeingRiderView()
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

enum Tabs {
    case NearestRider
    case UpcomingRider
    case PastRider
}
