import UIKit
import Lottie

class LoadingView {
    
    static let shared = LoadingView()
    let window = UIApplication.shared.windows[0]
    var blurView = UIVisualEffectView()
    var animationView = LottieAnimationView()
    var loadingView = UIView()
    var loadingLabel = UILabel()
  
    func endLoading() {
        animationView.removeFromSuperview()
        blurView.removeFromSuperview()
    }
    
    func startLoading(loadingText: String = "", rootView: UIView? = nil) {
        let targetView = rootView ?? window
        
        if blurView.superview == nil {
            blurView.frame = targetView.bounds
            blurView.effect = UIBlurEffect(style: .dark)
            targetView.addSubview(blurView)
            
            setupLoadingView(targetView)
            setupAnimationView()
            setupLoadingLabel(loadingText: loadingText)
        } else {
            loadingLabel.text = loadingText
        }
    }
   
    private func setupLoadingView(_ rootView: UIView) {
        blurView.contentView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.layer.cornerRadius = 75
        loadingView.layer.masksToBounds = true
        let constraints = [
            loadingView.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 150),
            loadingView.heightAnchor.constraint(equalToConstant: 150)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupAnimationView() {
        loadingView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.animation = LottieAnimation.named("loading")
        animationView.play()
        animationView.loopMode = .loop
        let constraints = [
            animationView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLoadingLabel(loadingText: String) {
        loadingView.addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.text = loadingText
        loadingLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        loadingLabel.textColor = .white.withAlphaComponent(0.8)
        let constraints = [
            loadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingLabel.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor, constant: -18),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
