//
//  webViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 17/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class webViewController: UIViewController {
   
    @IBOutlet weak var urlSearch: UILabel!
    @IBOutlet weak var web: UIWebView!
    
    var urls : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Web Navegation"
        urlSearch?.text = urls!
        let url = NSURL(string: urls!)
        let peticion = NSURLRequest(URL: url!)
        web.loadRequest(peticion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
