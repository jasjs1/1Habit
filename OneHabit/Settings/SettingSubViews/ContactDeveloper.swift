//
//  ContactDeveloper.swift
//  OneHabit
//
//  Created by Jayce Sagvold on 6/25/23.
//

import SwiftUI

struct ContactDeveloper: View {
    var body: some View {
        VStack {
            List {
                Image("DeveloperProiflePicture")
                    .resizable()
                    .frame(width: 302, height: 302)
                    .clipShape(Circle())
                    .padding(.bottom, 2.65)
                
                Text("Hey, I'm Jayce. The developer that made this app. If you need to contact me you can contact me below!")
                
                Link("Email - contactjaycesagvold@duck.com", destination: URL(string: "mailto:contactjaycesagvold@duck.com")!)
                Link("Twitter - JayceSagvold2", destination: URL(string: "twitter.com/JayceSagvold2")!)

            }
        }
    }
}

struct ContactDeveloper_Previews: PreviewProvider {
    static var previews: some View {
        ContactDeveloper()
    }
}
