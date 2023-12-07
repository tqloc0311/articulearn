//
//  ViewController.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit
import RxSwift

open class ViewController<VM: ViewModel>: UIViewController {
    
    open var disposeBag = DisposeBag()
    open var hideNavigationBarIfNeeded = false
    open var hideBackButtonIfNeeded = false
    private var isNavigationBarHidden = false
    internal let viewModel: VM
    
    public init(viewModel: VM) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        let className = String(describing: type(of: self))
        print("\(className) deinit")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        binding()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isPreviousNavBarHidden = navigationController?.isNavigationBarHidden ?? false
        if isPreviousNavBarHidden != hideNavigationBarIfNeeded {
            isNavigationBarHidden = isPreviousNavBarHidden
            navigationController?.setNavigationBarHidden(hideNavigationBarIfNeeded, animated: animated)
        }
        
        addShadowToNavgationBar()
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primary]
        
        if hideBackButtonIfNeeded {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isNavigationBarHidden != hideNavigationBarIfNeeded {
            navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
        }
    }
    
    open func makeUI() {
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .primary
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc open func goBack() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else {
            navigationController?.dismiss(animated: true)
        }
    }
    
    open func binding() {}
    
    private func addShadowToNavgationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        view.viewWithTag(999)?.removeFromSuperview()
        
        let topPadding = AppManager.default.lastWindow?.safeAreaInsets.top ?? 0
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: abs(navigationController?.navigationBar.frame.height ?? 0) + topPadding))
        shadowView.tag = 999
        shadowView.backgroundColor = .white
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.06
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowRadius = 16
        shadowView.layer.zPosition = CGFloat.infinity
        view.addSubview(shadowView)
    }
}
