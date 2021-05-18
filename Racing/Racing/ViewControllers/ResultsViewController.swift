//
//  ResultsViewController.swift
//  Racing
//
//  Created by Pavel Akulenak on 17.05.21.
//

import UIKit

class ResultsViewController: UIViewController {
    private var arrayOfResults = [Results]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.applyCornerRadius(20)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        arrayOfResults = ReadResultsManager.readFromResults().sorted { $0.score > $1.score }
    }

    @IBAction private func onMenuButton(_ sender: Any) {
        let viewController = StartScreenViewController.instantiate()
        present(viewController, animated: true, completion: nil)
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("ResultTableViewCell", owner: self, options: nil)?.first as? ResultTableViewCell
        headerView?.userNameLabel.text = "Name"
        headerView?.userNameLabel.applyPermanentMarkerFont(25)
        headerView?.scoreLabel.text = "Score"
        headerView?.scoreLabel.applyPermanentMarkerFont(25)
        headerView?.levelLabel.text = "Level"
        headerView?.levelLabel.applyPermanentMarkerFont(25)
        headerView?.layer.borderWidth = 3.0
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        cell.userNameLabel.text = "\(arrayOfResults[indexPath.row].name)"
        cell.userNameLabel.applyPermanentMarkerFont(20)
        cell.scoreLabel.text = "\(arrayOfResults[indexPath.row].score)"
        cell.scoreLabel.applyPermanentMarkerFont(20)
        cell.levelLabel.text = "\(arrayOfResults[indexPath.row].level)"
        cell.levelLabel.applyPermanentMarkerFont(20)
        cell.layer.borderWidth = 0.3

        return cell
    }
}

extension UILabel {
    func applyPermanentMarkerFont(_ size: CGFloat) {
        font = UIFont(name: "PermanentMarker-Regular", size: size)
    }
}
