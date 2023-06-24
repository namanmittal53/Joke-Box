//
//  ViewController.swift
//  Joke Box
//
//  Created by Naman on 23/06/23.
//

import UIKit
import Foundation

class JokesVC: UIViewController {
    
    // MARK: - UI Elements
    //================================
    let jokesTableView = UITableView()
    let titleLabel = UILabel()
    let timerLabel = UILabel()

    // MARK: - Variables
    //================================
    private let jokesPresenter = JokesViewPresenter()
    private var timer: DispatchSourceTimer?
    private var timerSeconds = 0
    private var showJokeInEveryXSecond = 60
    
    // MARK: - Lifecycle of VC
    //================================
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopTimer()
    }
    
}

// MARK: - Private Functions of VC
//================================
private extension JokesVC {
    
    // To set the UI and do all the work you want on viewDidLoad
    func initialSetup() {
        self.setupColors()
        self.setupUI()
        self.setupTableView()
        self.setUIConstraints()
        self.startTimer()
        self.fetchData(isFirstApiCall: true)
        self.jokesPresenter.delegate = self
    }
    
    // set the colors
    func setupColors() {
        self.view.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        self.jokesTableView.backgroundColor = .clear
    }
    
    // set the UI of all the UI elements
    func setupUI() {
        // Set up the title label
        self.titleLabel.text = "Your Joke Box"
        self.titleLabel.textAlignment = .left
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        // Set up the timer label
        self.timerLabel.text = ""
        self.timerLabel.textAlignment = .left
        self.timerLabel.font = UIFont.systemFont(ofSize: 12)
        self.timerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(timerLabel)

        self.jokesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(jokesTableView)
    }
    
    func setupTableView() {
        // Set up the table view
        jokesTableView.dataSource = self
        jokesTableView.delegate = self
        jokesTableView.separatorStyle = .none
        jokesTableView.estimatedRowHeight = 100
        
        // register table view cell
        jokesTableView.register(JokeTableViewCell.self, forCellReuseIdentifier: "JokeTableViewCell")
    }
    
    // set the constraints for UI Elements
    func setUIConstraints() {
        // Configure constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: timerLabel.leadingAnchor, constant: 20),
            
            timerLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            jokesTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            jokesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jokesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jokesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchData(isFirstApiCall: Bool) {
        jokesPresenter.fetchARandomJoke(isFirstApiCall: isFirstApiCall)
    }
    
    // Start the timer to fetch the data every minute
    func startTimer() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.schedule(deadline: .now(), repeating: .seconds(1))
        timer?.setEventHandler { [weak self] in
            guard let `self` = self else { return }
            self.handleTaskInTimer()
        }
        timer?.resume()
    }
    
    // Stop the timer
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    // Perform the task to be repeated every time here
    func handleTaskInTimer() {
        self.timerSeconds += 1
        DispatchQueue.main.async {
            self.timerLabel.text = "Your Next Joke in: \(self.showJokeInEveryXSecond - (self.timerSeconds % self.showJokeInEveryXSecond)) seconds"
        }
        if self.timerSeconds % showJokeInEveryXSecond == 0 {
            // Hit API in every 60 seconds
            self.fetchData(isFirstApiCall: false)
        }
    }
}

// MARK: - TableView Delegates & DataSources
//================================================
extension JokesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jokesPresenter.jokesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JokeTableViewCell", for: indexPath) as? JokeTableViewCell else { return UITableViewCell() }
        // Configure the cell
        cell.titleLabel.text = self.jokesPresenter.jokesArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - Delegates For Presenter
//================================================
extension JokesVC: JokesPresenterDelegate {
    
    // Reload the table view with the data
    func updateJokesList() {
        let lastIndex = self.jokesPresenter.jokesArr.endIndex - 1

        DispatchQueue.main.async {
            self.jokesTableView.reloadData()
            self.jokesTableView.scrollToRow(at: IndexPath(row: lastIndex, section: 0), at: .middle, animated: true)
        }
    }
    
}
