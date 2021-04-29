//
//  ViewController.swift
//  Racing
//
//  Created by Pavel Akulenak on 22.03.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startScreenBackgroundImageView: UIImageView!
    @IBOutlet weak var enterGameButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        startScreenBackgroundImageView.image = UIImage(named: "startScreenBackground")
        enterGameButton.applyCornerRadius(20)
    }

    @IBAction private func onEnterGameButton(_ sender: UIButton) {
        let viewController = GameViewController.instantiate()
        present(viewController, animated: true, completion: nil)
    }
}
