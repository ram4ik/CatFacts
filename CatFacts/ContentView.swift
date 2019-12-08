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
    @State var allPages = [Item]()
    
    var body: some View {
        TabView {
            VStack {
                Spacer()
                Text(self.fact)
                    .font(.title)
                    .padding()
                Spacer()
                Button(action: {
                    self.loadPage()
                }) {
                    Image(systemName: "arrow.2.circlepath")
                        .font(.title)
                }
            .padding()
            }
            .tabItem({
                Image(systemName: "leaf.arrow.circlepath")
                    .resizable()
                    .font(.title)
            })
            .onAppear(){
                self.loadPage()
                self.loadAllPages()
            }
            
            VStack {
                ScrollView {
                    ForEach(self.allPages, id: \.id) {row in
                        ItemView(item: row)
                    }
                }
                Divider()
            }
            .tabItem {
                Image(systemName: "list.bullet.below.rectangle")
                    .resizable()
                    .font(.title)
            }
            .onAppear() {
                self.loadAllPages()
            }
        }
    }
    
    func loadPage() {
        NetworkManager.fetchPage { page in
            DispatchQueue.main.async {
                self.fact = page.text ?? "n/a"
            }
        }
    }
    
    func loadAllPages() {
        NetworkManager.fetchAllPages { pages in
            DispatchQueue.main.async {
                self.allPages.append(contentsOf: pages.all)
            }
        }
    }
}

struct ItemView: View {
    @State var item: Item
    var body: some View {
        VStack {
            Text("\(item.text ?? "n/a")")
                .foregroundColor(.primary)
                .padding()
            HStack {
                Spacer()
                Text("by \(item.user?.name?.first ?? "n/a") \(item.user?.name?.last ?? "n/a")")
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
