//
//  ContentViewController.swift
//  HowToExercite
//
//  Created by Raquel Guerrero Perucho on 18/11/23.
//

import UIKit

class ContentViewController: UIViewController {
    
    
    @IBOutlet weak var nameEx: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ExerciceExplanation: UITextView!
    
    var exerciceName = ""
    var pageIndex = 0
    var exerciceExpText = ""
    var imageFilename = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameEx.text = self.exerciceName
        
        self.imageView.image = UIImage(named: self.imageFilename)
        self.ExerciceExplanation.text = self.exerciceExpText
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
