//
//  FCFeedDetailVC.swift
//  Movie Review
//
//  Created by Kostya on 05.01.2018.
//  Copyright © 2018 SKS. All rights reserved.
//

import UIKit

class FCFeedDetailVC: UIViewController {

    var linkToShow : String!
    @IBOutlet weak var myWebView : UIWebView!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url = URL(string: linkToShow);
        let requestObj = URLRequest(url: url!);
        myWebView.loadRequest(requestObj);
        print(linkToShow)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
