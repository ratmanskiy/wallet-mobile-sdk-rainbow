//
//  EncryptedRequestContent.swift
//  WalletSegue
//
//  Created by Jungho Bang on 6/23/22.
//

import Foundation
import CryptoKit

public enum EncryptedRequestContent: EncryptedContent {
    case handshake(appId: String, callback: URL, initialActions: [Action]?)
    case request(data: Data)
    
    public func decrypt(with symmetricKey: SymmetricKey?) throws -> RequestContent {
        switch self {
        case let .handshake(appId, callback, initialActions):
            return .handshake(appId: appId, callback: callback, initialActions: initialActions)
        case let .request(data):
            guard let symmetricKey = symmetricKey else {
                throw RainbowWalletSDK.Error.missingSymmetricKey
            }
            let request: Request = try Cipher.decrypt(data, with: symmetricKey)
            return .request(actions: request.actions, account: request.account)
        }
    }
}

extension RequestContent {
    public func encrypt(with symmetricKey: SymmetricKey?) throws -> EncryptedRequestContent {
        switch self {
        case let .handshake(appId, callback, initialActions):
            return .handshake(appId: appId, callback: callback, initialActions: initialActions)
        case let .request(actions, account):
            guard let symmetricKey = symmetricKey else {
                throw RainbowWalletSDK.Error.missingSymmetricKey
            }
            let request = Request(actions: actions, account: account)
            return .request(data: try Cipher.encrypt(request, with: symmetricKey))
        }
    }
}

