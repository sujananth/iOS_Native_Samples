
// Note:
// This code is to explain the cause of dismissing the keyboard.
// Step 0: Once launchd the app, Tap "Observer with Dismisser" button.
// Step 1: Add a keyboardDidAppear notification by tapping on "Add keyboardDidAppear observer with selector name" button.
// Step 2: Add a keyboardWillAppear notification by tapping on "Add keyboardWillAppear observer with block" button.
// Step 3: Dismiss the view controller.
// Step 4: Now once again repeat the step 0, step 1, step 2.
// Step 5: Select the text field. Once keyboard appeared. Please check the logs. "Shared keyboardWillAppear is called" is printed once.
//Note: only the last added token will be removed with this kind of implementation.So its eqaully important to check adding observer, just like remove observer.

import UIKit

class NotificationDismisserViewController: UIViewController {
    
    @IBOutlet weak var didAppearCountLabel: UILabel!
    @IBOutlet weak var willAppearCountLabel: UILabel!
    @IBOutlet weak var testTextField: UITextField!
    var keyboardWillApperNotificationToken: Any?
    
    @IBAction func didTapAddObserverWithSelector(_ sender: Any) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidAppeared),name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @IBAction func didTapAddObserverWithBlock(_ sender: Any) {
        // Saving the opaque token returned after adding observer.
        keyboardWillApperNotificationToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] _ in
            self?.keyboardWillAppear()
            NotificationKeyboard.shared.keyboardWillAppear()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.testTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppearCountLabel.text = ""
        didAppearCountLabel.text = ""
    }
    
    @objc func keyboardDidAppeared() {
        var count = Int(didAppearCountLabel.text ?? "0") ?? 0
        count += 1
        didAppearCountLabel.text = String(count)
    }
    
    func keyboardWillAppear() {
        var count = Int(willAppearCountLabel.text ?? "0") ?? 0
        count += 1
        willAppearCountLabel.text = String(count)
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tapRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tapRecognizer.cancelsTouchesInView = false
        return tapRecognizer
    }
    
    deinit {
        if let notificationToken = keyboardWillApperNotificationToken {
            //Using the opaque token to dimsmiss the observer.
            NotificationCenter.default.removeObserver(notificationToken)
        }
    }
}

extension NotificationDismisserViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        willAppearCountLabel.text = ""
        didAppearCountLabel.text = ""
    }
}
