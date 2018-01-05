//
//  FCCriticsDetailedVC.swift
//  Movie Review
//
//  Created by Kostya on 05.01.2018.
//  Copyright © 2018 SKS. All rights reserved.
//

import UIKit
import SDWebImage

class FCCriticsDetailedVC: UIViewController {

    var model : FCFeedModel!
    
    @IBOutlet weak var criticImage : UIImageView!
    @IBOutlet weak var criticName : UILabel!
    @IBOutlet weak var criticBIO : UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.criticName.text = model.fauthor
        self.criticBIO.text = model.fsubtitle
        self.criticImage.sd_setImage(with: URL(string:model.fimageLink), placeholderImage:UIImage(named:""))
        self.criticImage.layer.cornerRadius = 90
        self.criticImage.clipsToBounds = true
        self.criticImage.layer.borderWidth = 2
        self.criticImage.layer.borderColor = UIColor.lightGray.cgColor
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
