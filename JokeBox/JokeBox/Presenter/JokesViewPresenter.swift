//
//  JokesViewPresenter.swift
//  JokeBox
//
//  Created by Naman on 24/06/23.
//

import Foundation

// MARK: -  Presenter Protocol
protocol JokesPresenterDelegate: AnyObject {
    func updateJokesList()
}

class JokesViewPresenter {
    
    // MARK: - Variables
    //==========================
    weak var delegate: JokesPresenterDelegate?
    var jokesArr = [String]()

    // MARK: - Functions
    //==========================
    // This function will fetch the jokes
    func fetchARandomJoke(isFirstApiCall: Bool) {
        
        if let arr = UserDefaults.standard.value(forKey: "Jokes") as? [String] {
            self.jokesArr = arr
            self.delegate?.updateJokesList()
            if isFirstApiCall {
               return
            }
        }
        
        // Then hit the api for new data
        let service = WebServices()
        service.fetchData(urlString: "https://geek-jokes.sameerkumar.website/api", completion: { [weak self] (joke) in
            guard let `self` = self else { return }
            if self.jokesArr.count < 10 {
                self.jokesArr.append(joke)
            } else {
                self.jokesArr.removeAll()
                self.jokesArr.append(joke)
            }
            // Save in user defaults for showing the data next time
            UserDefaults.standard.set(self.jokesArr, forKey: "Jokes")
            self.delegate?.updateJokesList()
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }
}
