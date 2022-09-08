//
//  CacheManagers.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import Foundation

import AlamofireImage

// не поддается наследованию и все его методы косвенным образом приобретают свойство final
final class CacheManager {
    // MARK: Lifecycle

    private init() {}

    // MARK: Internal

    static let shared = CacheManager()

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
