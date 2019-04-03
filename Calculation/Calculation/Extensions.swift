//Это файл с раширениеми (подробно о них хорошо написано в книге)
//В двух словах это дополнения к классам, струкрам. В качестве примера возьмем базовый класс NSView (в его тело ты не можешь добавлять функции, ибо это .lib). Но у тебя есть можный инструмент как extension - с помощью него ты можешь добавлять функции в базовый класс, который потом можно использовать вне этого файла
import Cocoa

extension NSView {
    //функция для установки ширины и высоты вью
    func setDimensions(width: CGFloat, height: CGFloat) {
        //Разрешаем применять изменения в размещении, размерах главному вью
        self.translatesAutoresizingMaskIntoConstraints = false
        //        устанавиваем постоянную ширину и высоту
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    //добавлению вью в центр другого вью
    func addCenter(to view: NSView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    //добавление массивов вью во вью
    func add(views: [NSView]) {
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //добавление вью с учетом янкорей (про янкоря много написано в инете (либо могу сам лично тебе рассказать))
    func add(subview: NSView, with anchors: [Anchor]) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        for anchor in anchors {
            applyAnchor(anchor: anchor, view: subview)
        }
    }
    //применение якорей
    private func applyAnchor(anchor: Anchor, view: NSView) {
        switch anchor {
        case .leading:
            view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor).isActive = true
        case .trailing:
            view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor).isActive = true
        case .top:
            view.topAnchor.constraint(equalTo: view.superview!.topAnchor).isActive = true
        case .bottom:
            view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor).isActive = true
        }
    }
}

enum Anchor {
    case leading
    case trailing
    case top
    case bottom
}
//Расширение для кнопки
extension NSButton {
    //данная функция позволяет установить цвет, размер и выравнивание для текста в кнопке
    func setAttributes(foreground: NSColor? = nil, fontSize: CGFloat = -1.0, alignment: NSTextAlignment? = nil) {
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if let foreground = foreground {
            attributes[NSAttributedString.Key.foregroundColor] = foreground
        }
        
        if fontSize != -1 {
            attributes[NSAttributedString.Key.font] = NSFont.systemFont(ofSize: fontSize)
        }
        
        if let alignment = alignment {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = alignment
            attributes[NSAttributedString.Key.paragraphStyle] = paragraph
        }
        
        let attributed = NSAttributedString(string: self.title, attributes: attributes)
        
        self.attributedTitle = attributed
    }
}

extension Int {
    //Функция преобразовывает Int в Римского отображение 
    func translateToRomeNumber() -> String {
        let dictRomeNumber: [Int: String] = [1: "I", 2: "II", 3: "III", 4: "IV", 5: "V", 6: "VI"]
        guard let number = dictRomeNumber[self] else {
            return "X"
        }
        return number
    }
}
