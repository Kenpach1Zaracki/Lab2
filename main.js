const readline = require('readline');

// Задание 1: Проверка движения по доске
function task1() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    rl.question('Введите размеры доски и строку команд (например, "3 3 DDR"): ', (input) => {
        const [N, M, S] = input.split(" ");
        const NInt = parseInt(N);
        const MInt = parseInt(M);

        // Проверка на отрицательные размеры доски
        if (NInt <= 0 || MInt <= 0) {
            console.log("No");
            rl.close();
            return;
        }

        // Проверка на недопустимые символы в строке команд
        if (/[^LRUD]/.test(S)) {
            console.log("No");
            rl.close();
            return;
        }

        let minX = 0, maxX = 0, minY = 0, maxY = 0;
        let x = 0, y = 0;

        for (let move of S) {
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

        if (maxX - minX < MInt && maxY - minY < NInt) {
            console.log(`(${1 - minY},${1 - minX})`);
        } else {
            console.log("No");
        }

        rl.close();
    });
}

// Задание 2: Подсчёт уникальных email
function normalizeEmail(email) {
    let [local, domain] = email.split('@');
    local = local.split('+')[0].replace(/\./g, '');
    return `${local}@${domain}`;
}

function task2() {
    const emails = [
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru"
    ];

    const unique = new Set(emails.map(normalizeEmail));
    console.log("Уникальных адресов:", unique.size);
}

// Задание 3: Подсчёт серий чисел
function task3() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    rl.question('Введите строку чисел: ', (line) => {
        if (!line.trim()) {
            console.log('Серий: 0');
            rl.close();
            return;
        }

        const numbers = line.trim().split(/\s+/).map(Number);
        let count = 0;

        if (numbers.length > 0) {
            count = 1; // Первая серия
            let prev = numbers[0];

            for (let i = 1; i < numbers.length; i++) {
                const curr = numbers[i];
                if (curr < prev) {
                    count++;
                }
                prev = curr;
            }
        }

        console.log(`Серий: ${count}`);
        rl.close();
    });
}

// Главное меню для выбора задания
function main() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    function menu() {
        console.log("\nВыберите задание:");
        console.log("1 - Проверка движения по доске");
        console.log("2 - Подсчёт уникальных email");
        console.log("3 - Подсчёт серий чисел");
        console.log("0 - Выход");
        rl.question("Ваш выбор: ", (choice) => {
            switch (choice) {
                case '1': task1(); break;
                case '2': task2(); break;
                case '3': task3(); break;
                case '0': 
                    console.log("Выход...");
                    rl.close();
                    return;
                default: 
                    console.log("Неверный выбор!");
                    menu();
                    break;
            }
        });
    }

    menu();
}

main();

