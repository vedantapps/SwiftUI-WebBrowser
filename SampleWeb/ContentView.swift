//
//  ContentView.swift
//  SampleWeb
//
//  Created by @vedantapps on 3/13/22.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    @State var linkToSave = "www.apple.com"
    @FocusState var textFocus: Bool
    @State var urlToLoad = "https://www.apple.com"
    @State var id = 0
    
    var body: some View {
        
        let webView = WebBrowser(request: URLRequest(url: URL(string: urlToLoad)!))
        
        VStack{
            webView
                .id(id)
                .cornerRadius(15)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .shadow(radius: 25)
            
            VStack{
                HStack {
                    TextField("Website URL", text: $linkToSave)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($textFocus)
                        .frame(maxWidth: 300)
                        .padding(.bottom, 5)
                        .onSubmit {
                            let removeHTTP = linkToSave.replacingOccurrences(of: "http://", with: "").replacingOccurrences(of: "https://", with: "")
                            linkToSave = removeHTTP
                            urlToLoad = "https://\(removeHTTP)"
                            id += 1
                        }
                    
                    
                    Button {
                        textFocus = false
                        let removeHTTP = linkToSave.replacingOccurrences(of: "http://", with: "").replacingOccurrences(of: "https://", with: "")
                        linkToSave = removeHTTP
                        urlToLoad = "https://\(removeHTTP)"
                        id += 1
                    } label: {
                        Image(systemName: "arrow.forward.circle")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        webView.goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    
                    Spacer()
                    
                    Button {
                        webView.goForward()
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    
                    Spacer()
                    
                    Button {
                        webView.refresh()
                    } label: {
                        Image(systemName: "goforward")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 5)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Web Browser

struct WebBrowser: UIViewRepresentable {
    
    let webView: WKWebView?
    let webRequest: URLRequest
    
    init(request: URLRequest) {
        self.webView = WKWebView()
        self.webRequest = request
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView?.load(webRequest)
    }
    
    func goBack() {
        webView?.goBack()
    }
    
    func goForward() {
        webView?.goForward()
    }
    
    func refresh() {
        webView?.reload()
    }
}
