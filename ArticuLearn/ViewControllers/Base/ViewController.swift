//
//  ViewController.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit
import RxSwift

// MARK: - NavigationBarConfigurable

protocol NavigationBarConfigurable {
    func configureNavigationBar()
    func addShadowToNavigationBar()
}

// MARK: - ViewController

open class ViewController<VM: ViewModel>: UIViewController, NavigationBarConfigurable {

    open var disposeBag = DisposeBag()
    open var hideNavigationBarIfNeeded = false
    open var hideBackButtonIfNeeded = false

    private let navigationBarVisibilityManager: NavigationBarVisibilityManager = .init()
    
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
        Log.log(type: .info, message: "\(className) deinit")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        binding()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarVisibilityManager.adjustNavigationBarVisibilityIfNeeded(for: self,
                                                                             hideNavigationBarIfNeeded: hideNavigationBarIfNeeded)
        addShadowToNavigationBar()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBarVisibilityManager.restorePreviousNavigationBarVisibility(for: self)
    }

    open func setupUI() {
        view.backgroundColor = .white
        configureBackButton()
    }

    open func binding() {}

    @objc open func goBack() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else {
            navigationController?.dismiss(animated: true)
        }
    }

    // MARK: - NavigationBarConfigurable

    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primary]

        if hideBackButtonIfNeeded {
            navigationItem.leftBarButtonItem = nil
        }
    }

    func addShadowToNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }

        view.viewWithTag(999)?.removeFromSuperview()

        let topPadding = AppManager.default.lastWindow?.safeAreaInsets.top ?? 0
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: abs(navigationBar.frame.height) + topPadding))
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

    private func configureBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .primary
        navigationItem.leftBarButtonItem = backButton
    }
}
