//
//  ViewController.swift
//  travel-app
//
//  Created by Y u l i a on 21.07.2021.
//

import UIKit

struct LandingItem {
    let title: String
    let detail: String
    let backgroundImage: UIImage?
}

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    private let items: [LandingItem] = [
        .init(
            title: "Explore The World",
            detail: "Travel doesn't become adventure until you leave yourself behind",
            backgroundImage: UIImage(named: "1")),
        .init(
            title: "Let's Make Your Best Trip Ever",
            detail: "The best travel for your journey respectful for the environment",
            backgroundImage: UIImage(named: "2")),
        .init(
            title: "Live Your Dream Now",
            detail: "Never stop exploring",
            backgroundImage: UIImage(named: "3"))
    ]
    
    private var currentItem: Int = 0
    
    func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    func setupScreen(index: Int) {
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
        
        titleLabel.alpha = 1.0
        detailLabel.alpha = 1.0
        titleLabel.transform = .identity
        detailLabel.transform = .identity
    }
    
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupImage(index: Int) {
        backgroundImage.image = items[index].backgroundImage
        
        UIView.transition(
            with: backgroundImage,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
            self.backgroundImage.image = self.items[index].backgroundImage
        },
            completion: nil)

    }
    
    @objc private func handleTapAnimation() {
        print("Tap")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.detailLabel.alpha = 0.8
            self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.detailLabel.alpha = 0
                self.detailLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }) {
                _ in
                
                self.currentItem += 1
                
                if (self.currentItem == self.items.count) {
                    print("Last!")
                    self.showMainApp()
                } else {
                    print(self.currentItem, self.items.count)
                    self.setupScreen(index: self.currentItem)
                    self.setupImage(index: self.currentItem)
                }
            }
        }
    }
    
    private func showMainApp() {

        let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainAppViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = mainAppViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        setupScreen(index: currentItem)
        setupGestures()
    }

}

