//
//  PermissionManager.swift
//  ArticuLearn
//
//  Created by azibai loc on 06/12/2023.
//

import AVFoundation
import UIKit
import Speech

class PermissionManager {
    
    static let `default` = PermissionManager()
    
    func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func requestSpeechRecognitionPermission(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
}

