//
//  RiderSheetView.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 14/06/22.
//

import SwiftUI

struct RiderSheetView: View {
    @Binding var riderDetails: RiderExtraInfoModel
    @State var distance = 0

    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "\(riderDetails.riderDetails.mapURL ?? "https://www.setra.com/blog/what-is-crc-error")")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 220)
            .padding()
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Rider Id")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(riderDetails.riderDetails.id)")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Origin Station")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(riderDetails.riderDetails.originStationCode )")
                            .foregroundColor(.black)
                    }
                }
                
                Divider()
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Date")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(riderDetails.riderDetails.date )")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Distance")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(distance)")
                            .foregroundColor(.black)
                    }
                }
                
                Divider()

                
                HStack{
                    VStack(alignment: .leading){
                        Text("State")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(riderDetails.riderDetails.state )")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("City")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(riderDetails.riderDetails.city )")
                            .foregroundColor(.black)
                    }
                }
                
                Divider()

                HStack{
                    VStack(alignment: .leading){
                        Text("Station Path")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack{
                            ForEach(riderDetails.riderDetails.stationPath , id: \.self){
                            Text("\($0)")
                                .foregroundColor(.black)
                        }
                        }
                        
                    }
                    Spacer()
                }
                
                Spacer()

            }.onAppear{
                distance = abs(riderDetails.stationsClosestToUser - (UserStoredData.userData?.stationCode ?? 0))
            }
            .padding()
            .shadow(radius: 14)
        }
    }
}

//struct RiderSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        RiderSheetView(riderDetails: RiderExtraInfoModel.example())
//    }
//}
