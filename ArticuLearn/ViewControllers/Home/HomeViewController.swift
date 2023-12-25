//
//  HomeViewController.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController<HomeViewModel> {
    
    // MARK: Outlets
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        let collectionView = CollectionViewBuilder(collectionViewLayout: flowLayout)
            .withDataSource(self)
            .withDelegate(self)
            .withBackgroundColor(.white)
            .withRegisterCell(LessonTileCollectionCell.self, reuseIdentifier: Constants.lessonCellIdentifier)
            .withFlowLayout(flowLayout)
            .withPaging(true)
            .withScrollIndicator(vertical: false, horizontal: false)
            .build()
        return collectionView
    }()
    
    private lazy var listeningButton: UIButton = {
        let button = ButtonBuilder()
            .withTitle("Listen")
            .withTarget(self, action: #selector(self.startListening), for: .touchUpInside)
            .withCornerRadius(8)
            .withBorder(width: 1, color: .black)
            .withTitleColor(.black)
            .withTintColor(.black)
            .withLeftIcon(UIImage(systemName: "speaker"))
            .build()
        return button
    }()
    
    private lazy var readingButton: UIButton = {
        let button = ButtonBuilder()
            .withTitle("Read")
            .withTarget(self, action: #selector(self.startReading), for: .touchUpInside)
            .withCornerRadius(8)
            .withBorder(width: 1, color: .black)
            .withTitleColor(.black)
            .withTintColor(.black)
            .withLeftIcon(UIImage(systemName: "mic"))
            .build()
        return button
    }()
    
    // MARK: Properties
    
    private let rxViewWillAppear: PublishRelay<Void> = .init()
    private var currentIndex: Int = 0
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rxViewWillAppear.accept(())
    }
    
    // MARK: UI
    
    override func setupUI() {
        super.setupUI()
        
        hideBackButtonIfNeeded = true
        navigationItem.title = "ArticuLearn"
        
        let buttonStackView = StackViewBuilder()
            .withAxis(.horizontal)
            .withDistribution(.fillEqually)
            .withArrangedSubviews([listeningButton, readingButton])
            .withSpacing(12)
            .build()
        
        buttonStackView
            .snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        
        let contentStackView = StackViewBuilder()
            .withAxis(.vertical)
            .withDistribution(.fill)
            .withArrangedSubviews([collectionView, buttonStackView])
            .add(to: view)
            .withSpacing(16)
            .build()
        
        contentStackView
            .snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20))
            }

    }
    
    // MARK: Methods
    
    override func binding() {
        super.binding()
        
        let output = viewModel.transform(input: .init(viewWillAppear: rxViewWillAppear.asDriverOnErrorJustComplete()))
        
        output.reloadCollectionViewIfNeeded
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            }) => disposeBag
        
        output.error
            .drive(onNext: { error in
                NativeAlertPresenter.default.showAlert(for: .message(message: error.localizedDescription))
            }) => disposeBag
        
        output.isSpeaking
            .map { $0 ? UIImage(systemName: "speaker.wave.3") : UIImage(systemName: "speaker") }
            .drive(onNext: { [weak self] image in
                self?.listeningButton.configuration?.image = image
            }) => disposeBag
    }
    
    @objc private func startListening() {
        guard let lesson = viewModel.getLesson(at: currentIndex) else { return }
        viewModel.startListening(with: lesson)
    }
    
    @objc private func startReading() {
        guard let lesson = viewModel.getLesson(at: currentIndex) else { return }
        Log.log(message: lesson.title)
    }
}

// MARK: - Constants

extension HomeViewController {
    struct Constants {
        static let lessonCellIdentifier = "HomeViewController"
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfLessons
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.lessonCellIdentifier, 
                                                          for: indexPath) as? LessonTileCollectionCell,
            let lesson = viewModel.getLesson(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: lesson)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}

// MARK: - UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        currentIndex = Int(scrollView.contentOffset.x / pageWidth)
        
        viewModel.stopSpeaking()
    }
    
}
