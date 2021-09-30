//
//  SimpleSoundPlayer.swift
//
//  Created by raku-pro on 2021/07/03.
//  Copyright 2021 raku-pro

import Foundation
import AVFoundation

/// SoundFountをロードして再生するプレイヤー
///
/// 音を出す際、消す際のnote番号はMIDI noteナンバーを指定する。
///  0: 下三点ハ
///  127: 六点ト
///
///  88鍵盤のピアノの場合
///   21: 下二点イ
///  108: 五点ハ
/// MIDI note ナンバー参考: https://ja.wikipedia.org/wiki/%E3%83%8E%E3%83%BC%E3%83%88%E3%83%8A%E3%83%B3%E3%83%90%E3%83%BC
public final class SimpleSoundPlayer {
    private let audioEngine = AVAudioEngine()
    private let sampler = AVAudioUnitSampler()
    private let soundBankURL: URL
    
    /// 現在再生中のnote numberを保持する
    public private(set) var currentNotes = Set<UInt8>()

    
    /// SoundFontのパスを表すURLでSoundPlayerを生成する
    /// - Parameter soundBankURL:
    public init(soundBankURL: URL) {
        self.soundBankURL = soundBankURL
        audioEngine.attach(sampler)
        audioEngine.connect(sampler, to: audioEngine.mainMixerNode, format: nil)
    }
    
    
    /// 指定したMIDI note numberが再生中かどうか
    /// - Parameter note:
    /// - Returns: 再生中ならtrueを返す
    public func isPlayingNote(_ note: UInt8) -> Bool {
        return currentNotes.contains(note)
    }
    
    
    /// このplayerの再生のための準備をする。
    ///
    /// 関連: https://developer.apple.com/documentation/avfaudio/avaudiounitsampler/1385687-loadsoundbankinstrument
    /// - Parameters:
    ///   - program: SondFontに従って設定する値(通常デフォルトのまま)
    ///   - bankMSB: SondFontに従って設定する値(通常デフォルトのまま)
    ///   - bankLSB: SondFontに従って設定する値(通常デフォルトのまま)
    public func prepare(program: UInt8 = 0, bankMSB: Int = kAUSampler_DefaultMelodicBankMSB, bankLSB: Int = kAUSampler_DefaultBankLSB) throws {
        try sampler.loadSoundBankInstrument(at: soundBankURL,
                                        program: program,
                                        bankMSB: UInt8(bankMSB),
                                        bankLSB: UInt8(bankLSB))
        try audioEngine.start()
    }
    
    deinit {
        audioEngine.stop()
    }
    
    
    /// 指定した音を再生する
    /// - Parameters:
    ///   - note: MIDI note number(0~127の範囲)
    ///   - velocity: 音の大きさ(0~127の範囲)
    public func startNote(_ note: UInt8, velocity: UInt8) {
        guard audioEngine.isRunning else {
            return
        }
        self.currentNotes.insert(note)
        sampler.startNote(note, withVelocity: velocity, onChannel: 0)
    }
    
    
    /// 指定した音の再生を止める
    /// - Parameter note: MIDI note number(0~127の範囲)
    public func stopNote(_ note: UInt8) {
        guard audioEngine.isRunning else {
            return
        }
        self.currentNotes.remove(note)
        sampler.stopNote(note, onChannel: 0)
    }
    
}
