//
//  SectionViewController.swift
//  HowToExercite
//
//  Created by Raquel Guerrero Perucho on 18/11/23.
//

import UIKit

class SectionViewController: UIViewController,  UIPageViewControllerDataSource, 
                                UIPageViewControllerDelegate {
    
    var contentExercice : Exercice? = nil

    var pageViewController : UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }
    
    func viewControllerAtIndex(index : Int) -> ContentViewController? {
        if let exercice = self.contentExercice{
            if exercice.imagesName.count == 0 || index >= exercice.imagesName.count {
                return nil
            }
            
            // Crear un nuevo controlador de contenido y pasar los datos
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! ContentViewController
            
            pageContentViewController.exerciceName = exercice.name
            pageContentViewController.imageFilename = exercice.imagesName[index]
            pageContentViewController.exerciceExpText = exercice.explanations[index]
            pageContentViewController.pageIndex = index
            
            return pageContentViewController
        }
        return nil
      }

      func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

          let pvc = viewController as! ContentViewController
          var index = pvc.pageIndex

          if index == 0 || index == Foundation.NSNotFound {
              return nil
          }

          index -= 1
          return self.viewControllerAtIndex(index: index)
      }

      func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

          let pvc = viewController as! ContentViewController
          var index = pvc.pageIndex

          if index == Foundation.NSNotFound {
              return nil
          }

          index += 1
          if index == self.contentExercice!.imagesName.count {
              return nil
          }
          return self.viewControllerAtIndex(index: index)
      }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentExercice?.imagesName.count ??  0
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func didChangeExercice(with exercice : Exercice){
      contentExercice = exercice

        
        // Creamos el controlador paginado
           self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController?
           self.pageViewController?.dataSource = self
           self.pageViewController?.delegate = self

           // Creamos el primer controlador de contenido
           let startingViewController = self.viewControllerAtIndex(index: 0)
           let viewControllers = [startingViewController!]

           self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)

           // Cambiamos el tamaño para que quepa el botón de abajo
           self.pageViewController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-30)

           // Añadimos el primer controlador de contenido
           self.addChild(self.pageViewController!)
           self.view.addSubview((self.pageViewController?.view)!)
           self.pageViewController?.didMove(toParent: self)
    }
    
}
