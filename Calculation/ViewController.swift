//
//  ViewController.swift
//  Calculation
//
//  Created by Nochnoy Anton on 26/03/2019.
//  Copyright © 2019 Nochnoy Anton. All rights reserved.
//

import Cocoa

fileprivate func calculationOfValues(values a: [Float]) -> Int {
    
    var result: Float = 0.3591 * (0.11 * a[0] + 0.13 * a[1] + 0.15 * a[2] + 0.18 * a[3] + 0.22 * a[4] + 0.21 * a[5])
    result += 0.125  * (0.52 * a[6] + 0.19  * a[7]  + 0.29 * a[8])
    result += 0.1361 * (0.13 * a[9] + 0.07  * a[10] + 0.54 * a[11] + 0.26 * a[12])
    result += 0.1963 * (0.37 * a[13] + 0.09 * a[14] + 0.11 * a[15] + 0.43 * a[16])
    result += 0.1133 * (0.35 * a[17] + 0.17 * a[18] + 0.25 * a[19] + 0.23 * a[20])
    result += 0.0702 * (0.57 * a[21] + 0.32 * a[22] + 0.11 * a[23])
    
    
  
    return Int(result * 100)
}

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [Item(title: "Инженерно-технические мероприятия:",                                  number: 1, isFirst: true),
                     Item(title: "Строительство защитных и инженерно-технический сооружений",           number: 1),
                     Item(title: "Обновление и модернизация систем аварийной защиты",                   number: 2),
                     Item(title: "Организация и сооружение объездных путей",                            number: 3),
                     Item(title: "Перевод производства на более безопасное сырье",                      number: 4),
                     Item(title: "Подготовка резервных систем энергоснабжения, в т.ч. автономных",      number: 5),
                     Item(title: "Другие инженерно-технические мероприятия повышения защищенности КВО", number: 6),
                     
                     
                     Item(title: "Мероприятия по совершенствованию физической защищенности (охраны):",  number: 2, isFirst: true),
                     Item(title: "Совершенствование физический барьеров и препятсвий, систем контроля и управления доступом",
                          number: 7),
                     Item(title: "Совершенствование систем обнаружения проникновения нарушителей",      number: 8),
                     Item(title: "Совершенствование систем телевизионного наблюдения, технических средств предупреждения и воздействия",
                          number: 9)]
        
        
        let items2 = [Item(title: "Финансовое и материально-техническое обеспечение защищенности:",
                           number: 3, isFirst: true),
                      Item(title: "Создание финансовых и материально-технических резервов",              number: 10),
                      Item(title: "Создание топливо-энергетических запасов, воды, продовольствия и других материально-технических средств",
                           number: 11),
                      Item(title: "Приобретение специального аварийно-спасательного, пожарно-технического и другого оборудования, снаряжения и др.",
                           number: 12),
                      Item(title: "Приобретение техники, оборудования и имущества для обеспечения длительной автономной работы КВО",
                           number: 13),
                      
                      
                      Item(title: "Совершенствование системы информатизации и управления:",              number: 4, isFirst: true),
                      Item(title: "Подготовка локальной системы оповещения",                             number: 14),
                      Item(title: "Приобретение оборудования и средства связи",                          number: 15),
                      Item(title: "Заблоаговременное создание запасных (мобильных) пунктов управления",  number: 16),
                      Item(title: "Создание локальной системы мониторинга",                              number: 17)]
        
        
        let items3 = [Item(title: "Совершенствование системы подготовки в области повышения защищенности:",
                                                                                                    number: 5, isFirst: true),
                      Item(title: "Подготовка персонала в области защиты от ЧС",                      number: 18),
                      Item(title: "Подготовка аппарата управления к действиям при угрозе ЧС и террористичеких актов",
                           number: 19),
                      Item(title: "Повышение готовности сил \nохраны",                                   number: 20),
                      Item(title: "Повышение готовности пожарно-спасательных формирований",            number: 21),
                      
                      
                      Item(title: "Другие мероприятия по повышению защищенности (в составе которых учтены мероприятия, не водшедшие ни в одну из предыдущих групп, но вносящие существенный вклад в повышение защищенности КВО:",
                           number: 6, isFirst: true),
                      Item(title: "Модернищация и обновление основных производственных фондов",         number: 22),
                      Item(title: "Выполнение планово-предупредительных ремонтов",                      number: 23),
                      Item(title: "Обеспечение персонала средствами индивидуальной защиты",             number: 24)]
        
        firstView = CustomFirstView(items: [items, items2, items3]) { [unowned self] in
            var arrayValues: [Float] = []
            for item in [items, items2, items3] {
                for element in item {
                    guard let value = element.readValue() else { continue }
                    if value == "" {
                        return
                    }
                    arrayValues.append(Float(value) ?? 0)
                }
            }
            self.arrayValues = arrayValues
        }
        
        self.view = ColorView()
        self.view.addToCenter(for: firstView)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 1140).isActive = true
        view.heightAnchor.constraint(equalToConstant: 620).isActive = true
    }
    
    private var firstView: CustomFirstView!
    private var secondView: CustomSecondView!
    private var arrayValues: [Float] = [] {
        didSet {
            firstView.removeFromSuperview()
            secondView = CustomSecondView(data: setSecondController(arrayValues: arrayValues)) {[weak self] in
                self?.secondView.removeFromSuperview()
                self?.view.addToCenter(for: (self?.firstView)!)
            }
            self.view.addToCenter(for: secondView)
        }
    }
}

extension ViewController {
    fileprivate func setSecondController(arrayValues: [Float]) -> TotalData{
        
        let result = calculationOfValues(values: arrayValues)
        
        switch result {
        case 0..<50:
            return TotalData(message: "не защищен",
                             procent: result,
                             color: .red)
        case 50..<70:
            return TotalData(message: "плохо защищен",
                             procent: result,
                             color: NSColor(calibratedRed: 203/255, green: 89/255, blue: 74/255, alpha: 1))
        case 70..<80:
            return TotalData(message: "условно защищен",
                             procent: result,
                             color: NSColor(calibratedRed: 246/255, green: 207/255, blue: 79/255, alpha: 1))
        case 80...100:
            return TotalData(message: "защищен",
                             procent: result,
                             color: NSColor(calibratedRed: 34/255, green: 138/255, blue: 23/255, alpha: 1))
        default:
            return TotalData(message: "НЕВЕРНАЯ ФОРМУЛА (ТЕСТ РЕЖИМ)",
                             procent: 999,
                             color: .red)
        }
    }
}

struct TotalData {
    let message: String
    let procent: Int
    let color: NSColor
}
