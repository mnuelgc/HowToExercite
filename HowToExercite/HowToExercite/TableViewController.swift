//
//  TableViewController.swift
//  HowToExercite
//
//  Created by Raquel Guerrero Perucho on 19/11/23.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {

    var nameList = [String]()

    var exercices = [Exercice]()
    
    private var searchController : UISearchController?
    private var searchResults = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        createExercices()
        
        // Creamos una tabla alternativa para visualizar los resultados cuando se seleccione la búsqueda
        let searchResultsController = UITableViewController(style: .plain)
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.delegate = self

        // Asignamos esta tabla a nuestro controlador de búsqueda
        self.searchController = UISearchController(searchResultsController: searchResultsController)
        self.searchController?.searchResultsUpdater = self

        // Especificamos el tamaño de la barra de búsqueda
        if let frame = self.searchController?.searchBar.frame {
            self.searchController?.searchBar.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 44.0)
        }

        // La añadimos a la cabecera de la tabla
        self.tableView.tableHeaderView = self.searchController?.searchBar

        // Esto es para indicar que nuestra vista de tabla de búsqueda se superpondrá a la ya existente
        self.definesPresentationContext = true

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let src = self.searchController?.searchResultsController as! UITableViewController

        if tableView == src.tableView {
            return self.searchResults.count
        }
        else {
            return self.exercices.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)

          let src = self.searchController?.searchResultsController as! UITableViewController
          let object : String?

          if tableView == src.tableView {
              object = self.searchResults[indexPath.row]
          }
          else {
              object = exercices[indexPath.row].name
          }

          cell.textLabel!.text = object
          return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let exercice = self.exercices[indexPath.row]
            
            // Conexión con el controlador detalle
            
            let sectionViewController = splitViewController!.viewController(for: .secondary) as? SectionViewController
            //detailViewController?.etiqueta.text = pelicula.titulo
            sectionViewController?.didChangeExercice(with: exercice)
            
            if !sectionViewController!.isBeingPresented{
                splitViewController!.showDetailViewController(sectionViewController!, sender: self)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Cogemos el texto introducido en la barra de búsqueda
        let searchString = self.searchController?.searchBar.text


        // Si la cadena de búsqueda es vacía, copiamos en searchResults todos los objetos
        if searchString == nil || searchString == "" {
            self.searchResults = self.nameList
        }
        // Si no, copiamos en searchResults sólo los que coinciden con el texto de búsqueda
        else {
            let searchPredicate = NSPredicate(format: "SELF BEGINSWITH[c] %@", searchString!)
            let array = (self.nameList as NSArray).filtered(using: searchPredicate)
            self.searchResults = array as! [String]
        }

        // Recargamos los datos de la tabla
        let tvc = self.searchController?.searchResultsController as! UITableViewController
        tvc.tableView.reloadData()

        // Deseleccionamos la celda de la tabla principal
        if let selected = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at:selected, animated: false)
        }
    }

    
    func createExercices()
    {
        var name = "Clean & Jerk"
        var imagesName = [String]()
        imagesName.append("CJ1")
        imagesName.append("CJ2")
        imagesName.append("CJ3")
        imagesName.append("CJ4")
        imagesName.append("CJ5")
        
        var explanations = [String]()
        explanations.append("Comienza con los pies a la altura de los hombros, los dedos de los pies apuntando ligeramente hacia afuera. El agarre de la barra debe ser un poco más ancho que el ancho de los hombros. Asegúrate de que la espalda esté recta, el pecho hacia arriba y los hombros sobre la barra. Mantén la cabeza en posición neutral.")
        explanations.append("Flexiona las rodillas y baja las caderas: Mantén la espalda recta mientras te agachas para agarrar la barra con ambas manos. Las manos deben estar colocadas justo afuera de las piernas.\n \nLevanta la barra: Mantén el pecho hacia arriba, la espalda recta y extiende las caderas y las rodillas simultáneamente para levantar la barra del suelo. La barra debe permanecer cerca del cuerpo durante este movimiento. \n \nEncoge los hombros: Una vez que la barra pasa las rodillas, encoge los hombros hacia arriba y hacia adelante, llevando la barra hacia los hombros. Los codos deben apuntar hacia afuera para permitir que la barra suba en línea recta.")
        explanations.append("Cuando la barra esté en los hombros, dobla ligeramente las rodillas para absorber el impacto y asegurar la posición.")
        explanations.append("Posición de Split o Empuje: Desde la posición en los hombros, adopta una posición de split (abriendo las piernas en un paso largo hacia adelante y hacia atrás) o realiza un impulso con las piernas para propulsar la barra hacia arriba.\n \nBloqueo de los Brazos: Simultáneamente, extiende los brazos hacia arriba y bloquea los codos para sostener la barra por encima de la cabeza. Mantén la espalda recta y el núcleo comprometido.")
        explanations.append("Reversa el Split o Vuelve a la Posición Inicial: Si realizaste un split, vuelve a juntar las piernas. Baja la barra controladamente de regreso a la posición inicial para prepararte para el siguiente levantamiento o para bajar la barra al suelo.\n \nControla la Barra: Asegúrate de mantener el control de la barra durante todo el movimiento para evitar lesiones.")
        
        var categories = [Catergory]()
        categories.append(Catergory.barra)
        
        nameList.append(name)
        
        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        
        
        name = "Full Snatch"
        imagesName = [String]()
        imagesName.append("S1")
        imagesName.append("S2")
        imagesName.append("S3")
   
        explanations = [String]()
        explanations.append("Posición Inicial: Colócate con los pies a la altura de los hombros, dedos apuntando ligeramente hacia afuera.\n \nEl agarre de la barra debe ser más ancho que tus hombros.\n \nMantén la espalda recta y los hombros sobre la barra.")

        explanations.append("Levantamiento (Snatch): Flexiona las rodillas y baja las caderas al agarrar la barra. Mantén la espalda recta al levantar la barra desde el suelo, extendiendo caderas y rodillas. \n \nEncoge los hombros cuando la barra pase las rodillas, llevándola hacia arriba hasta los hombros.")

        explanations.append("Posición Final: Desde los hombros, realiza un movimiento explosivo para impulsar la barra sobre la cabeza. \n \nBloquea los brazos, mantén la espalda recta y el núcleo comprometido. \n \nReversa el movimiento, controlando la bajada de la barra al suelo.")
        
        
        categories = [Catergory]()
        categories.append(Catergory.barra)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Burpee"
        imagesName = [String]()
        imagesName.append("B1")
        imagesName.append("B2")
   
        explanations = [String]()
        explanations.append("Inicio del Burpee: Comienza de pie con los pies a la altura de los hombros. \n \nLuego, baja a una posición de sentadilla y coloca las manos en el suelo frente a ti, manteniendo los pies en su lugar.\n \nRealiza un pequeño salto para llevar los pies hacia atrás y entra en una posición de plancha, manteniendo el cuerpo en línea recta desde la cabeza hasta los talones.\n")

        explanations.append("Salto y Finalización: Desde la posición de plancha, lleva los pies de vuelta hacia tus manos y realiza un salto explosivo hacia arriba. \n \nExtiende completamente el cuerpo en el aire y al aterrizar, aterriza suavemente en la posición inicial de sentadilla. \n \nEste ciclo completo constituye un Burpee.\n")
        
        
        categories = [Catergory]()
        categories.append(Catergory.libre)
        categories.append(Catergory.pesoCorporal)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Box Jump"
        imagesName = [String]()
        imagesName.append("BJ1")
        imagesName.append("BJ2")
   
        explanations = [String]()
        explanations.append("Inicio del Box Jump:Comienza frente a una caja con los pies a la altura de los hombros.\n \nMantén una posición de pie con los brazos a los lados. \n \nLa caja debe estar lo suficientemente cerca para que puedas saltar fácilmente, pero lo suficientemente lejos para que sea un desafío.\n")

        explanations.append("Salto y Aterrizaje: Flexiona las rodillas y realiza un salto explosivo hacia arriba. \n \nLleva las rodillas hacia el pecho mientras estás en el aire. \n \nAterriza suavemente en la caja, asegurándote de mantener una postura estable. \n \nExtiende las piernas completamente antes de bajar de nuevo al suelo.\n")
        
        categories = [Catergory]()
        categories.append(Catergory.libre)
        categories.append(Catergory.pesoCorporal)

        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Doble Under"
        imagesName = [String]()
        imagesName.append("du1")
        imagesName.append("du2")
   
        explanations = [String]()
        explanations.append("Preparación para Double Under: Comienza sosteniendo una cuerda para saltar con ambas manos, con los codos cerca del cuerpo. \n \nAjusta la longitud de la cuerda para que alcance hasta tus axilas cuando la pises en el medio. \n \nColócate de pie con los pies juntos y la espalda recta.\n")

        explanations.append("Ejecución del Double Under: Gira la cuerda hacia adelante y salta con los dos pies al mismo tiempo. \n \nMientras la cuerda pasa por debajo de tus pies, realiza dos rotaciones completas antes de aterrizar. \n \nMantén los codos cerca del cuerpo y utiliza la muñeca para girar la cuerda con rapidez. \n \nAterriza suavemente y continúa el ritmo para realizar Double Unders consecutivos.\n")
        
        categories = [Catergory]()
        categories.append(Catergory.cardio)
        categories.append(Catergory.pesoCorporal)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Push Press"
        imagesName = [String]()
        imagesName.append("pu1")
        imagesName.append("pu2")
        imagesName.append("pu3")

   
        explanations = [String]()
        explanations.append("Posición Inicial del Push Press: Comienza con los pies a la altura de los hombros y la barra apoyada en la parte frontal de los hombros, con un agarre un poco más ancho que el ancho de los hombros. \n \nMantén la espalda recta, el pecho hacia arriba y los codos apuntando hacia afuera.\n")

        explanations.append("Ejecución del Push Press: Flexiona ligeramente las rodillas y realiza un movimiento explosivo con las piernas para impulsar la barra hacia arriba. Extiende completamente los brazos mientras empujas la barra por encima de la cabeza. \n \nBloquea los codos en la posición superior. \n \nMantén el núcleo comprometido para estabilizar el cuerpo.\n")

        explanations.append("Finalización del Push Press: Reversa el movimiento bajando la barra controladamente hacia los hombros, flexionando las rodillas ligeramente. \n \nAsegúrate de mantener una buena postura durante todo el ejercicio para maximizar la eficacia y prevenir lesiones.\n")
        
        categories = [Catergory]()
        categories.append(Catergory.barra)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "KB Swing"
        imagesName = [String]()
        imagesName.append("kb1")
        imagesName.append("kb2")
        imagesName.append("kb3")
        imagesName.append("kb2")

   
        explanations = [String]()
        explanations.append("Posición Inicial del KB Swing:Comienza con los pies a la altura de los hombros, sosteniendo una pesa rusa (kettlebell) con ambas manos frente a ti. \n \nMantén la espalda recta, los hombros hacia atrás y las rodillas ligeramente flexionadas. \n \nDeja que la pesa cuelgue entre tus piernas.\n")

        explanations.append("Iniciación del Movimiento: Contrae los músculos de la cadera y las piernas, mientras mantienes la espalda recta. \n \nInicia el movimiento llevando la pesa hacia atrás y entre las piernas. \n \nMantén los brazos extendidos y deja que la pesa siga su curso hacia atrás.\n")

        explanations.append("Swing de la Pesa: Con un movimiento explosivo de las caderas, lleva la pesa hacia adelante y hacia arriba. \n \nHaz que la pesa alcance aproximadamente la altura de los hombros, manteniendo los brazos extendidos. \n \nLas caderas y las piernas son las principales impulsoras del movimiento.\n")

        explanations.append("Finalización del KB Swing: Deja que la pesa vuelva entre las piernas y repite el movimiento.\n \nMantén una buena forma durante todo el ejercicio, con la espalda recta y el núcleo comprometido para maximizar la efectividad y reducir el riesgo de lesiones.\n")

        
        categories = [Catergory]()
        categories.append(Catergory.kettlebell)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Pull up"
        imagesName = [String]()
        imagesName.append("pul1")
        imagesName.append("pul2")
        imagesName.append("pul1")

   
        explanations = [String]()
        explanations.append("Posición Inicial de la Pull Up: Comienza colgando de una barra fija con las manos en un agarre pronunciado (palmas hacia afuera) y los brazos completamente extendidos. \n \nMantén los hombros hacia abajo y hacia atrás, y los pies ligeramente separados.\n")

        explanations.append("Ejecución de la Pull Up: nContrae los músculos de la espalda y los brazos para iniciar el movimiento. \n \nDirige los codos hacia abajo y hacia atrás, llevando tu cuerpo hacia arriba hasta que tu barbilla esté por encima de la barra. \n \nMantén el control del movimiento y evita el impulso excesivo de las piernas.\n")

        explanations.append("Descenso Controlado: Desciende lentamente hasta la posición inicial, evitando balanceos excesivos. \n \nMantén la espalda recta y los hombros comprometidos durante todo el movimiento. \n \nLa fase de descenso controlado trabaja los músculos de manera efectiva y ayuda a prevenir lesiones.\n")

        
        categories = [Catergory]()
        categories.append(Catergory.libre)
        categories.append(Catergory.pesoCorporal)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Muscle Up"
        imagesName = [String]()
        imagesName.append("mus1")
        imagesName.append("mus2")
   
        explanations = [String]()
        explanations.append("Inicio del Burpee: Comienza de pie con los pies a la altura de los hombros. \n \nLuego, baja a una posición de sentadilla y coloca las manos en el suelo frente a ti, manteniendo los pies en su lugar.\n \nRealiza un pequeño salto para llevar los pies hacia atrás y entra en una posición de plancha, manteniendo el cuerpo en línea recta desde la cabeza hasta los talones.\n")

        explanations.append("Salto y Finalización: Desde la posición de plancha, lleva los pies de vuelta hacia tus manos y realiza un salto explosivo hacia arriba. \n \nExtiende completamente el cuerpo en el aire y al aterrizar, aterriza suavemente en la posición inicial de sentadilla. \n \nEste ciclo completo constituye un Burpee.\n")
        
        
        categories = [Catergory]()
        categories.append(Catergory.libre)
        categories.append(Catergory.pesoCorporal)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Turkish Get Up"
        imagesName = [String]()
        imagesName.append("turks1")
        imagesName.append("turks2")
        imagesName.append("turks3")
        imagesName.append("turks4")
        imagesName.append("turks5")
        imagesName.append("turks1")

        explanations = [String]()
        explanations.append("Inicio de Turkish Get Up: Comienza acostado en el suelo de espaldas, sosteniendo una pesa en una mano con el brazo extendido verticalmente hacia arriba. \n \nDobla una pierna con la rodilla apuntando hacia el techo y la otra pierna extendida. \n \nMantén la mirada en la pesa.\n")

        explanations.append("Primera Mitad del Movimiento: Levanta la pesa con el brazo extendido, mientras apoyas el peso del cuerpo en el codo opuesto. \n \nEleva la cadera y desliza la pierna extendida hacia atrás. \n \nColoca la rodilla en el suelo y queda en una posición de rodilla. \n \nLa mirada sigue fija en la pesa.\n")

        explanations.append("Segunda Mitad del Movimiento: Levántate desde la posición de rodilla hasta estar de pie. \n \nLa pierna que estaba doblada inicialmente ahora queda en posición de lunge. \n \nMantén la pesa sobre la cabeza con el brazo extendido. \n \nLa mirada sigue en la pesa durante todo el movimiento.\n")

        explanations.append("Retorno a la Posición Inicial: Retrocede siguiendo los mismos pasos en reversa. \n \nColoca la mano en el suelo, lleva la pierna extendida hacia atrás, baja la cadera y finalmente regresa a la posición inicial acostado en el suelo. \n \nMantén la pesa bajo control en todo momento.\n")

        explanations.append("Repetición del Otro Lado: Realiza el mismo proceso con la pesa en la otra mano. \n \nAlterna entre los lados para equilibrar el trabajo muscular. \n \nMantén una ejecución controlada y fluida del Turkish Get Up para obtener sus beneficios completos.\n")

        explanations.append("Consejos Importantes: Mantén una postura estable y controlada en cada fase del movimiento. \n \nAjusta el peso de la pesa según tu nivel de habilidad. \n \nEste ejercicio es excelente para fortalecer el core, mejorar la estabilidad y movilidad.\n")

        
        categories = [Catergory]()
        categories.append(Catergory.kettlebell)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Handstand Push Up"
        imagesName = [String]()
        imagesName.append("hspu1")
        imagesName.append("hspu2")
        imagesName.append("hspu1")
        

        explanations = [String]()
        explanations.append("Posición Inicial del Handstand Push-Up: Comienza colocándote frente a una pared con las manos en el suelo y los pies apoyados contra la pared, formando un ángulo de 90 grados con el cuerpo. \n \nAsegúrate de que las manos estén ligeramente más anchas que los hombros.\n")

        explanations.append("Ejecución del Handstand Push-Up: Inicia el movimiento bajando lentamente la cabeza hacia el suelo, manteniendo el cuerpo en línea recta. \n \nFlexiona los codos y baja hasta que la cabeza casi toque el suelo. \n \nLuego, empuja con fuerza hacia arriba, extendiendo los brazos completamente. \n \nMantén la posición del cuerpo y repite el movimiento.\n")

        explanations.append("Consejos Importantes: Asegúrate de tener suficiente fuerza en los hombros y tríceps antes de intentar este ejercicio. \n \nPractica primero contra una pared para desarrollar la técnica y la fuerza necesaria. \n \nControla el descenso y el ascenso para evitar lesiones. \n \nSi es necesario, pide a alguien que te supervise o use un compañero para mayor seguridad.\n")
        
        categories = [Catergory]()
        categories.append(Catergory.kettlebell)
        
        nameList.append(name)
        
        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
        
        name = "Back Squat"
        imagesName = [String]()
        imagesName.append("bs1")
        imagesName.append("bs2")
        imagesName.append("bs3")

        explanations = [String]()
        explanations.append("Posición Inicial del Back Squat: Comienza parado con los pies a la altura de los hombros, la barra colocada sobre los trapecios y los hombros, y las manos sosteniendo la barra con un agarre amplio. \n \nAsegúrate de que la barra esté bien posicionada y centrada en tu espalda baja.\n")

        explanations.append("Descenso y Flexión de Rodillas: Inicia el movimiento flexionando las rodillas y las caderas al mismo tiempo. \n \nBaja el cuerpo hacia abajo manteniendo la espalda recta y el núcleo comprometido. \n \nAsegúrate de que las rodillas sigan la línea de los pies y no se desplacen hacia adentro. \n \nDesciende hasta que tus muslos estén al menos paralelos al suelo.\n")

        explanations.append("Ascenso y Extensión de Caderas: Desde la posición más baja, impulsa con fuerza a través de los talones para ascender. \n \nExtiende las caderas y las rodillas simultáneamente mientras mantienes la espalda recta. \n \nContinúa elevándote hasta que vuelvas a la posición inicial.\n \nFinalización del Back Squat: Al llegar a la posición inicial, asegúrate de mantener la buena forma y controlar el peso en todo momento. \n \nEvita bloquear las rodillas al final del movimiento y mantén una respiración constante durante la ejecución del Back Squat.\n")
        
        categories = [Catergory]()
        categories.append(Catergory.kettlebell)
        
        nameList.append(name)

        exercices.append(Exercice(ex_name: name, ex_images: imagesName, ex_explanations: explanations, ex_categories: categories))
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
