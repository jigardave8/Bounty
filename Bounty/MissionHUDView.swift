//
//  MissionHUDView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI
import WebKit

struct YouTubeStreamView: UIViewRepresentable {
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false // Native iOS scroll lock
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let urlString = "https://www.youtube.com/live/\(videoId)?autoplay=1&playsinline=1&mute=1"
        if let url = URL(string: urlString) {
            uiView.load(URLRequest(url: url))
        }
    }
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // CSS/JS Injection: Disable scrolling + Hide clutter
            let script = """
            document.body.style.overflow = 'hidden';
            document.addEventListener('touchmove', function(e) { e.preventDefault(); }, { passive: false });
            """
            webView.evaluateJavaScript(script)
        }
    }
}

struct MissionHUDView: View {
    @Environment(BountyStore.self) private var store
    let bounty: Bounty
    @State private var jamTrigger: Int = 0

    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            
            // 1. Native Player
            YouTubeStreamView(videoId: bounty.ytVideoId)
                .ignoresSafeArea()
            
            // 2. The Clutter Shield
            // Increased height and adjusted offset to ensure 100% of the area below the player is covered
            Rectangle()
                .fill(Color.black)
                .frame(height: 800)
                .offset(y: 400)
                .allowsHitTesting(false)
            
            // 3. HUD Layer
            VStack {
                HStack {
                    Text(bounty.title.uppercased())
                        .font(Theme.terminalFont)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                // Interaction Deck
                HStack(spacing: 60) {
                    Image(systemName: "largecircle.fill.circle")
                        .font(.system(size: 60))
                        .foregroundColor(Theme.heroCyan)
                        .gesture(
                            DragGesture().onEnded { val in
                                if val.translation.width > 50 { _ = store.dispatchThermalPulse(bountyId: bounty.id, isHero: true) }
                            }
                        )
                    
                    Image(systemName: "xmark.shield.fill")
                        .font(.system(size: 60))
                        .foregroundColor(Theme.chaosRed)
                        .gesture(
                            DragGesture().onEnded { val in
                                if val.translation.width < -50 {
                                    if !store.dispatchThermalPulse(bountyId: bounty.id, isHero: false) { jamTrigger += 1 }
                                }
                            }
                        )
                        .sensoryFeedback(.impact(weight: .heavy), trigger: jamTrigger)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear { store.tuneIntoThermalFrequency(bountyId: bounty.id) }
        .onDisappear { store.dropThermalFrequency(bountyId: bounty.id) }
    }
}
