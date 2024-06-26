//
//  CalenderView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.
//

import SwiftUI

struct CalenderView: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 362, height: 165)
                .background(Color(red: 0.44, green: 0.44, blue: 0.47))
                .cornerRadius(25)
        }
    }
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}

