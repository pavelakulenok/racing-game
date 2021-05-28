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
    private var countLevelTimer = Timer()
    private var oncomingCarTimer = Timer()
    private var passingCarTimer = Timer()
    private var score = 0
    private var level = 0
    private var speed = 0.01
    private let oncomingCar = UIImageView()
    private let passingCar = UIImageView()
    private let oncomingCarImageArray = [UIImage(named: "oncomingYellowCar"), UIImage(named: "oncomingRedCar"), UIImage(named: "oncomingBlueCar")]
    private let passingCarImageArray = [UIImage(named: "passingYellowCar"), UIImage(named: "passingRedCar"), UIImage(named: "passingBlueCar")]
    private lazy var dateFormatter = DateFormatter()

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
    @IBOutlet weak var leftShoulder: UIView!
    @IBOutlet weak var rightShoulder: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = UserDefaults.standard.string(forKey: "vehicle") {
            carView.image = UIImage(named: imageName)
        }
        carSpeedTimer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(carMovement), userInfo: nil, repeats: true)
        oncomingCarTimer = Timer.scheduledTimer(timeInterval: speed / 2, target: self, selector: #selector(oncomingCarMovement), userInfo: nil, repeats: true)
        passingCarTimer = Timer.scheduledTimer(timeInterval: speed * 2, target: self, selector: #selector(passingCarMovement), userInfo: nil, repeats: true)
        countScoreTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countScore), userInfo: nil, repeats: true)
        countLevelTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(changeLevel), userInfo: nil, repeats: true)

        let oncomingCarRandomX = CGFloat.random(in: (roadView.frame.minX...roadView.frame.width / 2 - 70))
        oncomingCar.frame = CGRect(x: oncomingCarRandomX, y: -150, width: 70, height: 150)
        let oncomingCarImage = oncomingCarImageArray.randomElement()
        if let image = oncomingCarImage as? UIImage {
            oncomingCar.image = image
        }
        roadView.addSubview(oncomingCar)

        let passingCarRandomX = CGFloat.random(in: (roadView.frame.maxX - roadView.frame.width / 2...roadView.frame.maxX - 70))
        passingCar.frame = CGRect(x: passingCarRandomX, y: -150, width: 70, height: 150)
        let passingCarImage = passingCarImageArray.randomElement()
        if let image = passingCarImage as? UIImage {
            passingCar.image = image
        }
        roadView.addSubview(passingCar)
    }

    @IBAction private func carMove(_ sender: UIPanGestureRecognizer) {
        let move = sender.translation(in: view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + move.x, y: view.center.y)
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }

    @objc private func carMovement() {
        roadLinesMovement(item: firstRoadLine)
        roadLinesMovement(item: secondRoadLine)
        roadLinesMovement(item: thirdRoadLine)
        roadLinesMovement(item: fourthRoadLine)
        roadLinesMovement(item: fifthRoadLine)
        roadLinesMovement(item: sixthRoadLine)
        if carView.frame.intersects(oncomingCar.frame) || carView.frame.intersects(passingCar.frame) {
            accidentActions()
        } else if carView.frame.intersects(leftShoulder.frame) || carView.frame.intersects(rightShoulder.frame) {
            accidentActions()
        }
    }

    private func roadLinesMovement(item: UIView) {
        if item.frame.origin.y > roadView.frame.height {
            item.frame = CGRect(x: item.frame.origin.x, y: -50, width: item.frame.width, height: item.frame.height)
        } else {
            item.frame = CGRect(x: item.frame.origin.x, y: item.frame.origin.y + 1, width: item.frame.size.width, height: item.frame.size.height)
        }
    }

    @objc private func oncomingCarMovement() {
        if oncomingCar.frame.origin.y > roadView.frame.height {
            let randomX = CGFloat.random(in: (roadView.frame.minX...roadView.frame.width / 2 - 70))
            oncomingCar.frame = CGRect(x: randomX, y: -150, width: 70, height: 150)
            let oncomingCarImage = oncomingCarImageArray.randomElement()
            if let image = oncomingCarImage as? UIImage {
                oncomingCar.image = image
            }
        } else {
            oncomingCar.frame = CGRect(x: oncomingCar.frame.origin.x, y: oncomingCar.frame.origin.y + 1, width: oncomingCar.frame.size.width, height: oncomingCar.frame.size.height)
        }
    }

    @objc private func passingCarMovement() {
        if passingCar.frame.origin.y > roadView.frame.height {
            let passingCarRandomX = CGFloat.random(in: (roadView.frame.maxX - roadView.frame.width / 2...roadView.frame.maxX - 70))
            passingCar.frame = CGRect(x: passingCarRandomX, y: -150, width: 70, height: 150)
            let passingCarImage = passingCarImageArray.randomElement()
            if let image = passingCarImage as? UIImage {
                passingCar.image = image
            }
        } else {
            passingCar.frame = CGRect(x: passingCar.frame.origin.x, y: passingCar.frame.origin.y + 1, width: passingCar.frame.size.width, height: passingCar.frame.size.height)
        }
    }

    @objc private func countScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc private func changeLevel() {
        stopMovementTimers()
        level += 1
        levelLable.text = "Level: \(level)"
        speed /= 1.1
        carSpeedTimer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(carMovement), userInfo: nil, repeats: true)
        oncomingCarTimer = Timer.scheduledTimer(timeInterval: speed / 2, target: self, selector: #selector(oncomingCarMovement), userInfo: nil, repeats: true)
        passingCarTimer = Timer.scheduledTimer(timeInterval: speed * 1.5, target: self, selector: #selector(passingCarMovement), userInfo: nil, repeats: true)
    }

    private func stopMovementTimers() {
        carSpeedTimer.invalidate()
        oncomingCarTimer.invalidate()
        passingCarTimer.invalidate()
    }

    private func stopCountTimers() {
        countLevelTimer.invalidate()
        countScoreTimer.invalidate()
    }

    private func accidentActions() {
        stopMovementTimers()
        stopCountTimers()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        let resultFileName = "\(dateFormatter.string(from: Date()))"
        SaveResultsManager.saveResults(level: level, score: score, resultFileName: resultFileName)
        showAlertWithOneButton(title: "Crash!", message: "your score: \(score)", actionTitle: "ok", actionStyle: .default) { _ in
            let viewController = StartScreenViewController.instantiate()
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
