//
//  SettingsViewController.swift
//  Racing
//
//  Created by Pavel Akulenak on 1.05.21.
//

import UIKit

class SettingsViewController: UIViewController {
    var vehicle: String?

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var startRaceButton: UIButton!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var motorcycleButton: UIButton!
    @IBOutlet weak var bolideButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        startRaceButton.applyCornerRadius(20)
        if let name = UserDefaults.standard.string(forKey: "nickname") {
            nicknameTextField.text = name
        }
    }

    @IBAction private func onCarButton(_ sender: Any) {
        vehicle = "redCar"
        carButton.addShadow(color: .green, opacity: 1.0, offSet: .zero, radius: 30)
        motorcycleButton.layer.shadowOpacity = 0
        bolideButton.layer.shadowOpacity = 0
    }

    @IBAction private func onMotorcycleButton(_ sender: Any) {
        vehicle = "motorcycle"
        motorcycleButton.addShadow(color: .green, opacity: 1.0, offSet: .zero, radius: 30)
        carButton.layer.shadowOpacity = 0
        bolideButton.layer.shadowOpacity = 0
    }

    @IBAction private func onBolideButton(_ sender: Any) {
        vehicle = "bolide"
        bolideButton.addShadow(color: .green, opacity: 1.0, offSet: .zero, radius: 30)
        carButton.layer.shadowOpacity = 0
        motorcycleButton.layer.shadowOpacity = 0
    }

    @IBAction private func onStartRaceButton(_ sender: Any) {
        saveSettingsAndStartRace()
    }

    private func saveSettingsAndStartRace() {
        guard let string = nicknameTextField.text else {
            return
        }
        if vehicle == nil || string.isEmpty {
            showAlertWithOneButton(title: "Can't start race", message: "Chouse your vehicle and enter nickmane", actionTitle: "ok", actionStyle: .default, handler: nil)
        } else {
            UserDefaults.standard.setValue(nicknameTextField.text, forKey: "nickname")
            UserDefaults.standard.setValue(vehicle, forKey: "vehicle")
            let viewController = GameViewController.instantiate()
            present(viewController, animated: true, completion: nil)
        }
    }
}
