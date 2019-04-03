//Файл с классами вьюшек
//Тут происходит создание всех экранов, и все что они содеражт
//В целом здесь все просто, я начало чуть описал, дальше в целом по аналогии, при не понятках мне писать
//И да, скорее все же придется лично встречаться
import Cocoa

//Класс первого вью
class CustomFirstView: NSView {
    init(items: [[Item]], callback: @escaping () -> ()) {
        
        super.init(frame: .zero)
        
        var arrayInputs: [NSView] = []
        for item in items {
            //создание стэка входных полей
            arrayInputs.append(createStack(views: createHorizontalView(items: item)))
        }
        //Создание вью с кнопкой
        let buttonView = CustomButtonView(with: "Продолжить", callback: callback)
        //Созданию вью главного заголовка
        let titleView = CustomTitleView(with: "Пожалуйста, введите степень реализации мероприятия")
        
        self.add(subview: createGlobalView(titleView: titleView,
                                           leftView: arrayInputs[0],
                                           centralView: arrayInputs[1],
                                           rightView: arrayInputs[2],
                                           buttonView: buttonView),
                 with: [.top, .bottom, .leading, .trailing])
        
        self.setDimensions(width: 1100, height: 580)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Создание всего вью для первого экрана
    //Я разделил первый экран на 5 частей - надеюсб поймешь на какие, если нет, я нарисую тебе
    //попробуй разобарться, в целом из названия очевидно, но если начнет от этого болеть голова, лучше спроси у меня
    private func createGlobalView(titleView: NSView,
                                  leftView: NSView,
                                  centralView: NSView,
                                  rightView: NSView,
                                  buttonView: NSView) -> NSView {
        let offset: CGFloat = 25
        let leftAndCentral = makeHorizontalView(left: leftView,         right: centralView,     offset: offset)
        let rightUpAndDown = makeVerticalView(top: rightView,           bottom: buttonView,     offset: offset)
        let inputViews =     makeHorizontalView(left: leftAndCentral,   right: rightUpAndDown,  offset: offset)
        
        return makeVerticalView(top: titleView, bottom: inputViews, offset: 10)
    }
    
    private func makeHorizontalView(left: NSView, right: NSView, offset: CGFloat) -> NSView {
        
        let view = NSView(frame: .zero)
        view.add(subview: left, with: [.leading, .top, .bottom])
        view.add(subview: right, with: [.trailing, .top, .bottom])
        
        left.rightAnchor.constraint(lessThanOrEqualTo: right.leftAnchor, constant: (offset) * (-1)).isActive = true
        
        return view
    }
    
    private func makeVerticalView(top: NSView, bottom: NSView, offset: CGFloat) -> NSView {
        
        let view = NSView(frame: .zero)
        view.add(subview: top, with: [.leading, .trailing, .top])
        view.add(subview: bottom, with: [.leading, .trailing, .bottom])
        
        top.bottomAnchor.constraint(lessThanOrEqualTo: bottom.topAnchor, constant: (offset) * (-1)).isActive = true
        
        return view
    }
    
    private func createStack(views: [NSView]) -> NSView {
        let vertView = NSView(frame: .zero)
        
        for (index, view) in views.enumerated() {
            vertView.add(subview: view, with: [.trailing, .leading])
            if index == 0 {
                view.topAnchor.constraint(equalTo: vertView.topAnchor).isActive = true
                continue
            }
            view.topAnchor.constraint(equalTo: views[index - 1].bottomAnchor, constant: 15).isActive = true
            if index == views.count - 1 {
                view.bottomAnchor.constraint(equalTo: vertView.bottomAnchor).isActive = true
            }
        }
        return vertView
    }
    
    private func createHorizontalView(items: [Item]) -> [NSView] {
        let maxWidth: CGFloat = 240
        
        var views: [NSView] = []
        for item in items {
            
            let view = NSView(frame: .zero)
            let label = item.label
            
            view.add(views: [label])
            
            label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            guard let textField = item.textField else {
                label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                views.append(view)
                continue
            }
            
            view.add(views: [textField])
            
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
            label.rightAnchor.constraint(lessThanOrEqualTo: textField.leftAnchor, constant: -25).isActive = true
            label.widthAnchor.constraint(equalToConstant: maxWidth).isActive = true
            
            textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            textField.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
            textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            views.append(view)
        }
        return views
    }
}

class CustomSecondView: NSView {
    init(data: TotalData, callback: @escaping () -> ()) {
        super.init(frame: .zero)
        
        let procentSting = "\(data.procent)%"
        
        
        let topString = createDoubleColorString(first: "Транспортный узел ",
                                                second: data.message,
                                                secondColor: data.color)
        let bottomString = createDoubleColorString(first: "Результат оценки реализации мероприятий по\nобеспечению защищенности транспортного узла ",
                                                   second: procentSting,
                                                   secondColor: data.color)
        
        let topLabel = CustomTextField(with: topString)
        let bottomLabel = CustomTextField(with: bottomString)

        let buttonView = CustomButtonView(with: "Заново произвести расчет", callback: callback)

        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        self.add(subview: topLabel, with: [.leading, .trailing, .top])
        self.add(subview: bottomLabel, with: [.leading, .trailing])
        self.add(subview: buttonView, with: [.leading, .trailing, .bottom])
        
        topLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomLabel.topAnchor, constant: -20).isActive = true
        bottomLabel.bottomAnchor.constraint(lessThanOrEqualTo: buttonView.topAnchor, constant: -30).isActive = true
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createDoubleColorString(first: String, second: String, secondColor: NSColor) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let firstOptions = [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 15),
                            NSAttributedString.Key.foregroundColor: NSColor.black,
                            NSAttributedString.Key.paragraphStyle: paragraph]
        let secondOptions = [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 15),
                             NSAttributedString.Key.foregroundColor: secondColor,
                             NSAttributedString.Key.paragraphStyle: paragraph]
        
        let firstString = NSMutableAttributedString(string: first, attributes: firstOptions)
        let secondString = NSMutableAttributedString(string: second, attributes: secondOptions)
        
        firstString.append(secondString)
        return firstString
    }
}
//Создание вью с кнопкой
class CustomButtonView: NSView {
    init(with title: String, callback: @escaping () -> ()) {
        self.callback = callback
        super.init(frame: .zero)

        let button = NSButton(with: title)
        button.target = self
        button.action = #selector(pressButton) //указываем какое событие будет выполняется по нажатию на кнопку
        
        self.addCenter(to: button)
        
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressButton() {
        callback()
    }
    
    let callback: () -> ()
}

class CustomTextField: NSTextField, NSTextFieldDelegate {
    init(with attributedString: NSAttributedString) {
        super.init(frame: .zero)
        
        self.attributedStringValue = attributedString
        self.isEditable = false
        self.isSelectable = false
        self.isBezeled = false
        self.backgroundColor = .none
    }
    
