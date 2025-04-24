#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <set>
#include <cctype>
#include <limits>
#include <algorithm>

using namespace std;

// Задание 1: Проверка на выход за границы доски
void task1() {
    int N, M;
    string S;
    cout << "Введите размеры доски и строку команд (пример: 3 3 RRD): ";
    cin >> N >> M >> S;

    if (N <= 0 || M <= 0) {
        cout << "No" << endl;
        return;
    }

    for (char c : S) {
        if (c != 'L' && c != 'R' && c != 'D' && c != 'U') {
            cout << "No" << endl;
            return;
        }
    }

    int minX = 0, maxX = 0, minY = 0, maxY = 0;
    int x = 0, y = 0;

    for (char move : S) {
        if (move == 'L') x--;
        if (move == 'R') x++;
        if (move == 'D') y++;
        if (move == 'U') y--;
        minX = min(minX, x);
        maxX = max(maxX, x);
        minY = min(minY, y);
        maxY = max(maxY, y);
    }

    if (maxX - minX < M && maxY - minY < N) {
        cout << "Yes: (" << 1 - minY << ", " << 1 - minX << ")" << endl;
    } else {
        cout << "No" << endl;
    }
}

// Задание 2: Подсчёт уникальных email
void task2() {
    vector<string> emails = {
        "mar.pha+science@corp.nstu.ru",
        "marpha+scie.nce@corp.nstu.ru",
        "marph.a+s.c.i.e.n.c.e+@corp.nstu.ru",
        "mar.pha+science@co.rp.nstu.ru"
    };

    auto normalizeEmail = [](const string& email) {
        size_t at_pos = email.find('@');
        string local = email.substr(0, at_pos);
        string domain = email.substr(at_pos);
        string normalized;
        for (char ch : local) {
            if (ch == '+') break;
            if (ch != '.') normalized += ch;
        }
        return normalized + domain;
    };

    set<string> uniqueEmails;
    for (const auto& email : emails) {
        uniqueEmails.insert(normalizeEmail(email));
    }

    cout << "Уникальных адресов: " << uniqueEmails.size() << endl;
}

// Задание 3: Подсчёт серий чисел
void task3() {
    cin.ignore(numeric_limits<streamsize>::max(), '\n'); // очистка ввода
    cout << "Введите числа через пробел: ";
    string line;
    getline(cin, line);

    if (line.empty()) {
        cout << "Серий: 0" << endl;
        return;
    }

    istringstream iss(line);
    int curr, prev;
    int count = 0;

    if (iss >> prev) {
        count = 1;
        while (iss >> curr) {
            if (curr < prev) count++;
            prev = curr;
        }
    }

    cout << "Серий: " << count << endl;
}

int main() {
    while (true) {
        cout << "\nВыберите задание:\n";
        cout << "1 - Проверка движения по доске\n";
        cout << "2 - Подсчёт уникальных email\n";
        cout << "3 - Подсчёт серий чисел\n";
        cout << "0 - Выход\n";
        cout << "Ваш выбор: ";

        int choice;
        cin >> choice;

        switch (choice) {
            case 1: task1(); break;
            case 2: task2(); break;
            case 3: task3(); break;
            case 0: cout << "Выход...\n"; return 0;
            default: cout << "Неверный выбор!\n"; break;
        }
    }
}
