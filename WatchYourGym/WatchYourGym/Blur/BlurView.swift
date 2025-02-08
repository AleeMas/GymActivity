import SwiftUI
import Foundation

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        let strongerEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        view.contentView.addSubview(strongerEffectView)
        strongerEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strongerEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            strongerEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            strongerEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            strongerEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // Nothing to update
    }
}
