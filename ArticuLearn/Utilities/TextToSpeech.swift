//
//  TextToSpeech.swift
//  ArticuLearn
//
//  Created by azibai loc on 25/12/2023.
//

import AVFoundation

protocol TextToSpeechDelegate: AnyObject {
    func textToSpeechIsSpeaking(isSpeaking: Bool)
}

class TextToSpeech: NSObject {
    
    // MARK: Public Methods
    
    var isSpeaking: Bool {
        return synthesizer.isSpeaking
    }
    
    weak var delegate: TextToSpeechDelegate?
    
    // MARK: Private Methods
    
    private let synthesizer = AVSpeechSynthesizer()
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

    // MARK: Public methods
    
    func speak(_ text: String) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voices.randomElement()
        
        synthesizer.speak(utterance)
        delegate?.textToSpeechIsSpeaking(isSpeaking: true)
    }

    func pause() {
        synthesizer.pauseSpeaking(at: .immediate)
    }

    func resume() {
        synthesizer.continueSpeaking()
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }

}

// MARK: - AVSpeechSynthesizerDelegate

extension TextToSpeech: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        delegate?.textToSpeechIsSpeaking(isSpeaking: false)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        delegate?.textToSpeechIsSpeaking(isSpeaking: false)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        delegate?.textToSpeechIsSpeaking(isSpeaking: true)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        delegate?.textToSpeechIsSpeaking(isSpeaking: false)
    }
}
