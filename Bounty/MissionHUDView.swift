//
//  MissionHUDView.swift
//  Bounty
//
//  Created by BitDegree on 02/05/26.
//

import SwiftUI
import WebKit

// WKWebView Wrapper
struct YouTubeStreamView: UIViewRepresentable {
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)?playsinline=1&controls=0&autoplay=1&mute=1") else { return }
        uiView.load(URLRequest(url: url))
    }
}

struct MissionHUDView: View {
    let bounty: Bounty
    @State private var tipDragOffset: CGFloat = 0
    @State private var localO: Int = 0
    @State private var localX: Int = 0

    var body: some View {
        ZStack {
            Theme.voidBlack.ignoresSafeArea()
            
            // Video Feed (Ignore Safe Area for immersion)
            YouTubeStreamView(videoId: bounty.ytVideoId)
                .ignoresSafeArea()
                .opacity(0.8) // Simulate sunglasses/hud shade
            
            // UI Overlay
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("SYNC: -10s DELAY")
                            .font(Theme.terminalFont)
                            .foregroundColor(.white)
                        Text(bounty.target.uppercased())
                            .font(.caption)
                            .foregroundColor(Theme.heroCyan)
                    }
                    Spacer()
                }
                .padding()
                .background(.ultraThinMaterial)
                
                Spacer()
                
                // Thermal Action Pool Data
                HStack(alignment: .bottom) {
                    VStack {
                        Text("O-POOL: \(bounty.poolO + localO)")
                            .font(Theme.terminalFont).foregroundColor(Theme.heroCyan)
                        Text("X-POOL: \(bounty.poolX + localX)")
                            .font(Theme.terminalFont).foregroundColor(Theme.chaosRed)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Drag interactions (Swipe to cast decision)
                HStack {
                    Image(systemName: "largecircle.fill.circle")
                        .font(.system(size: 40))
                        .foregroundColor(Theme.heroCyan)
                        .offset(x: min(tipDragOffset, 0) == 0 ? max(0, tipDragOffset) : 0) // Stretch effect logic mapped right
                        .gesture(
                            DragGesture()
                                .onChanged { val in if val.translation.width > 0 { tipDragOffset = val.translation.width } }
                                .onEnded { val in resolveDrag(val.translation.width, isHero: true) }
                        )
                        .sensoryFeedback(.impact(weight: .heavy), trigger: localO)

                    Spacer()
                    
                    Image(systemName: "xmark.shield.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Theme.chaosRed)
                        .offset(x: max(tipDragOffset, 0) == 0 ? min(0, tipDragOffset) : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { val in if val.translation.width < 0 { tipDragOffset = val.translation.width } }
                                .onEnded { val in resolveDrag(val.translation.width, isHero: false) }
                        )
                        .sensoryFeedback(.impact(weight: .heavy), trigger: localX)
                }
                .padding(32)
            }
        }
        .toolbar(.hidden, for: .navigationBar) // Hide bar inside the cockpit
    }
    
    private func resolveDrag(_ translation: CGFloat, isHero: Bool) {
        let threshold: CGFloat = 80
        if abs(translation) > threshold {
            if isHero { localO += 10 } else { localX += 10 }
        }
        withAnimation(Theme.tacticalSpring) {
            tipDragOffset = 0
        }
    }
}
