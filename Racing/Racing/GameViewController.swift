//
//  GameViewController.swift
//  Racing
//
//  Created by Pavel Akulenak on 19.04.21.
//

import UIKit

class GameViewController: UIViewController {
    private var carSpeedTimer = Timer()
    private var countScoreTimer = Timer()
    private var levelTimer = Timer()
    private var score = 0
    private var level = 0
    private var speed = 0.005

    @IBOutlet weak var firstRoadLine: UIView!
    @IBOutlet weak var secondRoadLine: UIView!
    @IBOutlet weak var thirdRoadLine: UIView!
    @IBOutlet weak var fourthRoadLine: UIView!
    @IBOutlet weak var fifthRoadLine: UIView!
    @IBOutlet weak var sixthRoadLine: UIView!
    @IBOutlet weak var roadView: UIView!
    @IBOutlet weak var carView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        carSpeedTimer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(gameLogic), userInfo: nil, repeats: true)
        countScoreTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countScore), userInfo: nil, repeats: true)
        levelTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(createGameTimer), userInfo: nil, repeats: true)
        scoreLabel.text = "Score: \(score)"
        levelLable.text = "Level: \(level)"
    }

    @IBAction private func carMove(_ sender: UIPanGestureRecognizer) {
        let move = sender.translation(in: view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + move.x, y: view.center.y)
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }

    @objc private func gameLogic() {
        roadLinesMovement(item: firstRoadLine)
        roadLinesMovement(item: secondRoadLine)
        roadLinesMovement(item: thirdRoadLine)
        roadLinesMovement(item: fourthRoadLine)
        roadLinesMovement(item: fifthRoadLine)
        roadLinesMovement(item: sixthRoadLine)
    }

    private func roadLinesMovement(item: UIView) {
        if item.frame.origin.y > roadView.frame.height {
            item.frame = CGRect(x: item.frame.origin.x, y: -50, width: item.frame.width, height: item.frame.height)
        } else {
            item.frame = CGRect(x: item.frame.origin.x, y: item.frame.origin.y + 1, width: item.frame.size.width, height: item.frame.size.height)
        }
    }

    @objc private func countScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc private func createGameTimer () -> Timer {
        speed /= 1.05
        level += 1
        levelLable.text = "Level: \(level)"
        let carSpeedTimer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(gameLogic), userInfo: nil, repeats: true)
        return carSpeedTimer
    }
}
