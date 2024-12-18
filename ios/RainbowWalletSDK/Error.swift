//
//  Error.swift
//  WalletSegue
//
//  Created by Jungho Bang on 6/16/22.
//

import Foundation

extension RainbowWalletSDK {
    public enum Error: Swift.Error {
        case encodingFailed
        case decodingFailed
        case missingSymmetricKey
        case invalidHandshakeRequest
        case openUrlFailed
        case walletReturnedError(String)
    }
}
