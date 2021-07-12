//
//  File.swift
//  
//
//  Created by manjil on 12/07/2021.
//

import UIKit
import Combine

/// Create a compatible control protocol
public protocol CombineCompatible { }

/// UIControl conforms to that protocol
extension UIControl: CombineCompatible { }

/// Define the publisher
public extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        return UIControlPublisher(control: self, events: events)
    }
}

// MARK: - Publisher
public struct UIControlPublisher<Control: UIControl>: Publisher {

    public typealias Output = Control
    public typealias Failure = Never

    private let control: Control
    private let controlEvents: UIControl.Event

    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}

// MARK: - Subscription
public final class UIControlSubscription<SubscriberType: Subscriber,
                                  Control: UIControl>: Subscription
                                  where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    public func request(_ demand: Subscribers.Demand) {}

    public func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}


