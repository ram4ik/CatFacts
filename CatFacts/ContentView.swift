//
//  ContentView.swift
//  CatFacts
//
//  Created by Ramill Ibragimov on 08.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var fact: String = ""
    var body: some View {
        VStack {
            Text(self.fact)
                .font(.title)
                .padding()
            Button(action: {
                self.loadPage()
            }) {
                Image(systemName: "arrow.2.circlepath")
            }
        }.onAppear(){
            self.loadPage()
        }
    }
    
    func loadPage() {
        NetworkManager.fetchPage { page in
            DispatchQueue.main.async {
                self.fact = page.text ?? "n/a"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
