use std::cmp::{min, max};
use std::collections::HashSet;
use std::io::{self, Write};

fn task1() {
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let dims: Vec<usize> = input
        .split_whitespace()
        .filter_map(|x| x.parse().ok())
        .collect();

    if dims.len() != 2 {
        println!("No");
        return;
    }

    let n = dims[0];
    let m = dims[1];

    if n <= 0 || m <= 0 {
        println!("No");
        return;
    }

    input.clear();
    io::stdin().read_line(&mut input).unwrap();
    let s = input.trim();

    if !s.chars().all(|c| "LRUD".contains(c)) {
        println!("No");
        return;
    }

    let mut min_x = 0;
    let mut max_x = 0;
    let mut min_y = 0;
    let mut max_y = 0;
    let mut x = 0;
    let mut y = 0;

    for move_char in s.chars() {
        match move_char {
            'L' => x -= 1,
            'R' => x += 1,
            'D' => y += 1,
            'U' => y -= 1,
            _ => {}
        }
        min_x = min(min_x, x);
        max_x = max(max_x, x);
        min_y = min(min_y, y);
        max_y = max(max_y, y);
    }

    if max_x - min_x < m && max_y - min_y < n {
        println!("({}, {})", 1 - min_y, 1 - min_x);
    } else {
        println!("No");
    }
}

fn normalize_email(email: &str) -> String {
    let parts: Vec<&str> = email.split('@').collect();
    let mut local = parts[0].split('+').next().unwrap().replace(".", "");
    let domain = parts[1];
    format!("{}@{}", local, domain)
}

fn task2() {
    let emails = vec![
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru",
    ];

    let unique: HashSet<String> = emails.iter().map(|e| normalize_email(e)).collect();
    println!("Уникальных адресов: {}", unique.len());
}

fn task3() {
    let mut line = String::new();
    io::stdin().read_line(&mut line).unwrap();
    let line = line.trim();

    if line.is_empty() {
        println!("Серий: 0");
        return;
    }

    let numbers: Vec<i32> = line
        .split_whitespace()
        .filter_map(|s| s.parse::<i32>().ok())
        .collect();

    if numbers.is_empty() {
        println!("Серий: 0");
        return;
    }

    let mut count = 1;
    let mut prev = numbers[0];

    for &curr in &numbers[1..] {
        if curr < prev {
            count += 1;
        }
        prev = curr;
    }

    println!("Серий: {}", count);
}

fn main() {
    loop {
        println!("Выберите задание:");
        println!("1 - Проверка движения по доске");
        println!("2 - Подсчёт уникальных email");
        println!("3 - Подсчёт серий чисел");
        println!("0 - Выход");

        let mut choice = String::new();
        io::stdin().read_line(&mut choice).unwrap();
        let choice = choice.trim();

        match choice {
            "1" => {
                println!("Вы выбрали задание 1: Проверка движения по доске");
                task1();
            }
            "2" => {
                println!("Вы выбрали задание 2: Подсчёт уникальных email");
                task2();
            }
            "3" => {
                println!("Вы выбрали задание 3: Подсчёт серий чисел");
                task3();
            }
            "0" => {
                println!("Выход...");
                break;
            }
            _ => println!("Неверный выбор!"),
        }
    }
}
