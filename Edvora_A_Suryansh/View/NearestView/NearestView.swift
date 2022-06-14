//
//  NearestView.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import SwiftUI

struct NearestView: View {
    @Binding var isFilterOpen: Bool
    @ObservedObject var ViewModel = NearestRiderVM()
    @State var isRiderDeatiledView = false
    @State var riderDeatilsForSheet: RiderExtraInfoModel = RiderExtraInfoModel.example()
    @State var stateInfo = riderStateCityInfoStore.stateCityData
    @State var selectedState: String = ""
    @State var selectCity = [""]
    @State var selectedCity = ""
    
    var filteredRider: [RiderExtraInfoModel] {
            if !isFilterOpen {
                return ViewModel.nearestRiderArrya
            }
            if selectedState.count == 0 {
                return ViewModel.nearestRiderArrya
            }else {
                if selectedCity.count == 0 {
                    return ViewModel.nearestRiderArrya.filter { $0.riderDetails.state.contains(selectedState) }
                }else {
                    return ViewModel.nearestRiderArrya.filter { $0.riderDetails.city.contains(selectedCity) }
                }
            }
    }
    
    
    var body: some View {
        VStack{
            if isFilterOpen {
                VStack(alignment: .leading){
                    Text("Filter")
                        .font(.title)
                    HStack{
                        Text("Select State: ")
                        Picker("Select State", selection: $selectedState) {
                            ForEach(stateInfo , id: \.self) { i in
                                Text("\(i.state)").tag(i.state)
                            }
                        }.pickerStyle(.menu)
                        Spacer()
                    }
                    HStack{
                        Text("Select City: ")
                        Picker("Select City", selection: $selectedCity) {
                            ForEach(selectCity, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                        Spacer()
                    }

                }.padding()
                    .background(.white)
                
                    .onChange(of: selectedState) { newValue in
                        for i in stateInfo {
                            if i.state == selectedState {
                                selectCity = i.city
                                selectedCity = i.city[0]
                            }
                        }
                    }
            }
            
            ScrollView{
                ForEach(filteredRider){ rider in
                    RiderOneView(riderInfo: rider)
                        .onTapGesture(perform: {
                            DispatchQueue.main.async {
                                riderDeatilsForSheet = rider
                                isRiderDeatiledView = true
                                print(riderDeatilsForSheet)
                            }
                            
                        })
                        .padding()
                }
            }

        }.onAppear{
            ViewModel.getRiderDetails { status in
                stateInfo = riderStateCityInfoStore.stateCityData
            }
        }
        .sheet(isPresented: $isRiderDeatiledView) {
            RiderSheetView(riderDetails: $riderDeatilsForSheet)
        }
        .overlay(
            ZStack{
                if ViewModel.isLoading{
                    Color.white
                        .opacity(1)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
    }
}
