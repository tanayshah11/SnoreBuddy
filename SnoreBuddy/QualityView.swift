//
//  QualityView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.
//

//import SwiftUI
//
//struct QualityView: View {
//
//    var quality: Double // Add a property to accept the sleep quality metric
//
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 175, height: 123)
//                .background(Color(red: 0.53, green: 0.57, blue: 0.62))
//                .cornerRadius(15)
//
//            Image("quality")
//                .frame(width: 24, height: 24)
//                .padding([.top, .trailing], 10)
//
//            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
//                Text("\(String(format: "%.1f", quality))%")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(.bottom, 10)
//            })
//        }
//    }
//}
//
//#Preview {
//    QualityView(quality: 85.0)
//}

//
//  QualityView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.
//

import SwiftUI

struct QualityView: View {
    var quality: Double // Add a property to accept the sleep quality metric

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 175, height: 123)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.smallTab, Color.bigTab]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                .overlay(
                    VStack {
                        Text("Quality")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        Text("\(String(format: "%.1f", quality))%")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                )
            
            Image("quality")
                .resizable()
                .frame(width: 24, height: 24)
                .padding([.top, .trailing], 10)
        }
    }
}

#Preview {
    QualityView(quality: 85.0) // Provide a sample quality value for preview
}

