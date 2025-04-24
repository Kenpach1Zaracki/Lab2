import java.util.*

fun task1() {
    val input = readLine()!!.split(" ")
    val (N, M) = input[0].toInt() to input[1].toInt()
    val S = input[2]

    // Проверка на отрицательные размеры доски
    if (N <= 0 || M <= 0) {
        println("No")
        return
    }

    // Проверка на недопустимые символы в строке команд
    if (S.any { it !in "LRUD" }) {
        println("No")
        return
    }

    var minX = 0
    var maxX = 0
    var minY = 0
    var maxY = 0
    var x = 0
    var y = 0

    for (move in S) {
        when (move) {
            'L' -> x--
            'R' -> x++
            'D' -> y++
            'U' -> y--
        }
        minX = minOf(minX, x)
        maxX = maxOf(maxX, x)
        minY = minOf(minY, y)
        maxY = maxOf(maxY, y)
    }

    if (maxX - minX < M && maxY - minY < N) {
        println("(${1 - minY},${1 - minX})")
    } else {
        println("No")
    }
}

fun normalizeEmail(email: String): String {
    val (local, domain) = email.split("@")
    val cleanLocal = local.substringBefore('+').replace(".", "")
    return "$cleanLocal@$domain"
}

fun task2() {
    val emails = listOf(
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru"
    )

    val uniqueEmails = emails.map { normalizeEmail(it) }.toSet()
    println("Уникальных адресов: ${uniqueEmails.size}")
}

fun task3() {
    val line = readLine()?.trim() // Читаем всю строку чисел и удаляем лишние пробелы

    if (line.isNullOrEmpty()) {
        println("Серий: 0") // Если строка пуста, сразу выводим 0
        return
    }

    val numbers = line.split("\\s+".toRegex()).map { it.toInt() } // Разделяем строку на числа
    var count = 0

    if (numbers.isNotEmpty()) {
        count = 1 // Первая серия
        var prev = numbers[0]

        for (i in 1 until numbers.size) {
            val curr = numbers[i]
            if (curr < prev) {
                count++ // Увеличиваем счетчик серий
            }
            prev = curr // Обновляем предыдущее число
        }
    }

    println("Серий: $count")
}

fun main() {
    val scanner = Scanner(System.`in`)

    while (true) {
        println("Выберите задание:")
        println("1 - Проверка движения по доске")
        println("2 - Подсчёт уникальных email")
        println("3 - Подсчёт серий чисел")
        println("0 - Выход")

        when (scanner.nextInt()) {
            1 -> {
                println("Вы выбрали задание 1: Проверка движения по доске")
                task1()
            }
            2 -> {
                println("Вы выбрали задание 2: Подсчёт уникальных email")
                task2()
            }
            3 -> {
                println("Вы выбрали задание 3: Подсчёт серий чисел")
                task3()
            }
            0 -> {
                println("Выход...")
                break
            }
            else -> println("Неверный выбор!")
        }
    }
}

