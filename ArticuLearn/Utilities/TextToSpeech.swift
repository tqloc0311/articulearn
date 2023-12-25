//
//  TextToSpeech.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import AVFoundation

protocol TextToSpeechDelegate: AnyObject {
    func textToSpeechDidChangeState(isSpeaking: Bool)
}

class TextToSpeech: NSObject {

    enum SpeechState {
        case speaking, paused, notSpeaking
    }

    // MARK: Public Properties
    
    var state: SpeechState {
        return isSpeaking ? .speaking : (isPaused ? .paused : .notSpeaking)
    }

    weak var delegate: TextToSpeechDelegate?

    // MARK: Private Properties
    
    private let synthesizer = AVSpeechSynthesizer()
    private var isSpeaking: Bool {
        return synthesizer.isSpeaking
    }
    private var isPaused: Bool {
        return synthesizer.isPaused
    }
    
    private var voices: [AVSpeechSynthesisVoice] {
        return [
            AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-US.Samantha"),
            AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-ZA.Tessa"),
            AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Junior"),
            AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Princess"),
            AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-IN.Rishi"),
            AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-IE.Moira"),
            AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-GB.Daniel"),
            AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.en-AU.Karen"),
        ].compactMap { $0 }
    }

    // MARK: Constructors
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }

    // MARK: Public Methods
    
    func speak(_ text: String) {
        stopSpeaking()

        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voices.randomElement()

        synthesizer.speak(utterance)
        notifyDelegate()
    }

    func pause() {
        synthesizer.pauseSpeaking(at: .immediate)
        notifyDelegate()
    }

    func resume() {
        synthesizer.continueSpeaking()
        notifyDelegate()
    }

    func stop() {
        stopSpeaking()
        notifyDelegate()
    }

    // MARK: Private Methods
    
    private func stopSpeaking() {
        if isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }

    private func notifyDelegate() {
        delegate?.textToSpeechDidChangeState(isSpeaking: isSpeaking)
    }
}

// MARK: - AVSpeechSynthesizerDelegate

extension TextToSpeech: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        notifyDelegate()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        notifyDelegate()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        notifyDelegate()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        notifyDelegate()
    }
}
