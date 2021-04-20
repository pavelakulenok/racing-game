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
        enterGameButton.layer.cornerRadius = 20
    }

    @IBAction private func onEnterGameButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "GameViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GameViewController")
        present(viewController, animated: true, completion: nil)
    }
}
