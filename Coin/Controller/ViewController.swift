
import UIKit

class ViewController: UIViewController {
    
    // Объявляем UIPickerView, UILabel для отображения выбранной валюты и UILabel для отображения выбранной цены
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var currencyView: UILabel!
    
    // Создаем массив данных, который будет использоваться для заполнения UIPickerView
    let yourDataArray = ["USD", "EUR", "RUB"]
    
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
     // Устанавливаем делегаты для UIPickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }


}

extension ViewController: UIPickerViewDataSource {
    // Указываем, что в UIPickerView будет один столбец
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Указываем, что в UIPickerView будет три строки
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yourDataArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    // Указываем, какие строки отображать в UIPickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yourDataArray[row]
    }
    // Указываем, что произойдет, когда пользователь выберет строку в UIPickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Устанавливаем текст UILabel currencyView, соответствующий выбранной строке в UIPickerView
        currencyView.text = yourDataArray[row]
    }
}
