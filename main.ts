// Задание 1: Проверка на выход за границы доски
function task1(): void {
    const input = prompt("Введите размеры доски и строку команд (пример: 3 3 RRD):");
    if (!input) {
        console.log("Неверный ввод!");
        return;
    }

    const parts = input.split(" ");
    if (parts.length !== 3) {
        console.log("Неверный формат ввода!");
        return;
    }

    const N = parseInt(parts[0]);
    const M = parseInt(parts[1]);
    const S = parts[2];

    if (isNaN(N) || isNaN(M) || N <= 0 || M <= 0) {
        console.log("No");
        return;
    }

    for (const c of S) {
        if (!"LRUD".includes(c)) {
            console.log("No");
            return;
        }
    }

    let minX = 0, maxX = 0, minY = 0, maxY = 0;
    let x = 0, y = 0;

    for (const move of S) {
        if (move === 'L') x--;
        if (move === 'R') x++;
        if (move === 'D') y++;
        if (move === 'U') y--;
        minX = Math.min(minX, x);
        maxX = Math.max(maxX, x);
        minY = Math.min(minY, y);
        maxY = Math.max(maxY, y);
    }

    if (maxX - minX < M && maxY - minY < N) {
        console.log(`Yes: (${1 - minY}, ${1 - minX})`);
    } else {
        console.log("No");
    }
}

// Задание 2: Подсчёт уникальных email
function task2(): void {
    const emails = [
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru"
    ];

    function normalizeEmail(email: string): string {
        const atPos = email.indexOf("@");
        const local = email.substring(0, atPos).split("+")[0].replace(/\./g, "");
        const domain = email.substring(atPos);
        return local + domain;
    }

    const uniqueEmails = new Set<string>();
    for (const email of emails) {
        uniqueEmails.add(normalizeEmail(email));
    }

    console.log(`Уникальных адресов: ${uniqueEmails.size}`);
}

// Задание 3: Подсчёт серий чисел
function task3(): void {
    const input = prompt("Введите числа через пробел:") || "";
    if (!input.trim()) {
        console.log("Серий: 0");
        return;
    }

    const numbers = input.split(" ").map((num) => parseInt(num.trim()));
    if (numbers.some(isNaN)) {
        console.log("Неверный ввод!");
        return;
    }

    let count = 0;
    let prev: number | null = null;

    for (const curr of numbers) {
        if (prev !== null && curr < prev) {
            count++;
        }
        prev = curr;
    }

    console.log(`Серий: ${count}`);
}

// Главное меню
function main(): void {
    while (true) {
        const choice = prompt(
            "\nВыберите задание:\n" +
            "1 - Проверка движения по доске\n" +
            "2 - Подсчёт уникальных email\n" +
            "3 - Подсчёт серий чисел\n" +
            "0 - Выход\n" +
            "Ваш выбор:"
        );

        if (!choice) {
            console.log("Выход...");
            break;
        }

        switch (parseInt(choice)) {
            case 1:
                task1();
                break;
            case 2:
                task2();
                break;
            case 3:
                task3();
                break;
            case 0:
                console.log("Выход...");
                return;
            default:
                console.log("Неверный выбор!");
        }
    }
}

// Запуск программы
main();
