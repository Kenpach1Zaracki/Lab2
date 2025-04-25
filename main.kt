import java.util.*

// Задание 1: Проверка на выход за границы доски
fun task1() {
    println("Введите размеры доски и строку команд (пример: 3 3 RRD):")
    val input = readLine()?.split(" ") ?: return
    if (input.size != 3) {
        println("No")
        return
    }

    val n = input[0].toIntOrNull() ?: 0
    val m = input[1].toIntOrNull() ?: 0
    val s = input[2]

    if (n <= 0 || m <= 0 || s.any { it !in "LRUD" }) {
        println("No")
        return
    }

    var x = 0
    var y = 0
    var minX = 0
    var maxX = 0
    var minY = 0
    var maxY = 0

    for (move in s) {
        when (move) {
            'L' -> x--
            'R' -> x++
            'U' -> y--
            'D' -> y++
        }
        minX = minOf(minX, x)
        maxX = maxOf(maxX, x)
        minY = minOf(minY, y)
        maxY = maxOf(maxY, y)
    }

    if (maxX - minX < m && maxY - minY < n) {
        println("Yes: (${1 - minY}, ${1 - minX})")
    } else {
        println("No")
    }
}

// Проверка корректности имени пользователя
fun isValidUsername(username: String): Boolean {
    if (username.length !in 6..30) return false
    if (username.first() == '.' || username.last() == '.') return false

    for (i in username.indices) {
        val c = username[i]
        if (!(c.isLowerCase() || c.isDigit() || c == '.')) {
            return false
        }
        if (c == '.' && i + 1 < username.length && username[i + 1] == '.') {
            return false
        }
    }

    return true
}

// Нормализация имени пользователя
fun normalizeUsername(raw: String): String {
    val result = StringBuilder()
    for (c in raw) {
        if (c == '*') break
        if (c == '.') continue
        result.append(c)
    }
    return result.toString()
}

// Задание 2: Подсчёт уникальных email
fun task2() {
    val emails = listOf(
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru"
    )

    val uniqueEmails = mutableSetOf<String>()

    for (email in emails) {
        val at = email.indexOf('@')
        if (at == -1) continue

        val user = email.substring(0, at)
        val domain = email.substring(at)

        if (!isValidUsername(user)) continue

        val normalized = normalizeUsername(user) + domain
        uniqueEmails.add(normalized)
    }

    println("Уникальных адресов: ${uniqueEmails.size}")
}

// Задание 3: Подсчёт серий чисел
fun task3() {
    println("Введите числа через пробел:")
    val input = readLine()?.trim() ?: return
    if (input.isEmpty()) {
        println("Серий: 0")
        return
    }

    val numbers = input.split("\\s+".toRegex()).mapNotNull { it.toIntOrNull() }
    if (numbers.isEmpty()) {
        println("Серий: 0")
        return
    }

    var count = 1
    for (i in 1 until numbers.size) {
        if (numbers[i] < numbers[i - 1]) {
            count++
        }
    }

    println("Серий: $count")
}

// Главное меню
fun main() {
    val scanner = Scanner(System.`in`)

    while (true) {
        println("\nВыберите задание:")
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
