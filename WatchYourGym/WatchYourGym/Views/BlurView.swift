//
//  BlurView.swift
//  WatchYourGym
//
//  Created by Alessandro Massadoro on 25/05/24.
//

import SwiftUI

struct BlurView: View {
    struct BlurView: UIViewRepresentable {
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            
            let view = UIVisualEffectView(effect: UIBlurEffect(style:
                    .systemUltraThinMaterial))
            return view
        }
        func updateUIView(_ uiview: UIVisualEffectView, context: Context) {
        }
    }
}
