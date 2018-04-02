//
//  JSONParseOperation.swift
//  Operations
//
//  Created by Dorel Macra on 29/08/2017.
//
//

import Foundation

class JSONParseOperation: Operation {
    var json: Any?
    private var data: Data?

    override var isReady: Bool {
        return super.isReady && data != nil
    }

    func setData(_ data: Data) {
        willChangeValue(forKey: "isReady")
        self.data = data
        didChangeValue(forKey: "isReady")
    }

    override func main() {
        guard let data = self.data else { return }
        do {
            json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
        } catch {
            print(error.localizedDescription)
        }
    }
}
