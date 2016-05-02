//
//  eventsTableViewController.swift
//  placeSearch
//
//  Created by Pollinion User on 28/04/16.
//  Copyright © 2016 Pollinion INC. All rights reserved.
//

import UIKit

class eventsTableViewController: UITableViewController {
    
    let url :String = "http://104.236.91.248/mexico"
    var myEvents: Array<Event> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Events"
        self.getData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getData(){
        let urls: String = "http://104.236.91.248/mexico"
        //let urls: String = "10.10.10.10"
        //let urls: String = "http://dia.ccm.itesm.mx"
        let url = NSURL(string: urls)
        let datos = NSData(contentsOfURL: url!)
        if datos == nil
        {
            let alert = UIAlertController(title: "Error conexión", message: "No hay conexión a internet o el servidor no está accesible.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dico1 = json as! NSDictionary
                if dico1["events"] != nil
                {
                    let events = dico1["events"] as! NSArray
                    var newEvent:Event?
                    if events.count > 0
                    {
                        for event in events
                        {
                            let date: String  = event["date"] as! NSString as String
                            let name: String  = event["name"] as! NSString as String
                            let description: String  = event["description"] as! NSString as String
                            let image: String  = event["image"] as! NSString as String
                            newEvent = Event(date: date, name: name, description: description, image: image)
                            myEvents.append(newEvent!)
                        }
                    }
                
                }
                else
                {
                    let alert = UIAlertController(title: "Events Request", message: "Not found events", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                /*
                if dico1["ISBN:"+isbn] != nil
                {
                    let dico2 = dico1["ISBN:"+isbn] as! NSDictionary
                    var new_title : String = ""
                    var new_image : UIImage?
                    var new_authors : [String] = [String]()
                    var image_url : String?
                    
                    //carga el titulo de  el libro
                    if dico2["title"] != nil
                    {
                        new_title =  dico2["title"] as! NSString as String
                    }
                    //carga los autores de libro
                    if dico2["authors"] != nil {
                        let authors = dico2["authors"] as! NSArray
                        if authors.count > 0
                        {
                            for author in authors
                            {
                                new_authors.append( author["name"] as! NSString as String)
                            }
                        }
                    }
                    
                    if dico2["cover"] != nil
                    {
                        let covers = dico2["cover"] as! NSDictionary
                        //muestra portada del de libro
                        if covers["medium"] != nil
                        {
                            image_url = covers["medium"] as! NSString as String
                        }
                        else if covers["small"] != nil
                        {
                            image_url = covers["small"] as! NSString as String
                        }
                        else if covers["large"] != nil
                        {
                            image_url = covers["large"] as! NSString as String
                        }
                        if image_url != nil
                        {
                            let url_img = NSURL(string: image_url!)
                            let data_img = NSData(contentsOfURL: url_img!)
                            //make sure your image in this url does exist, otherwise unwrap in a if let check
                            //-----------
                            new_image = UIImage(data: data_img!)
                        }
                    }
                    let newBook = BookSearch.init(isbn: isbn, title: new_title, authors: new_authors, image: new_image)
                    self.addBockToCell(newBook)
                    return newBook
                }

                */
            }
            catch {
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myEvents.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventTableViewCell", forIndexPath: indexPath) as! eventTableViewCell

        // Configure the cell...
        cell.dateEvent.text = self.myEvents[indexPath.row].date
        cell.nameEvent.text = self.myEvents[indexPath.row].name
        cell.contentEvent.text = self.myEvents[indexPath.row].descriptionEvent
        let url_img = NSURL(string: self.myEvents[indexPath.row].image)
        let data_img = NSData(contentsOfURL: url_img!)
        //make sure your image in this url does exist, otherwise unwrap in a if let check
        //-----------
        cell.pictureEvent.image = UIImage(data: data_img!)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
