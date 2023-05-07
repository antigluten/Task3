//
//  ViewController.swift
//  Task3
//
//  Created by va-gusev on 07.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var animator = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut)
    let slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let roundedView = UIView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = .link
        roundedView.layer.cornerRadius = 8
        roundedView.clipsToBounds = true
        view.addSubview(roundedView)
        
        NSLayoutConstraint.activate([
            roundedView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            roundedView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            roundedView.heightAnchor.constraint(equalToConstant: 80),
            roundedView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(released), for: .touchUpInside)
        
        animator.pausesOnCompletion = true
        animator.addAnimations { [unowned self, unowned roundedView] in
            let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            roundedView.transform = CGAffineTransform(rotationAngle: .pi / 2).concatenating(transform)
            let bounds = roundedView.frame.applying(transform)
            roundedView.center.x = self.view.bounds.width - bounds.midX
        }
    }
    
    @objc func valueChanged() {
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    @objc func released() {
        slider.setValue(1.0, animated: true)
        animator.startAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        slider.frame = CGRect(x: view.layoutMargins.left,
                              y: 220,
                              width: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right,
                              height: 40)
    }
}

