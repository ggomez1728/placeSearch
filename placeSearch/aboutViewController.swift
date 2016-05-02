//
//  aboutViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 28/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class aboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lookCV(sender: AnyObject) {
        setQtData("https://www.linkedin.com/in/german-gomez-639b17104")
    }
    
    func setQtData(urlDate : String){
        let nextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("webViewController") as? webViewController
        nextViewController!.urls = urlDate
        self.navigationController?.pushViewController(nextViewController!, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
