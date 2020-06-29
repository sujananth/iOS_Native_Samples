

import UIKit

// Note:
// This code is to explain, dismissg the notification observer automatically.
// Create a custom class for notification token, which holds the actual token from adding observer and reference of NotificationCenter.
// Add an additional methods to notification center through extension, which returns custom notification token.
// Create a property in your class to store this custom notification token in your class. Each time when the class object where you have stored this customNotification  token gets deinited, the deinit of the customNotification will get triggered and removes the observer.
// Added advantage for this design is old notificationtoken will be removed while adding new observer.

class AutomatedDismisserViewController: UIViewController {

    @IBOutlet weak var willAppearCountLAbel: UILabel!
    @IBOutlet weak var testTextField: UITextField!
    var keyboardWillApperNotificationToken: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.testTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppearCountLAbel.text = ""
    }
    
    @IBAction func didTapAddObserverWithBlock(_ sender: Any) {
        // Saving the opaque token returned after adding observer.
        keyboardWillApperNotificationToken = NotificationCenter.default.observe(name: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { [weak self] _ in
            self?.keyboardWillAppear()
            NotificationKeyboard.shared.keyboardWillAppear()
        })
    }
    
    func keyboardWillAppear() {
        var count = Int(willAppearCountLAbel.text ?? "0") ?? 0
        count += 1
        willAppearCountLAbel.text = String(count)
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tapRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tapRecognizer.cancelsTouchesInView = false
        return tapRecognizer
    }
}


extension AutomatedDismisserViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        willAppearCountLAbel.text = ""
    }
}


//A wrapper class to handle automatic dismissal of NotificationCenter.
final class CustomNotificationToken: NSObject {
    let notificationCenter: NotificationCenter
    let token: Any

    init(notificationCenter: NotificationCenter = .default, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit {
        notificationCenter.removeObserver(token)
    }
}

//Extensing NotificationCenter to add custom observe method.
extension NotificationCenter {
    
    func observe(name: NSNotification.Name?, object obj: Any?,
        queue: OperationQueue?, using block: @escaping (Notification) -> ())
        -> CustomNotificationToken
    {
        let token = addObserver(forName: name, object: obj, queue: queue, using: block)
        return CustomNotificationToken(notificationCenter: self, token: token)
    }
}
