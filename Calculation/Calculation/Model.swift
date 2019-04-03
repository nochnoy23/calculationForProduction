//Здесь находится структуры данных, которые применяются в данном проекте

import Foundation
import Cocoa

//Основная структура для первого экрана
struct Item {
    let label: CustomTextField //Описание поля
    let textField: CustomTextField? //Поле ввода
    let number: Int //Порядковый номер (В целом можно и без него, но хотелось сделать человеческое Dicription (label), поэтому и создал лишнюю переменную)
    
    //isFirst - флаг заголовка; Если тру - заголовок, фалсе - нет
    //Инициализатор сруктуры (isFirst: Bool = false обозначает, что по умолчанию переменная isFirst равно false. При создании экземляра структуры можно данную переменную не указать и значение будет равно false)
    init(title: String, number: Int, isFirst: Bool = false) {
        //про self лучше самой почитать
        self.number = number
        
        //тернарный оператор, про то, что проиходит внтури, лучше все же меня спросить или самой разобраться)
        label = isFirst
            ? CustomTextField(with: "\(number.translateToRomeNumber()). \(title)", font: 14,
                              textColor: NSColor(calibratedRed: 34/255, green: 138/255, blue: 23/255, alpha: 1))
            : CustomTextField(with: "\(number). \(title)", font: 12, textColor: .black)
        
        //тернарный оператор, если isFirst = true, то нет смысла создавать поле ввода для заголовка, поэтому нил
        textField = isFirst
            ? nil
            : CustomTextField()
    }
    
    //функция считывания значений из полей ввода, функция вызывается после нажатия на кнопку "Продолжить"
    func readValue() -> String? {
        //Проверка наличия поля ввода (у заголовкой из нет)
        guard let textFd = self.textField else {
            return nil
        }
        //Проверка поля ввода, если оно пустое, то после нажатия на кнопку оно будет выделено
        if textFd.stringValue.isEmpty {
            textFd.selectText(nil)
        }
        
        //цикл для удаления лишних нулей в десятичной дроби (пример "0.100" будет равно "0.1")
        while true {
            if textFd.stringValue.count == 1 {
                break
            }
            if textFd.stringValue.last == "0" {
                textFd.stringValue.removeLast()
                continue
            }
            break
        }
        //если считываемое значение "0.", то оно преобразуется в "0"
        if textFd.stringValue.last == "." {
            textFd.stringValue.removeLast()
        }
        
        return textFd.stringValue
    }
}

// Структура второго экрана
struct TotalData {
    //сообщение о результате
    let message: String
    //Подсчитанный процент
    let procent: Int
    //Цвет вывода
    let color: NSColor
}
