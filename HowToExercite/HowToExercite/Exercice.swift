//
//  Exercice.swift
//  HowToExercite
//
//  Created by Raquel Guerrero Perucho on 19/11/23.
//

import UIKit

enum Catergory : String{
    case barra, libre, mancuernas, cardio, pesoCorporal, kettlebell
}

class Exercice{
    var name : String
    var imagesName : [String]
    var explanations : [String]
    var categories : [Catergory]
    
    init(ex_name: String, ex_images : [String], ex_explanations : [String], ex_categories : [Catergory]){
        self.name = ex_name
        self.imagesName = ex_images
        self.explanations = ex_explanations
        self.categories = ex_categories
    }
    
}
