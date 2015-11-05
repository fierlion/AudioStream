//
//  ViewController.swift
//  AudioStream
//
//  Created by Ray Foote on 11/4/15.
//  Copyright © 2015 Ray Foote. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AVKit

public var AudioPlayer = AVPlayer()
public var SelectedSongNumber = Int()
public var RadioURL = "http://173.192.137.34:8050/"

class TableViewController: UITableViewController, AVAudioPlayerDelegate {
    
    var IDArray = [String]()
    var NameArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let objectIDQuery = PFQuery(className: "Songs")
        objectIDQuery.findObjectsInBackgroundWithBlock({
            (objectsArray : [PFObject]?, error: NSError?) in
            if(error == nil){
                for i in 0...objectsArray!.count-1{
                    self.IDArray.append(objectsArray![i].valueForKey("objectId") as! String)
                    self.NameArray.append(objectsArray![i].valueForKey("SongName") as! String)
                    self.tableView.reloadData()
                    NSLog("Array is : \(objectsArray)")
                }
            }
            else{
                print("Error in retrieving \(error)")
            }
        
        })

    }
    
    func grabSong() {
        let SongQuery = PFQuery(className: "Songs")
        SongQuery.getObjectInBackgroundWithId(IDArray[SelectedSongNumber], block:  {
            (object : PFObject?, error : NSError?) in
            if let AudioFileURLTemp = object?.objectForKey("SongFile")?.url as String!{
                AudioPlayer = AVPlayer(URL: NSURL(string: AudioFileURLTemp)!)
//                AudioPlayer = AVPlayer(URL: NSURL(string: RadioURL)!)
                AudioPlayer.play()
            }
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IDArray.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell!
        cell.textLabel?.text = NameArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        SelectedSongNumber = indexPath.row
        NSLog("IndexPath is :\(indexPath.row)")
        grabSong()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

