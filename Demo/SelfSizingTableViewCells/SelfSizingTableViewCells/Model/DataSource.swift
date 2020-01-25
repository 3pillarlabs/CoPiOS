//
//  DataSource.swift
//  SelfSizingTableViewCells
//
//  Created by David Livadaru on 24/01/2020.
//  Copyright © 2020 3Pillar Global. All rights reserved.
//

import Foundation

struct DataSource {
    let objects: [Forest] = loadObjects()

    private static func loadObjects() -> [Forest] {
        guard let url = Bundle.main.url(forResource: "forest", withExtension: "json") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        do {
            let objects = try JSONDecoder().decode([Forest].self, from: data)
            return objects
        } catch {
            return []
        }
    }
}
