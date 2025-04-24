// Функция для задачи 1: Проверка движения по доске
async function checkBoardMovement(): Promise<void> {
    const input = prompt("Введите размеры доски и последовательность команд (например, 3 3 DDR): ");
    if (!input) {
        console.log("Неверный ввод!");
        return;
    }

    const parts = input.split(" ");
    if (parts.length !== 3) {
        console.log("Неверный формат ввода!");
        return;
    }

    const N = Number(parts[0]);
    const M = Number(parts[1]);
    const S = parts[2];

    // Проверка на отрицательные размеры доски
    if (isNaN(N) || isNaN(M) || N <= 0 || M <= 0) {
        console.log("No - Некорректные размеры доски.");
        return;
    }

    // Проверка на недопустимые символы в строке команд
    if (/[^LRUD]/.test(S)) {
        console.log("No - Некорректная команда.");
        return;
    }

    let minX = 0, maxX = 0, minY = 0, maxY = 0;
    let x = 0, y = 0;

    for (let i = 0; i < S.length; i++) {
        const move = S[i];
        switch (move) {
            case 'L': x--; break;
            case 'R': x++; break;
            case 'D': y++; break;
            case 'U': y--; break;
        }
        minX = Math.min(minX, x);
        maxX = Math.max(maxX, x);
        minY = Math.min(minY, y);
        maxY = Math.max(maxY, y);
    }

    if (maxX - minX < M && maxY - minY < N) {
        console.log(`Yes: (${1 - minY},${1 - minX})`);
    } else {
        console.log("No");
    }
}

// Функция для задачи 2: Подсчет уникальных email
async function countUniqueEmails(): Promise<void> {
    const input = prompt("Введите список email (например, mar.pha+science@corp.nstu.ru): ");
    if (!input) {
        console.log("Неверный ввод!");
        return;
    }

    const emails = input.split(" ");

    function normalizeEmail(email: string): string {
        const parts = email.split("@");
        if (parts.length !== 2) {
            console.log("Некорректный email:", email);
            return email;
        }
        const local = parts[0].split("+")[0].replace(/\./g, "");
        return `${local}@${parts[1]}`;
    }

    const uniqueEmails: string[] = [];

    for (let i = 0; i < emails.length; i++) {
        const normalized = normalizeEmail(emails[i]);
        if (uniqueEmails.indexOf(normalized) === -1) {
            uniqueEmails.push(normalized);
        }
    }

    console.log("Уникальных адресов:", uniqueEmails.length);
}

// Функция для задачи 3: Подсчет серий чисел
async function countSeries(): Promise<void> {
    const input = prompt("Введите последовательность чисел (например, 5 1 2 3 2 5): ");
    if (!input) {
        console.log("Неверный ввод!");
        return;
    }

    const numbers = input.split(" ").map(Number);
    if (numbers.some(isNaN)) {
        console.log("Некорректный ввод чисел!");
        return;
    }

    let count = 0;

    if (numbers.length > 0) {
        count = 1; // Первая серия
        let prev = numbers[0];

        for (let i = 1; i < numbers.length; i++) {
            const curr = numbers[i];
            if (curr < prev) {
                count++; // Увеличиваем счетчик серий
            }
            prev = curr; // Обновляем предыдущее число
        }
    }

    console.log(`Серий: ${count}`);
}

// Главное меню
async function main(): Promise<void> {
    while (true) {
        const choice = prompt(`Выберите задание:
1 - Проверка движения по доске
2 - Подсчёт уникальных email
3 - Подсчёт серий чисел
0 - Выход\n`);

        switch (choice) {
            case '1':
                await checkBoardMovement();
                break;
            case '2':
                await countUniqueEmails();
                break;
            case '3':
                await countSeries();
                break;
            case '0':
                console.log("Выход");
                return;
            default:
                console.log("Неверный ввод");
        }
    }
}

main();