    init(with text: String, font: CGFloat, textColor color: NSColor) {
        super.init(frame: .zero)
        
        self.stringValue = text
        self.isEditable = false
        self.isSelectable = false
        self.isBezeled = false
        self.backgroundColor = .none
        self.font = NSFont.systemFont(ofSize: font)
        self.textColor = color
    }
    
    init() {
        super.init(frame: .zero)
        
        self.textColor = .black
        self.drawsBackground = true
        self.backgroundColor = NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.alignment = .center
        self.bezelStyle = .squareBezel
        self.delegate = self
    }
    
    func controlTextDidChange(_ obj: Notification) {
        let string = self.stringValue
        
        var count: Int = 0
        for char in string where char == "."{
            count += 1
        }
        
        if string.first == "." || string.first != "1" && string.first != "0" {
            self.stringValue = ""
        }
        
        if string.count == 2 && string.last != "." && string.first == "0" ||  count > 1 {
            self.stringValue = prevValue
        }
        
        if string.first == "1" {
            self.stringValue = "1"
        }
        
        if string.count > 5  {
            self.stringValue = prevValue
        }
        
        self.prevValue = self.stringValue
        
        let charSet = NSCharacterSet(charactersIn: "1234567890.").inverted
        let chars = self.stringValue.components(separatedBy: charSet)
        self.stringValue = chars.joined()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var prevValue: String = ""
}

class CustomTitleView: NSView {
    init(with text: String) {
        super.init(frame: .zero)
        
        let title = NSTextField(labelWithString: text)
        
        title.font = NSFont.boldSystemFont(ofSize: 17)
        title.alignment = .center
        title.textColor = .black
        
        self.add(subview: title, with: [.trailing, .leading, .bottom, .top])
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ColorView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).setFill()
        dirtyRect.fill()
    }
}


extension NSButton {
    convenience init(with title: String) {
        self.init(frame: .zero)
        
        self.title = title
        self.bezelStyle = .regularSquare
        self.setAttributes(foreground: NSColor(calibratedRed: 34/255, green: 138/255, blue: 23/255, alpha: 1),
                             fontSize: 17,
                             alignment: .center)
        self.isBordered = true

        let color = NSColor(calibratedRed: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        self.layer?.backgroundColor = color
        self.layer?.cornerRadius = 2
    }
}
