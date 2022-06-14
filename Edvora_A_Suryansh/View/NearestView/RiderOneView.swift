//
//  RiderOneView.swift
//  Edvora_A_Suryansh
//
//  Created by suryansh Bisen on 11/06/22.
//

import SwiftUI

struct RiderOneView: View {
    @State var riderInfo: RiderExtraInfoModel
    var body: some View {
        VStack(spacing: 0){
            AsyncImage(url: URL(string: "\(riderInfo.riderDetails.mapURL ?? "https://www.setra.com/blog/what-is-crc-error")")) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }

            HStack{
                Text("#")
                    .foregroundColor(.blue)
                Text("\(riderInfo.riderDetails.id)")
                Spacer()
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text("\(riderInfo.riderDetails.date )")
            }.padding()
                .background(Color.gray.opacity(0.24))
        }.background(.white)
            .cornerRadius(15)

    }
}

//struct RiderOneView_Previews: PreviewProvider {
//    static var previews: some View {
//        RiderOneView()
//    }
//}
