<?php

function task1() {
    list($N, $M) = explode(" ", trim(fgets(STDIN)));
    $S = trim(fgets(STDIN));

    // Проверка на отрицательные размеры доски
    if ($N <= 0 || $M <= 0) {
        echo "No\n";
        return;
    }

    // Проверка на недопустимые символы в строке команд
    if (preg_match('/[^LRUD]/', $S)) {
        echo "No\n";
        return;
    }

    $minX = 0;
    $maxX = 0;
    $minY = 0;
    $maxY = 0;
    $x = 0;
    $y = 0;

    foreach (str_split($S) as $move) {
        if ($move == 'L') $x--;
        if ($move == 'R') $x++;
        if ($move == 'D') $y++;
        if ($move == 'U') $y--;
        $minX = min($minX, $x);
        $maxX = max($maxX, $x);
        $minY = min($minY, $y);
        $maxY = max($maxY, $y);
    }

    if ($maxX - $minX < $M && $maxY - $minY < $N) {
        echo "(" . (1 - $minY) . "," . (1 - $minX) . ")\n";
    } else {
        echo "No\n";
    }
}

function normalizeEmail($email) {
    list($local, $domain) = explode('@', $email);
    $local = explode('+', $local)[0];
    $local = str_replace('.', '', $local);
    return $local . '@' . $domain;
}

function task2() {
    $emails = [
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru"
    ];

    $unique = [];

    foreach ($emails as $email) {
        $normalized = normalizeEmail($email);
        $unique[$normalized] = true;
    }

    echo "Уникальных адресов: " . count($unique) . "\n";
}

function task3() {
    $line = trim(fgets(STDIN)); // Читаем всю строку чисел и удаляем лишние пробелы

    if (empty($line)) {
        echo "Серий: 0\n"; // Если строка пуста, сразу выводим 0
        return;
    }

    $numbers = preg_split('/\s+/', $line); // Разделяем строку на числа
    $count = 0;

    if (count($numbers) > 0) {
        $count = 1; // Первая серия
        $prev = (int)$numbers[0];

        for ($i = 1; $i < count($numbers); $i++) {
            $curr = (int)$numbers[$i];
            if ($curr < $prev) {
                $count++; // Увеличиваем счетчик серий
            }
            $prev = $curr; // Обновляем предыдущее число
        }
    }

    echo "Серий: $count\n";
}

// Главная функция, которая предлагает выбор задания
function main() {
    while (true) {
        echo "Выберите задание:\n";
        echo "1 - Проверка движения по доске\n";
        echo "2 - Подсчёт уникальных email\n";
        echo "3 - Подсчёт серий чисел\n";
        echo "0 - Выход\n";

        $choice = trim(fgets(STDIN));

        switch ($choice) {
            case 1:
                echo "Вы выбрали задание 1: Проверка движения по доске\n";
                task1();
                break;
            case 2:
                echo "Вы выбрали задание 2: Подсчёт уникальных email\n";
                task2();
                break;
            case 3:
                echo "Вы выбрали задание 3: Подсчёт серий чисел\n";
                task3();
                break;
            case 0:
                echo "Выход...\n";
                return;
            default:
                echo "Неверный выбор!\n";
        }
    }
}

// Запуск главной функции
main();

?>
