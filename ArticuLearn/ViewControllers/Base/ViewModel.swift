//
//  ViewModel.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation
import RxSwift

open class ViewModel {
    
    let disposeBag = DisposeBag()
    
    deinit {
        let className = String(describing: type(of: self))
        Log.log(type: .info, message: "\(className) deinit")
    }
    
}
