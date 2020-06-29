// Note:
// This code is to explain the cause of not removing keyboard notification.
// Step 0: Once launchd the app, Tap "Observer Without Dismisser" button.
// Step 1: Add a keyboardDidAppear notification by tapping on "Add keyboardDidAppear observer with selector name" button
// Step 2: Add a keyboardWillAppear notification by tapping on "Add keyboardWillAppear observer wigh block" button.
// Step 3: Dismiss the view controller.
// Step 4: Now once again repeat the step 0, step 1, step 2.
// Step 5: Select the text field. Once keyboard appeared. Please check the logs. "Shared keyboardWillAppear is called" is printed twice. The previous instances didnt get clear.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var willAppearCountLabel: UILabel!
    @IBOutlet weak var didAppearCountLabel: UILabel!
    @IBOutlet weak var testTextField: UITextField!
    let customNotificationCenter = NotificationCenter()
    
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

    @IBAction func didTapAddObserverWithSelector(_ sender: Any) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidAppeared),name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @IBAction func didTapAddObserverWithBlock(_ sender: Any) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] _ in
            self?.keyboardWillAppear()
            NotificationKeyboard.shared.keyboardWillAppear()
            NotificationKeyboard.payMoney()
            NotificationKeyboard.updateMedicine()
        }
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
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        willAppearCountLabel.text = ""
        didAppearCountLabel.text = ""
    }
}

class NotificationKeyboard {
    static let shared = NotificationKeyboard()
    
    func keyboardWillAppear() {
        print("Shared keyboardWillAppear is called")
    }
    
    func keyboardDidAppear() {
        print("Shared keyboardDidAppear is called")
    }
    
    func keyboardWillHide() {
        print("Shared keyboardWillHide is called")
    }
    
    func keyboardDidHide() {
        print("Shared keyboardDidHide is called")
    }
    
    static func payMoney() {
        print("your might be paying money for wrong instance")
    }
    
    class func updateMedicine() {
        print("Might be updating drug for wrong patient.")
    }
}


