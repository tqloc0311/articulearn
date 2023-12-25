//
//  SplashViewController.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import RxSwift
import RxCocoa

class SplashViewController: ViewController<SplashViewModel> {
    
    // MARK: Rx
    
    private let rxViewWillAppear: PublishRelay<Void> = .init()
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rxViewWillAppear.accept(())
    }
    
    // MARK: UI
    
    override func setupUI() {
        super.setupUI()
        
        hideNavigationBarIfNeeded = true
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.image = UIImage(named: "app_logo")
        imageView.snp.makeConstraints { make in
            make.width
                .equalToSuperview()
                .multipliedBy(0.7)
            
            make.width.equalTo(imageView.snp.height)
            make.center.equalToSuperview()
        }
        
        let indicatorView = NVActivityIndicatorView(frame: .zero)
        view.addSubview(indicatorView)
        indicatorView.type = .ballPulse
        indicatorView.color = .black
        indicatorView.startAnimating()
        indicatorView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
        
        let slogan = UILabel()
        view.addSubview(slogan)
        slogan.textAlignment = .center
        slogan.numberOfLines = 0
        slogan.text = "Master the Art of Communication. \nWhere Words Transform into Wisdom."
        slogan.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    // MARK: Binding
    
    override func binding() {
        super.binding()
        
        let output = viewModel.transform(input: .init(trigger: rxViewWillAppear.asDriverOnErrorJustComplete()))
        output.configured
            .drive(onNext: { [weak self] in
                self?.showNextScreen()
            })
            => disposeBag
    }
    
    private func showNextScreen() {
        let vc = TabBarViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
