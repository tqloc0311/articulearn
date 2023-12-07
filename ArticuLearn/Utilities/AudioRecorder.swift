//
//  AudioRecorder.swift
//  ArticuLearn
//
//  Created by azibai loc on 06/12/2023.
//

import AVFoundation

class AudioRecorder {
    private let audioEngine: AVAudioEngine
    private var audioFile: AVAudioFile?
    private lazy var audioInputNode: AVAudioInputNode = {
        return audioEngine.inputNode
    }()
    
    init() throws {
        audioEngine = AVAudioEngine()
        try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
    }

    func startRecording(with fileURL: URL) throws {
        audioFile = try AVAudioFile(forWriting: fileURL,
                                    settings: audioInputNode.outputFormat(forBus: 0).settings)
        try audioEngine.start()
        audioInputNode.installTap(onBus: 0,
                                  bufferSize: 1024,
                                  format: audioInputNode.outputFormat(forBus: 0)) { [weak self] buffer, time in
            try? self?.audioFile?.write(from: buffer)
        }
    }

    func stopRecording() {
        audioInputNode.removeTap(onBus: 0)
        audioEngine.stop()
        audioFile = nil
    }
}
