import Foundation

// Задание 1: Проверка движения по доске
func checkBoardMovement() {
    print("Введите размеры доски и строку движений (пример: 3 3 RRD):")
    guard let input = readLine()?.split(separator: " ").map({ String($0) }), input.count == 3 else {
        print("Invalid input format.")
        return
    }

    guard let N = Int(input[0]), let M = Int(input[1]) else {
        print("No - Некорректные размеры доски.")
        return
    }

    let moves = input[2]

    // Проверка на отрицательные размеры доски
    if N <= 0 || M <= 0 {
        print("No - Некорректные размеры доски.")
        return
    }

    // Начальные координаты (0, 0)
    var x = 0
    var y = 0

    // Обработка каждого движения
    for move in moves {
        switch move {
        case "L":
            x -= 1
        case "R":
            x += 1
        case "U":
            y -= 1
        case "D":
            y += 1
        default:
            print("No - Некорректная команда.")
            return
        }

        // Проверка, не выходит ли фигура за пределы доски
        if x < 0 || x >= M || y < 0 || y >= N {
            print("No - Движение выходит за пределы доски.")
            return
        }
    }

    // Если не выходит за пределы, выводим координаты
    print("(\(y + 1),\(x + 1))") // Координаты на доске с учетом 1 индексации
}

// Задание 2: Подсчёт уникальных email
func countUniqueEmails() {
    print("Введите email-адреса через пробел:")
    guard let input = readLine()?.split(separator: " ").map({ String($0) }) else {
        print("Некорректный ввод.")
        return
    }

    let uniqueEmails = Set(input)
    print("Уникальных email-адресов: \(uniqueEmails.count)")
}

// Задание 3: Подсчёт серий чисел
func countNumberSeries() {
    print("Введите числа через пробел:")
    guard let input = readLine()?.split(separator: " ").map({ Int($0) ?? 0 }), !input.isEmpty else {
        print("Серий: 0")
        return
    }

    var count = 0
    var currentSeriesCount = 1

    for i in 1..<input.count {
        if input[i] == input[i - 1] + 1 {
            currentSeriesCount += 1
        } else {
            if currentSeriesCount > 1 {
                count += 1
            }
            currentSeriesCount = 1
        }
    }

    if currentSeriesCount > 1 {
        count += 1
    }

    print("Серий: \(count)")
}

// Основное меню
func main() {
    while true {
        print("\nВыберите задание:")
        print("1 - Проверка движения по доске")
        print("2 - Подсчёт уникальных email")
        print("3 - Подсчёт серий чисел")
        print("0 - Выход")

        guard let choice = readLine(), let taskNumber = Int(choice) else {
            print("Некорректный ввод.")
            continue
        }

        switch taskNumber {
        case 1:
            checkBoardMovement()
        case 2:
            countUniqueEmails()
        case 3:
            countNumberSeries()
        case 0:
            print("Выход")
            return
        default:
            print("Некорректный выбор.")
        }
    }
}

// Запуск программы
main()
