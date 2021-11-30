import UIKit

private var actionsKey = "ACTIONS_KEY"

private class Action<Sender: UIControl> {
  var events: UIControl.Event
  let action: (Sender) -> Void
  
  init(events: UIControl.Event, action: @escaping (Sender) -> Void) {
    self.events = events
    self.action = action
  }
  
  @objc func invoke(_ sender: UIControl) {
    action(sender as! Sender)
  }
}

public protocol ClosureAction where Self: UIControl {}

public extension ClosureAction {
  private var actions: [Action<Self>] {
    get { return objc_getAssociatedObject(self, &actionsKey) as? [Action<Self>] ?? [] }
    set { objc_setAssociatedObject(self, &actionsKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }
  
  func addAction(for events: Event, action: @escaping (Self) -> ()) {
    let action = Action<Self>(events: events, action: action)
    addTarget(action, action: #selector(Action<Self>.invoke(_:)), for: events)
    actions.append(action)
  }
  
  func addAction(for events: Event, action: @escaping () -> ()) {
    let action = Action<Self>(events: events) { _ in action() }
    addTarget(action, action: #selector(Action<Self>.invoke(_:)), for: events)
    actions.append(action)
  }
  
  func removeActions(for events: Event) {
    removeTarget(nil, action: nil, for: events)
    actions.forEach { $0.events.remove(events) }
    actions.removeAll { $0.events.rawValue == 0 }
  }
}

extension UIControl: ClosureAction {}
