//
//  ModelContainer.swift
//  BasicMVC
//
//  Created by David Livadaru on 05/03/2018.
//  Copyright © 2018 David Livadaru. All rights reserved.
//

import Foundation

protocol ModelContainerObserver: class {
    func modelContainer(_ modelContainer: ModelContainer, willChangeCountFrom old: Int, to new: Int, index: Int,
                        action: ModelAction)
}

enum ModelAction {
    case insert, delete
}

class ModelContainer {
    weak var observer: ModelContainerObserver?
    private (set) var objects = [Any]()

    func insert(_ object: Any, at index: Int) {
        let newCount = objects.count + 1
        observer?.modelContainer(self, willChangeCountFrom: objects.count, to: newCount, index: index,
                                 action: .insert)
        objects.insert(object, at: index)
    }

    func addObject(_ object: Any) {
        let newCount = objects.count + 1
        observer?.modelContainer(self, willChangeCountFrom: objects.count, to: newCount, index: objects.count,
                                 action: .insert)
        objects.append(object)
    }

    func remove(at index: Int) {
        let newCount = objects.count - 1
        observer?.modelContainer(self, willChangeCountFrom: objects.count, to: newCount, index: index, action: .delete)
        objects.remove(at: index)
    }
}
