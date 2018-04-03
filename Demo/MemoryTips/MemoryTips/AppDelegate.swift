//
//  AppDelegate.swift
//  MemoryTips
//
//  Created by David Livadaru on 14/09/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

struct WeakReference<Element>: Equatable {
    private weak var storage: AnyObject? {
        didSet {
            if storage == nil {
                print("is it working?")
            }
        }
    }

    var element: Element? {
        return storage as? Element
    }

    init(element: Element) {
        self.storage = element as AnyObject
    }

    static func ==(lhs: WeakReference, rhs: WeakReference) -> Bool {
        return lhs.storage === rhs.storage
    }
}

class WeakReferenceContainer<Element> {
    private var elements: [WeakReference<Element>] = []

    func add(element: Element) {
        guard index(of: element) == nil else { return }

        let wrappedElement = WeakReference(element: element)
        elements.append(wrappedElement)
    }

    func remove(element: Element) {
        if let index = index(of: element) {
            elements.remove(at: index)
        }
    }

    func enumerate(_ closure: (Element?) -> Void) {
        elements = elements.filter({ $0.element != nil })

        for wrapper in elements {
            closure(wrapper.element)
        }
    }

    private func index(of element: Element) -> Int? {
        return elements.index(of: WeakReference(element: element))
    }
}



protocol Observer: class {
    func f()
}

class Observable {
    var observers: [WeakReference<Observer>] = []
}

class C: Observer {
    let obserble = Observable()
    init() {
        obserble.observers.append(WeakReference<Observer>(element: self))
        print("init")
    }

    deinit {
        print("deinit")
    }

    func doSomething() {

    }

    func f() {
        print("f")
    }
}






/// Manages the creation of a property lazily.
/// The difference from a `lazy` property is that it provides a way to encapsure logic and call it when needed.
/// Moreover, in the given closure, class client may call functions.
class LazyProperty<Type> {
    typealias BuildClosure = () -> Type
    var value: Type {
        if _value == nil {
            _value = closure()
        }
        return _value!
    }

    private var _value: Type?
    private var closure: BuildClosure

    init(closure: @escaping BuildClosure) {
        self.closure = closure
    }
}





class TypeOne {
    lazy var property: String = {
//        f()
        return "asdf"
    }()

    var property2: LazyProperty<String>!


    init() {
        property2 = LazyProperty<String>(closure: { [weak self] in
            self?.f()
            return "asd"
        })
    }

    private func f() {
    }
}







@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let c = C()
        c.f()

        print("asd")

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

