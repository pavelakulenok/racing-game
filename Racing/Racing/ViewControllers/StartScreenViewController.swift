//
//  ViewController.swift
//  Racing
//
//  Created by Pavel Akulenak on 22.03.21.
//

import UIKit

class StartScreenViewController: UIViewController {
    @IBOutlet weak var startScreenBackgroundImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var scoresButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        startScreenBackgroundImageView.image = UIImage(named: "startScreenBackground")
        startButton.applyCornerRadius(20)
        settingsButton.applyCornerRadius(10)
        scoresButton.applyCornerRadius(10)
    }

    @IBAction private func onStart(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: "isNotFirstLaunch") == false {
            let viewController = SettingsViewController.instantiate()
            present(viewController, animated: true, completion: nil)
            UserDefaults.standard.setValue(true, forKeyPath: "isNotFirstLaunch")
        } else {
            let viewController = GameViewController.instantiate()
            present(viewController, animated: true, completion: nil)
        }
    }

    @IBAction private func onSettingsButton(_ sender: Any) {
        let viewController = SettingsViewController.instantiate()
        present(viewController, animated: true, completion: nil)
    }

    @IBAction private func onScoresButton(_ sender: Any) {
        let viewContoller = ResultsViewController.instantiate()
        present(viewContoller, animated: true, completion: nil)
    }
}
