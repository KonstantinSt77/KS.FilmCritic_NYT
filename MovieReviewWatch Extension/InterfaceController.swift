//
//  InterfaceController.swift
//  MovieReviewWatch Extension
//
//  Created by Kostya on 05.01.2018.
//  Copyright © 2018 SKS. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    var films = ["Belgium", "USA", "UK", "India", "China", "Australia"]
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
//        let userDefaults = UserDefaults(suiteName: "group.watch.movie")
//        let pi = userDefaults?.string(forKey: "arrayOfMovies")
//        print("rfrfrfrfrfrfrfrf" + (pi)!)
        self.setupTable()
    }
    
    func setupTable()
    {
        tableView.setNumberOfRows(films.count, withRowType: "FCRow")
         for i in (0..<films.count)
         {
            if let row = tableView.rowController(at: i) as? FCRow
            {
                row.flabel.setText(films[i])
                let urlimgae = URL(string: "https://upload.wikimedia.org/wikipedia/ru/4/48/Luther2003FilmPoster.jpg")
                let data = try? Data(contentsOf: urlimgae!)
                row.fimage.setImage(UIImage(data: data!))
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

