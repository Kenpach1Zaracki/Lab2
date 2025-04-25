use std::io::{self, Write};

// Задание 1: Проверка движения по доске
fn task1() {
    let mut input = String::new();
    println!("Введите размеры доски и строку команд (пример: 3 3 RRD):");
    io::stdin().read_line(&mut input).unwrap();
    let parts: Vec<&str> = input.trim().split_whitespace().collect();

    if parts.len() != 3 {
        println!("No");
        return;
    }

    let n: i32 = parts[0].parse().unwrap_or(0);
    let m: i32 = parts[1].parse().unwrap_or(0);
    let s = parts[2];

    if n <= 0 || m <= 0 || !s.chars().all(|c| "LRDU".contains(c)) {
        println!("No");
        return;
    }

    let (mut x, mut y) = (0, 0);
    let (mut min_x, mut max_x) = (0, 0);
    let (mut min_y, mut max_y) = (0, 0);

    for c in s.chars() {
        match c {
            'L' => x -= 1,
            'R' => x += 1,
            'U' => y -= 1,
            'D' => y += 1,
            _ => {}
        }
        min_x = min_x.min(x);
        max_x = max_x.max(x);
        min_y = min_y.min(y);
        max_y = max_y.max(y);
    }

    if max_x - min_x < m && max_y - min_y < n {
        println!("Yes: ({}, {})", 1 - min_y, 1 - min_x);
    } else {
        println!("No");
    }
}

// Задание 2: Подсчёт уникальных email
fn task2() {
    let emails = vec![
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru",
    ];

    let mut unique = std::collections::HashSet::new();

    for email in emails {
        if let Some(at_pos) = email.find('@') {
            let (local, domain) = email.split_at(at_pos);
            let local_clean: String = local
                .chars()
                .take_while(|&c| c != '+')
                .filter(|&c| c != '.')
                .collect();
            let normalized = format!("{}{}", local_clean, domain);
            unique.insert(normalized);
        }
    }

    println!("Уникальных адресов: {}", unique.len());
}

// Задание 3: Подсчёт серий чисел
fn task3() {
    println!("Введите количество чисел:");

    // Вводим количество чисел
    let mut n_input = String::new();
    io::stdin().read_line(&mut n_input).unwrap();

    let n: usize = n_input.trim().parse().unwrap_or(0);
    if n == 0 {
        println!("Серий: 0");
        return;
    }

    println!("Введите числа по одному:");

    let mut count = 1; // Начинаем с первой серии
    let mut prev = None; // Храним предыдущее число

    for _ in 0..n {
        let mut num_input = String::new();
        io::stdin().read_line(&mut num_input).unwrap();
        let num: i32 = num_input.trim().parse().unwrap_or(0);

        if let Some(last) = prev {
            if num < last {
                count += 1; // новая серия
            }
        }

        prev = Some(num); // сохраняем предыдущее число
    }

    println!("Серий: {}", count);
}

// Главное меню
fn main() {
    loop {
        println!("\nВыберите задание:");
        println!("1 - Проверка движения по доске");
        println!("2 - Подсчёт уникальных email");
        println!("3 - Подсчёт серий чисел");
        println!("0 - Выход");

        print!("Ваш выбор: ");
        io::stdout().flush().unwrap();

        let mut choice = String::new();
        if io::stdin().read_line(&mut choice).is_err() {
            continue;
        }

        match choice.trim() {
            "1" => task1(),
            "2" => task2(),
            "3" => task3(),
            "0" => {
                println!("Выход...");
                break;
            }
            _ => println!("Неверный выбор!"),
        }
    }
}
