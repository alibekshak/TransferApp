import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var dataTextFieald: UITextField!
    
    var updatingData: String = ""
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    private func updateTextFieldData(withText text: String){
        dataTextFieald.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton){
        self.navigationController?.viewControllers.forEach{ viewController in
            (viewController as? ViewController)?.updatedData = dataTextFieald.text ?? ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
            
            case "toFirstScreen":
            // обрабатываем переход
                prepareFirstScreen(segue)
            default:
                break
        }
    }
    
    // подготовка к переходу на первый экран
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
    // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? ViewController else {
            return
    }
    destinationController.updatedData = dataTextFieald.text ?? ""
    }
    
    // Переход от Б к А
    // Передача данных с помощью делегата
    @IBAction func saveDataWithDelegate(_ sender: UIButton){
        let updatedData = dataTextFieald.text ?? ""
        // вызываем метод делегата
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        // возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
    
    // Переход от Б к А
    // Передача данных с помощью замыкания
    @IBAction func saveDataWithClouser(_ sender: UIButton){
        let updatedData = dataTextFieald.text ?? ""
        // вызваем замыкание
        completionHandler?(updatedData)
        navigationController?.popViewController(animated: true)
    }
    
}
