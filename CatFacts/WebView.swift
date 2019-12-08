//
//  WebView.swift
//  CatFacts
//
//  Created by Ramill Ibragimov on 08.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebview = WKWebView()
        wkWebview.load(request)
        return wkWebview
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}
