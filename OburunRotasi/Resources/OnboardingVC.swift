//
//  OnboardingVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 22.10.2023.
//

//import UIKit
//
//class OnboardingVC: UIPageViewController {
//    
//    var pages = [UIViewController]()
//    
//    var onboardingCompleted = false
//    
//    private let skipButton : UIButton = {
//        let button = UIButton()
//        button.setTitle("Atla", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
//        
//        return button
//    }()
//    private let nextButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Sonraki", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
//        return button
//    }()
//    
//    let pageControl = UIPageControl()
//    let initialPage = 0
//    
//    var pageControlBottomAnchor: NSLayoutConstraint?
//    var skipButtonTopAnchor: NSLayoutConstraint?
//    var nextButtonTopAnchor: NSLayoutConstraint?
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setup()
//        style()
//        layout()
//        
//        
//    }
//}
//
//extension OnboardingVC {
//    
//    func setup() {
//        
//        dataSource = self
//        delegate = self
//        
//        pageControl.addTarget(self, action: #selector(pageControlTapped(_: )), for: .valueChanged)
//        
//        let page1 = Deneme1()
//        let page2 = Deneme2()
//        let page3 = Deneme3()
//        let page4 = TabBarVC()
//        
//        pages.append(page1)
//        pages.append(page2)
//        pages.append(page3)
//        pages.append(page4)
//        
//        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
//    }
//    
//    func style() {
//        
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.currentPageIndicatorTintColor = .black
//        pageControl.numberOfPages = pages.count
//        pageControl.currentPage = initialPage
//        
//        skipButton.translatesAutoresizingMaskIntoConstraints = false
//        skipButton.addTarget(self, action: #selector(skipTapped(_: )), for: .primaryActionTriggered)
//        
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.addTarget(self, action: #selector(nextTapped(_: )), for: .primaryActionTriggered)
//        
//    }
//    
//    func layout() {
//        view.addSubview(pageControl)
//        view.addSubview(nextButton)
//        view.addSubview(skipButton)
//        
//        
//        NSLayoutConstraint.activate([
//            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: view.frame.height/3),
//            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
//            
//            skipButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2)
//        ])
//        
//        
//        pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2)
//        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
//        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
//        
//        pageControlBottomAnchor?.isActive = true
//        skipButtonTopAnchor?.isActive = true
//        nextButtonTopAnchor?.isActive = true
//        
//        
//        
//    }
//}
//
//extension OnboardingVC {
//    
//    @objc func pageControlTapped(_ sender: UIPageControl) {
//        
//        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
//        
//        animateControlsIfNeeded()
//    }
//    
//    @objc func skipTapped(_ sender: UIButton) {
//        
//        let lastpage = pages.count - 1
//        pageControl.currentPage = lastpage
//        
//        goToSpecificPage(index: lastpage, ofViewControllers: pages)
//        animateControlsIfNeeded()
//    }
//    
//    @objc func nextTapped(_ sender: UIButton) {
//        pageControl.currentPage += 1
//        animateControlsIfNeeded()
//    }
//    
//    
//    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
//        
//        guard let currentPage = viewControllers?[0] else { return }
//        
//        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else {return}
//        
//        setViewControllers([nextPage], direction: .forward, animated: true)
//        
//    }
//    
//    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
//        
//        guard let currentPage = viewControllers?[0] else { return }
//        
//        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else {return}
//        
//        setViewControllers([prevPage], direction: .forward, animated: true)
//    }
//    
//    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
//        
//        setViewControllers([pages[index]], direction: .forward, animated: true)
//        
//    }
//    
//}
//
//
//extension OnboardingVC: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//        
//        guard let currentIndex = pages.firstIndex(of: viewController) else {
//            return nil
//        }
//        
//        if currentIndex == 0 {
//            return pages.last
//        } else {
//            return pages[currentIndex-1]
//        }
//        
//        
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//        guard let currentIndex = pages.firstIndex(of: viewController) else {
//            return nil
//        }
//        
//        if currentIndex < pages.count - 1 {
//            return pages[currentIndex + 1]
//        } else {
//            return pages.first
//        }
//    }
//}
//
//extension OnboardingVC: UIPageViewControllerDelegate {
//    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        
//        guard let viewControllers = pageViewController.viewControllers else {
//            return
//        }
//        
//        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else {
//            return
//        }
//        
//        pageControl.currentPage = currentIndex
//        animateControlsIfNeeded()
//        
//    }
//    
//    private func animateControlsIfNeeded() {
//        
//        let lastPage = pageControl.currentPage == pages.count-1
//        
//        if lastPage {
//            hideControls()
//        } else {
//            showControls()
//        }
//        
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0) {
//            self.view.layoutIfNeeded()
//        }
//        
//        
//    }
//    
//    private func hideControls() {
//        pageControlBottomAnchor?.constant = -80
//        skipButtonTopAnchor?.constant = -80
//        nextButtonTopAnchor?.constant = -80
//        
//    }
//    private func showControls() {
//        
//        pageControlBottomAnchor?.constant = 16
//        skipButtonTopAnchor?.constant = 16
//        nextButtonTopAnchor?.constant = 16
//        
//    }
//}


