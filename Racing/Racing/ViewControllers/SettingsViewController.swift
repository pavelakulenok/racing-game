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
        if let selectedVehicle = UserDefaults.standard.string(forKey: "vehicle") {
            if selectedVehicle == "redCar" {
                addShadow(button: carButton)
            } else if selectedVehicle == "motorcycle" {
                addShadow(button: motorcycleButton)
            } else if selectedVehicle == "bolide" {
                addShadow(button: bolideButton)
            }
        }
    }

    @IBAction private func onCarButton(_ sender: Any) {
        vehicle = "redCar"
        addShadow(button: carButton)
        removeShadow(button: motorcycleButton)
        removeShadow(button: bolideButton)
    }

    @IBAction private func onMotorcycleButton(_ sender: Any) {
        vehicle = "motorcycle"
        addShadow(button: motorcycleButton)
        removeShadow(button: carButton)
        removeShadow(button: bolideButton)
    }

    @IBAction private func onBolideButton(_ sender: Any) {
        vehicle = "bolide"
        addShadow(button: bolideButton)
        removeShadow(button: carButton)
        removeShadow(button: motorcycleButton)
    }

    @IBAction private func onStartRaceButton(_ sender: Any) {
        saveSettingsAndStartRace()
    }

    private func saveSettingsAndStartRace() {
        guard let string = nicknameTextField.text else {
            return
        }
        if vehicle == nil || string.isEmpty {
            showAlertWithOneButton(title: "SettingsAlertTitle".localize(), message: "SettingsAlertMessage".localize(), actionTitle: "SettingsAlertActionTitle".localize(), actionStyle: .default, handler: nil)
        } else {
            UserDefaults.standard.setValue(nicknameTextField.text, forKey: "nickname")
            UserDefaults.standard.setValue(vehicle, forKey: "vehicle")
            let viewController = GameViewController.instantiate()
            present(viewController, animated: true, completion: nil)
        }
    }

    private func addShadow(button: UIButton) {
        button.addShadow(color: .green, opacity: 1.0, offSet: .zero, radius: 30)
    }

    private func removeShadow(button: UIButton) {
        button.layer.shadowOpacity = 0
    }
}
