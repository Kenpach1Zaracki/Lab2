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
bool isValidUsername(const string& username) {
    if (username.length() < 6 || username.length() > 30) return false;
    if (username.front() == '.' || username.back() == '.') return false;

    for (size_t i = 0; i < username.size(); ++i) {
        char c = username[i];

        if (!(islower(c) || isdigit(c) || c == '.')) {
            return false;
        }

        if (c == '.' && i + 1 < username.size() && username[i + 1] == '.') {
            return false;
        }
    }

    return true;
}

string normalizeUsername(const string& raw) {
    string result;
    for (char c : raw) {
        if (c == '*') break;
        if (c == '.') continue;
        result += c;
    }
    return result;
}

void task2() {
    vector<string> emails = {
        "mar.pha*science@corp.nstu.ru",
        "marpha*sci.ence@corp.nstu.ru",
        "ma..rph.a*science@corp.nstu.ru",
        "mar.pha*science@co.rp.nstu.ru"
    };

    set<string> uniqueEmails;

    for (const auto& email : emails) {
        size_t at = email.find('@');
        if (at == string::npos) continue;

        string user = email.substr(0, at);
        string domain = email.substr(at);

        if (!isValidUsername(user)) continue;

        string normalized = normalizeUsername(user) + domain;
        uniqueEmails.insert(normalized);
    }

    cout << "Уникальных адресов: " << uniqueEmails.size() << endl;
}

// Задание 3: Подсчёт серий чисел
void task3() {
    int n;
    cout << "Введите количество чисел: ";
    cin >> n; // Вводим количество чисел

    if (n <= 0) {
        cout << "Серий: 0" << endl; // Если количество чисел меньше или равно нулю
        return;
    }

    int prev, curr;
    int count = 1; // Начинаем с первой серии

    cout << "Введите " << n << " чисел: ";
    
    // Вводим первое число
    cin >> prev;

    for (int i = 1; i < n; ++i) {
        cin >> curr;  // Вводим следующее число
        if (curr < prev) {
            count++;  // Если текущее число меньше предыдущего, увеличиваем счётчик серий
        }
        prev = curr;  // Обновляем предыдущее число
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
